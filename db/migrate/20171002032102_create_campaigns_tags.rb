class CreateCampaignsTags < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns_tags, id: false do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :tag, index: true
    end
  end
end
