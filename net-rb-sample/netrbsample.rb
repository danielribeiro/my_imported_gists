require 'net/http'
require 'pp'
uri = URI.parse("inserturlhere")
begin
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    # uncomment this to make it work
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE 

    request = Net::HTTP::Get.new(uri.request_uri)

    pp http.request(request)
rescue Exception => e
    puts e, e.class
end