class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest

      t.string :name
      t.string :last_name
      t.string :phone
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
