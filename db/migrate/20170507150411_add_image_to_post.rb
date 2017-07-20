class AddImageToPost < ActiveRecord::Migration
  def change
  	 add_attachment :posts, :post_image
  	 remove_column :posts, :image_url
  end
end
