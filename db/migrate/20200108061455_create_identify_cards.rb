class CreateIdentifyCards < ActiveRecord::Migration[5.2]
  def change
    create_table :identify_cards do |t|
      t.string :identify_number
      t.string :provide_by
      t.date :date_of_license
      t.string :image_url
    end
  end
end
