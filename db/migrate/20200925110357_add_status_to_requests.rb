class AddStatusToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :status, :string, default: "unfulfilled"
  end
end
