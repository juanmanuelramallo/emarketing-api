class AddSpotlightedToCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_column :campaigns, :spotlighted, :boolean, default: false
  end
end
