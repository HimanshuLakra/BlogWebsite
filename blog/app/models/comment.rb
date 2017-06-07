class Comment < ActiveRecord::Base
 
 	include ActiveModel::ForbiddenAttributesProtection
 	
	belongs_to :post
	belongs_to :user

	#self_join : comment has many replies and comment has one parent comment
	has_many :replies , class_name: "Comment" , foreign_key: "parent_id", dependent: :destroy
	belongs_to :parent_comment , class_name: "Comment"

	validates :body , presence: true ,
						length: {
							minimum: 5
						}

	validates :post , presence: true , unless: :parent_id
	validates :user , presence: true


end
