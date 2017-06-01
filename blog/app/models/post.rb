class Post < ActiveRecord::Base

  # it whitelist attributes that could be updated in bulk 
  attr_accessible :content, :name, :title , :tag_ids ,:picture_attributes

  has_many :posts_tags , dependent: :destroy
  has_many :tags, through: :posts_tags
  has_many :comments , dependent: :destroy
  
  has_one :picture , as: :imageable , dependent: :destroy

  belongs_to :user
  
  # attr_accessible :posts_tags_attributes
  # validation on field when putting them in DB through model
  validates :name, :presence => true
  validates	:title, :presence => true,
  						:length =>  {
  							:minimum => 5
  						} 
  
  validates :user ,:presence => true

  accepts_nested_attributes_for :picture ,:reject_if => :all_blank,
   :allow_destroy => true

  # accepts_nested_attributes_for :tags
  # accepts_nested_attributes_for :posts_tags,:reject_if => :all_blank,
  #   :allow_destroy => true


  # elasticsearch
  # make underrscore lowercase form
  # index_name[base_class.to_s.pluralize.underscore]

  # mappings do
    
  # end


  # #index all these columns of models
  # def as_indexed_json
   
  #   self.as_json(only: [:content,:title,:name], include:{
  #       comments: { only: [:body]},
  #       tags: {only: [:name]}
  #     })
  # end

end
