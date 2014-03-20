class AddStateToSupports < ActiveRecord::Migration
  class Support < ActiveRecord::Base
  end

  def up
    add_column :supports, :state, :string, default: 'pending'

    say_with_time 'Updating existing records...' do
      Support.where(done: true).update_all(state: 'done')
    end
  end

  def down
    say_with_time 'Updating existing records...' do
      Support.where(state: 'done').update_all(done: true)
    end

    remove_column :supports, :state
  end
end
