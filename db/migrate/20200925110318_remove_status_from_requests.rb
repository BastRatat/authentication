class RemoveStatusFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :status, :boolean
  end
end
