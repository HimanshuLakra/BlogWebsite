class Tag < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  attr_accessible :name

  has_many :posts_tags
  has_many :posts , through: :posts_tags


  index_name([Rails.env,base_class.to_s.pluralize.underscore].join('_'))

  # mappings do 
  #   indexes: :id, type: :integer
  # end

  def self.search query

  	Tag.__elasticsearch__.search query
  	# 		query: {
  	# 			multi_match: {
  	# 				"query":    query, 
    #    				"fields": ["name"] 
  	# 			}
  	# 		}
  	# 	)
  end

  #override method to tell which field you want to index in es
  # def as_indexed_json
  # end
end
