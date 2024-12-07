# config/initializers/openai.rb
require "openai"

# Configuración opcional (si necesitas una configuración global)
OpenAI.configure do |config|
  config.access_token = ENV["OPENAI_ACCESS_TOKEN"] # Coloca tu token en una variable de entorno
  config.log_errors= true
end
