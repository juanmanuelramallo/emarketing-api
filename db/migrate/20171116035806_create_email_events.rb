class CreateEmailEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :email_events do |t|
      t.integer :event, default: 0, null: false
      t.belongs_to :email

      t.timestamps
    end
  end
end
