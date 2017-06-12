class Post < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

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
  validates :content,presence: true, length: {minimum: 10}
  
  validates :user ,:presence => true

  accepts_nested_attributes_for :picture ,:reject_if => :all_blank,
   :allow_destroy => true

  # accepts_nested_attributes_for :tags
  # accepts_nested_attributes_for :posts_tags,:reject_if => :all_blank,
  #   :allow_destroy => true
  # elasticsearch
  # make underrscore lowercase form
  # index_name[base_class.to_s.pluralize.underscore]

  #update elasticsearch index on new entry to db
  after_save { 
    puts "after save called ---------------" 
    ElasticSearchIndexWorker.perform_async(:index,  self.id) 
  }

  #update elasticsearch index after deletion of entry in db
  after_destroy { 
    puts "after destroy called"
    ElasticSearchIndexWorker.perform_async(:delete, self.id) 
  }

  mapping dynamic: 'false' do
 
    indexes :content , type: 'string'
    indexes :title , type: 'string'
    indexes :name , type: 'string'

    indexes :comments do 
      indexes :body , type: 'string'
    end

    indexes :tags do 
      indexes :name,type: 'string'
    end
  end

  #index all these columns of models
  def as_indexed_json(options={})
    
    self.as_json(
      only: [:content,:title,:name], 
      include:{
        comments: { only: [:body]},
        tags: {only: [:name]}
      }
    )
  end

  def self.search query
    Post.__elasticsearch__.search(
      query: {
        multi_match: {
            query: query,
            fields: ["title","content","name","comments.body","tags.name"],
            type: "best_fields"
        }
      }
      )
  end


  # bulk inserting 
  def self.import_elasticsearch
    Post.find_in_batches({:batch_size => 1000}) { |posts| bulk_index(posts) }
  end

  def self.bulk_index(posts)
  Post.__elasticsearch__.client.bulk({
       index: ::Post.__elasticsearch__.index_name,
       type: ::Post.__elasticsearch__.document_type,
       body: prepare_records(posts)
   })
  end

  def self.prepare_records(posts)
   posts.map do |post|
     { index: { _id: post.id, data: post.as_indexed_json } }
   end
  end
end
