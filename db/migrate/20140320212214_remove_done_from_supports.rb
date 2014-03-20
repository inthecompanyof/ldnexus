class RemoveDoneFromSupports < ActiveRecord::Migration
  def change
    remove_column :supports, :done
  end
end
