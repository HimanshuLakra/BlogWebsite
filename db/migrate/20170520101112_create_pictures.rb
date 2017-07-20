class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|

    	t.string :name
    	t.references :imageable, polymorphic: true, index: true
      	t.timestamps
    end

    add_attachment :pictures, :image
    remove_attachment :posts , :post_image

  end
end
