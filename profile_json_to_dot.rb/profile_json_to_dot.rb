require 'json'
require 'set'


class ProfileConverter
  def initialize(profile, io=$stdout, time_threshold=0.01)
    @profile = profile
    @io = io
    @time_threshold = time_threshold
  end

  def run
    @io.puts('digraph profile {')
    @profile['thread_profiles'].each_with_index do |thread_profile, index|
      converter = ThreadProfileConverter.new(thread_profile, index, @io, @time_threshold)
      converter.run
    end
    @io.puts('}')
  end
end

class ThreadProfileConverter
  def initialize(thread_profile, thread_id, io, time_threshold)
    @thread_profile = thread_profile
    @thread_id = thread_id.to_s
    @io = io
    @time_threshold = time_threshold
    @methods = select_methods
    @selected_method_ids = @methods.map { |m| m['id'] }.to_set
    @indent = '  '
  end

  def run
    @methods.each { |m| convert_method(m) } 
  end

  def convert_method(m)
    print_method(m)
    print_callers(m)
  end

  def print_method(method)
    id, name, total_calls, total_time, self_time, child_time, parents = method.values_at('id', 'name', 'total_calls', 'total_time', 'self_time', 'child_time', 'parents')
    thread_total_time = @thread_profile['total_time']
    scale = 0.5 + 4 * Math.sqrt(self_time/thread_total_time)
    total_time_percentage = total_time/thread_total_time
    self_time_percentage = self_time/thread_total_time
    child_time_percentage = child_time/thread_total_time
    if id == '0'
      @io.puts('%s"%s_%s" [label="(%s)\n%.3fs"];' % [@indent, @thread_id, id, @thread_profile['thread_name'], thread_total_time])
    else
      text_size = 12 * scale
      name_size = 18 * scale
      name = name.gsub('&', '&amp;').gsub('>', '&gt;').gsub('<', '&lt;')
      label = (<<-HTML).gsub(/^\s+|\n/, '')
        <TABLE BORDER="1" CELLBORDER="0" CELLSPACING="0" CELLPADDING="3">
          <TR><TD ALIGN="CENTER" COLSPAN="3"><FONT POINT-SIZE="#{name_size}">#{name}</FONT></TD></TR>
          <HR/>
          <TR><TD ALIGN="LEFT">calls</TD><TD ALIGN="RIGHT" COLSPAN="2">#{format_calls(total_calls)}</TD></TR>
          <TR><TD ALIGN="LEFT">total</TD><TD ALIGN="RIGHT">#{format_time(total_time)}</TD><TD ALIGN="RIGHT">(#{format_percentage(total_time_percentage)})</TD></TR>
          <TR><TD ALIGN="LEFT">self</TD><TD ALIGN="RIGHT">#{format_time(self_time)}</TD><TD ALIGN="RIGHT">(#{format_percentage(self_time_percentage)})</TD></TR>
          <TR><TD ALIGN="LEFT">child</TD><TD ALIGN="RIGHT">#{format_time(child_time)}</TD><TD ALIGN="RIGHT">(#{format_percentage(child_time_percentage)})</TD></TR>
        </TABLE>
      HTML
      params = [@indent, @thread_id, id, text_size, label]
      @io.puts('%s"%s_%s" [fontsize="%d", shape="none", label=<%s>];' % params)
    end
  end

  def print_callers(method)
    id, parents = method.values_at('id', 'parents')
    parents.each do |parent|
      parent_id = parent['id']
      if included_method?(parent_id)
        parent_calls = format_calls(parent['total_calls'])
        parent_time = format_time(parent['total_time'])
        @io.puts('%s"%s_%s" -> "%s_%s" [fontsize="12", label="%s / %s"];' % [@indent, @thread_id, parent_id, @thread_id, id, parent_calls, parent_time])
      end
    end
    ancestors = parents.flat_map do |parent|
      if included_method?(parent['id'])
        []
      else
        find_selected_ancestors(parent)
      end
    end
    ancestors = ancestors.group_by { |a| a['id'] }
    ancestors.each do |ancestor_id, ancestors|
      ancestor_time = ancestors.reduce(0) { |sum, a| sum + a['total_time'] }
      ancestor_time = format_time(ancestor_time)
      @io.puts('%s"%s_%s" -> "%s_%s" [style="dotted", fontsize="12", label="%s"];' % [@indent, @thread_id, ancestor_id, @thread_id, id, ancestor_time])
    end
  end

  def format_calls(n)
    n.to_s.gsub(/(?<=\d)(?=(\d\d\d)+(?!\d))/, ',')
  end

  def format_time(n)
    "#{n.round(3)}s"
  end

  def format_percentage(n)
    "#{(n * 100).round(1)}%"
  end

  def included_method?(id)
    @selected_method_ids.include?(id)
  end

  def select_methods
    total_time = @thread_profile['total_time']
    @thread_profile['methods'].select do |m|
      m['total_time']/total_time > @time_threshold
    end
  end

  def find_method(id)
    @thread_profile['methods'].find { |m| m['id'] == id }
  end

  def find_selected_ancestors(m, visited_method_ids=Set.new)
    method = find_method(m['id'])
    method['parents'].flat_map do |parent|
      if included_method?(parent['id'])
        visited_method_ids << parent['id']
        [parent]
      elsif !visited_method_ids.include?(parent['id'])
        visited_method_ids << parent['id']
        find_selected_ancestors(parent, visited_method_ids)
      else
        []
      end
    end
  end
end

if $0 == __FILE__
  converter = ProfileConverter.new(JSON.load(ARGF))
  converter.run
end
