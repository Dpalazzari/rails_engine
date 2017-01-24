class RemoveTimestampsFromMerchants < ActiveRecord::Migration[5.0]
  def change
    remove_column :merchants, :created_at
    remove_column :merchants, :updated_at
  end
end
