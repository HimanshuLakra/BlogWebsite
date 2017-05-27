class SearchController < ApplicationController

	def search_posts
		#binding.pry
		unless params[:query].blank?
		 @response = Tag.search params[:query]
		 @posts = []
		 @response.records.map { |tag| 
		 	tag.posts.each do |post|
		 		@posts << post
		 	end
		  }
		end

		@posts = @posts.uniq!
	end
end