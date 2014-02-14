class AddSupportsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :supports_count, :integer
  end
end
