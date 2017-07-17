class AddIndexesInPostTags < ActiveRecord::Migration
 
  def up
  	add_index :posts_tags, [:post_id,:tag_id]
  end

  def down
  	remove_index :posts_tags,[:post_id,:tag_id]
  end
end
