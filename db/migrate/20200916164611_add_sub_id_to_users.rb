class AddSubIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sub_id, :string
  end
end
