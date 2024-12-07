require "openai"

class OpenService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
  end

  # Genera un texto basado en el description proporcionado
  def generate_and_store_response(description)
    begin

      Rails.logger.info("#{description}")
      # Llama a la API de OpenAI con las instrucciones y el límite de longitud
      response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [ { role: "user", content: description } ],
          temperature: 0.7,
          max_tokens: 50 # max_tokens controla la longitud del texto generado
        }
      )

      # Extrae el contenido de la respuesta
      content = response.dig("choices", 0, "message", "content")
      raise "No se obtuvo contenido en la respuesta de OpenAI" if content.nil?

      content
    rescue => e
      puts "Error: #{e.message}"
      nil
    end
  end
end
