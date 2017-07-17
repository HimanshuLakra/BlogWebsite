class Employee < ActiveRecord::Base
  attr_accessible :name

  has_many :subordinates , class_name: :Employee,
  							foreign_key: :manager_id

  belongs_to :manager , class_name: :Employee
end
