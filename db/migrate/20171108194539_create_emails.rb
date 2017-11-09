class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.references :contact, foreign_key: true
      t.references :campaign, foreign_key: true
      t.integer :sent_times
      t.integer :opened_times
      t.integer :clicks

      t.timestamps
    end
  end
end
