require "http/server"
require "json"
require "./core"

DEFAULT_LOCALE = "en"
HOST = ENV.has_key?("HOST") ? ENV["HOST"] : "0.0.0.0"
PORT = ENV.has_key?("PORT") ? ENV["PORT"].to_i : 8080
LOCALES_DIR = ENV.has_key?("LOCALES_DIR") ? ENV["LOCALES_DIR"] : "**/locales"

core = Core.new(LOCALES_DIR, DEFAULT_LOCALE)
abort("No locales found in path !", 1) unless core.locales_loaded?

server = HTTP::Server.new do |context|
  params = context.request.query_params
  locale = params["locale"]? ? params["locale"] : DEFAULT_LOCALE

  context.response.content_type = "application/json"
  context.response.print core.question_and_answers(locale).to_json
end

address = server.bind_tcp(HOST, PORT)

puts "Listening on http://#{address}"
server.listen
