class Tag < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :posts_tags
  has_many :posts , through: :posts_tags


  index_name([Rails.env,base_class.to_s.pluralize.underscore].join('_'))

  def self.search query

  	Tag.__elasticsearch__.search query
  end

end
