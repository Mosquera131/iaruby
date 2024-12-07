class CreateResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :responses do |t|
      t.references :form, null: false, foreign_key: true
      t.string :ai_response
      t.string :text
      t.integer :status

      t.timestamps
    end
  end
end
