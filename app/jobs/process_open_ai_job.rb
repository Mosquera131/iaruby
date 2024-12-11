

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
