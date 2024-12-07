require "openai"

class OpenService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
  end

  def generate_and_store_response(form)
    begin
      # Llamar a la API de OpenAI para generar la respuesta
      response = @client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: [ { role: "user", content: form.description } ],
          temperature: 0.7,
          max_tokens: 150
        }
      )

      # Extraer el contenido generado
      content = response.dig("choices", 0, "message", "content")
      raise "No se obtuvo respuesta válida de OpenAI" if content.nil?

      # Crear la respuesta asociada al formulario
      form.create_response!(
        text: form.description,
        ai_response: content,
        status: "completed"
      )

      content # Retornar la respuesta generada
    rescue => e
      # Manejo de errores
      Rails.logger.error("Error al generar la respuesta: #{e.message}")
      form.create_response!(
        text: form.description,
        ai_response: "Error al generar la respuesta: #{e.message}",
        status: "failed"
      )
      nil
    end
  end
end
