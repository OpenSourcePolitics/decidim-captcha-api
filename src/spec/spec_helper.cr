require "spec"
require "../core"
require "http/client"

def api_response(locale = nil)
  path = locale.nil? ? host : "#{host}?locale=#{locale}"

  HTTP::Client.get(path)
end

def host
  "http://localhost:8080/"
end
