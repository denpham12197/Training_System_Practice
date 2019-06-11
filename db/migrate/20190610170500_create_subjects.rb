class CreateSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :description
      t.string :detail
      t.date :start_date
      t.date :end_date
      t.string :status
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
