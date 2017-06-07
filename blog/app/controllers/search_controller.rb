class SearchController < ApplicationController

	
	layout "search_layout" , only: [:index]

	def search_posts

	    @posts = []

		unless params[:query].blank?
		 @response = Post.search params[:query]
		 @response.records.map { |post| 
		 	@posts << post
		  }
		  
		 @unique_posts = @posts.uniq!
		 @posts = @unique_posts if !@unique_posts.nil?
		end

		@query = params[:query]
	end

	def index 
	end
end