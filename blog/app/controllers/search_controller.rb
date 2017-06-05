class SearchController < ApplicationController

	
	layout "search_layout" , only: [:index]

	def search_posts

	    @posts = []

		unless params[:query].blank?
		 @response = Tag.search params[:query]
		 @response.records.map { |tag| 
		 	tag.posts.each do |post|
		 		@posts << post
		 	end
		  }

		 @unique_posts = @posts.uniq!
		 @posts = @unique_posts if !@unique_posts.nil?
		end

		@query = params[:query]
	end

	def index 
	end
end