class ElasticSearchIndexWorker
	include Sidekiq::Worker

	# name: of funtion
	# id : record_id
	def perform(name, id)

		case name.to_s
		 	when "index"
		 		puts "indexing new document #{id}sidekiq ---------------------------"
		 		begin
					record = Post.find(id)
					record.__elasticsearch__.index_document
					puts "indexed new document sidekiq #{id}---------------------------"
		 		rescue ActiveRecord::RecordNotFound
		 			puts "record #{id} not found"
				end	
		 	when "delete"
		 		puts "deleting index of document number #{id}--------------------------------"
		 		client = Post.__elasticsearch__.client
				client.delete index: Post.index_name, type: Post.model_name.to_s.downcase, id: id
				puts "deleted index #{id}"
		end		
  	end
end