require "spec"
require "../core"
require "http/client"

def api_response(route = nil)
  HTTP::Client.get("http://localhost:8080/#{route}")
end
