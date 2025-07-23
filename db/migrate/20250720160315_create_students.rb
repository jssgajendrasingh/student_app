class CreateStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :email
      t.string :phone_no
      t.text :address

      t.timestamps
    end
  end
end
