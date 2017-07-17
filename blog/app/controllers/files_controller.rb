class FilesController < ApplicationController	

	POST_ID = 0 
	TITLE = 1
	STATUS = 2

	def new
	end

	def compute

		file_path = params[:file].path
		xls_file = Spreadsheet.open(file_path) #open xls file

		# xls_file.sheets =>  sheets array containing there name  
		default_sheet = xls_file.worksheet("Sheet1")
		bulk_update_hash = {}
		row_no_hash = {}
		@rows = []

		default_sheet.each_with_index do |row,index|

			next if index == 0
			break if index == 6

			row_no_hash[row[POST_ID]] = index

			bulk_update_hash[row[POST_ID]] = {
					title: row[TITLE]
			}

			if index%5 == 0 
					puts bulk_update_hash
					result_array = Post.update(bulk_update_hash.keys,bulk_update_hash.values)
          update_sheet_query_status(bulk_update_hash, default_sheet, row_no_hash)
					bulk_update_hash.clear
			end
			puts "#{index} ---------index" 
			@rows << row
		end

		x = xls_file.write "Final Result.xls"
		puts x
	end

	private

	def update_sheet_query_status bulk_update_hash,default_sheet,row_no_hash
		
		bulk_posts = Post.where(:id => bulk_update_hash.keys)
		bulk_posts.each do |post|
			trip_hash = bulk_update_hash[post.id]
			trip_id_row_no = row_no_hash[post.id]
			default_sheet[trip_id_row_no,2] = trip_hash[:title] == post.title ? "success" : "not updated"
		end
	end
end