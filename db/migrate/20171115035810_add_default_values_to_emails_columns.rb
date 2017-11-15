class AddDefaultValuesToEmailsColumns < ActiveRecord::Migration[5.1]
  def change
    change_column :emails, :opened_times, :integer, default: 0, null: false
    change_column :emails, :clicks, :integer, default: 0, null: false
  end
end
