class RemoveSentTimesFromEmails < ActiveRecord::Migration[5.1]
  def change
    remove_column :emails, :sent_times
  end
end
