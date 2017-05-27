class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:picture_attributes
  # attr_accessible :title, :body

  has_many :posts
  has_many :comments 

  has_one :picture , as: :imageable
  accepts_nested_attributes_for :picture , allow_destroy: :true,:reject_if => :all_blank 
  
end
