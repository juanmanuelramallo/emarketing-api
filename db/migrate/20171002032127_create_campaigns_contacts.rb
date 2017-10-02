class CreateCampaignsContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns_contacts, id: false do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :contact, index: true
    end
  end
end
