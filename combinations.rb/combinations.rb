  def combinations(s, k)
    return [[]] if k == 0
    if k == 1
      return s.map { |x| [x] }
    end
    ret = []
    n = s.size
    for i in (0..(n - k))
      f = s[i]
      split = s[(i + 1)..-1]
      for c in combinations(split, k - 1)
        ret << [f] + c
      end
    end
    ret
  end