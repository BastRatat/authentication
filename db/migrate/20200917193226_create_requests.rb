class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :request_type
      t.string :description
      t.string :location
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
