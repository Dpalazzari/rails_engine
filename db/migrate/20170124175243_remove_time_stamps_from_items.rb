class RemoveTimeStampsFromItems < ActiveRecord::Migration[5.0]
  def change
  	remove_column :items, :created_at
  	remove_column :items, :updated_at
  end
end
