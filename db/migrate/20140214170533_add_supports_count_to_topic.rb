class AddSupportsCountToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :supports_count, :integer
  end
end
