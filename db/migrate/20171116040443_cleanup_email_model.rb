class CleanupEmailModel < ActiveRecord::Migration[5.1]
  def change
    remove_column :emails, :clicks
    remove_column :emails, :opened_times
  end
end
