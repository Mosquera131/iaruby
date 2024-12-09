

class ProcessOpenAiJob < ApplicationJob
  queue_as :default

  def perform(form_id)
    form = Form.find(form_id)
    service = OpenService.new

    # Generar y almacenar la respuesta
    response = service.generate_and_store_response(form)

    # Enviar el correo si cumple las condiciones
    if response.present? && form.processed_in_job == "Job Encolado"
      Rails.logger.info("Enviando correo a #{form.email}")
      UserMailer.response_ready(form.email, response).deliver_now
    else
      Rails.logger.warn("No se pudo enviar el correo para el formulario #{form.id}")
    end
  end
end


# class ProcessOpenAiJob < ApplicationJob
#   queue_as :default

#   def perform(request_id)
#     # Buscar la solicitud
#     request = Request.find(request_id)

#     # Enviar la solicitud a OpenAI
#     response = OpenAI::Client.new.completions(
#       model: "text-davinci-003",
#       prompt: request.prompt,
#       max_tokens: 100
#     )

#     # Guardar la respuesta en la tabla responses
#     request.responses.create(content: response["choices"].first["text"])

#     # Notificar al usuario
#     UserMailer.response_ready(request.user).deliver_now
#   end
# end
