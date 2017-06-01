class SearchController < ApplicationController

	
	layout "search_layout" , only: [:index]

	def search_posts
		unless params[:query].blank?
		 @response = Tag.search params[:query]
		 @posts = []
		 @response.records.map { |tag| 
		 	tag.posts.each do |post|
		 		@posts << post
		 	end
		  }

		 @posts = @posts.uniq!
		end

		@query = params[:query]
	end

	def index 
	end
end