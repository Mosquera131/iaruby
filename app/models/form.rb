class Form < ApplicationRecord
  has_one  :response, dependent: :destroy
  has_one_attached :avatar

  # validaciones
  validates :name, presence: true
  validates :description, presence: true
  validates :processed_in_job, inclusion: { in: [ "Hilo Principal", "Job Encolado" ] }

  # Callback para encolar el Job si "Job Encolado" fue seleccionado
  after_create :enqueue_job_if_selected

  private

  def enqueue_job_if_selected
    if processed_in_job == "Job Encolado"
      ProcessOpenAiJob.perform_later(self.id)
    end
  end
end
