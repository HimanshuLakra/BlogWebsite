class CreateEmployees < ActiveRecord::Migration
  def up
    create_table :employees do |t|
      t.text :name
      t.references :manager
      t.references :subordinates
      t.timestamps
    end
  end

  def down
  	drop_table :employees
  end
end
