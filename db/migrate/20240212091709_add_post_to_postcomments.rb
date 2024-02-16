class AddPostToPostcomments < ActiveRecord::Migration[7.1]
  def change
     add_reference :postcomments, :post, foreign_key: true, default: 1
  end
end
