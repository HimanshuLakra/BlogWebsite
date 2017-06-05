class Picture < ActiveRecord::Base
  
  attr_accessible :image

  belongs_to :imageable,polymorphic: :true

  has_attached_file :image

  validates_attachment :image,
                        content_type: { content_type: ["image/jpeg" ,"image/png","image/gif"]},
                        size: { in: 0..5000.megabytes }
end
