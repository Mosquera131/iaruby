class Form < ApplicationRecord
  has_one  :response, dependent: :destroy

  # validaciones
  validates :name, presence: true
  validates :description, presence: true
  validates :processed_in_job, inclusion: { in: [ "Hilo Principal", "Job Encolado" ] }
end
