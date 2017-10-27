class AddingUserToCampaignsContactsAndTags < ActiveRecord::Migration[5.1]
  def change
    add_reference :campaigns, :user
    add_reference :contacts, :user
    add_reference :tags, :user
  end
end
