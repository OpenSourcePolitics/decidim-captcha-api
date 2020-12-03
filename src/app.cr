require "http/server"
require "json"
require "./core"

DEFAULT_LOCALE = "en"
DEFAULT_HOST   = "0.0.0.0"
DEFAULT_PORT   = 8080

core = Core.new("**/locales", DEFAULT_LOCALE)
abort("No locales found in path !", 1) unless core.locales_loaded?

server = HTTP::Server.new do |context|
  params = context.request.query_params
  locale = params["locale"]? ? params["locale"] : DEFAULT_LOCALE

  context.response.content_type = "application/json"
  context.response.print core.question_and_answers(locale).to_json
end

host = ENV.has_key?("HOST") ? ENV["HOST"] : DEFAULT_HOST
port = ENV.has_key?("PORT") ? ENV["PORT"].to_i : DEFAULT_PORT
address = server.bind_tcp(host, port)

puts "Listening on http://#{address}"
server.listen
