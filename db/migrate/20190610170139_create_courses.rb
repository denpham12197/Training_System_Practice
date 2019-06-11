class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :detail
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
