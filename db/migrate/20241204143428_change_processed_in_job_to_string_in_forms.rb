class ChangeProcessedInJobToStringInForms < ActiveRecord::Migration[7.2]
  def change
    change_column :forms, :processed_in_job, :string
  end
end
