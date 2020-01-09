class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.date :birthdate
      t.string :avatar_url
      t.string :address
      t.integer :identify_card_id
      t.integer :ward_id
      t.integer :role
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.integer :activated
      t.datetime :activated_at

      t.timestamps
    end
  end
end
