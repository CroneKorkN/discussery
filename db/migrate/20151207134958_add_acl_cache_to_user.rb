class AddAclCacheToUser < ActiveRecord::Migration
  def change
    add_column :users, :acl_cache, :text
  end
end
