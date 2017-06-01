class PostsTag < ActiveRecord::Base
 
 attr_accessible :post_id, :tag_id
 # attr_accessible :tag_attributes

 belongs_to :post
 belongs_to :tag

 validates :post , presence: true
 validates :tag , presence: true

 # accepts_nested_attributes_for :tag,
 #                                :reject_if => :all_blank
 
end

