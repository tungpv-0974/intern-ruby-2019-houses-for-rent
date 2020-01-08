class CreateWards < ActiveRecord::Migration[5.2]
  def change
    create_table :wards do |t|
      t.string :name
      t.string :type
      t.integer :district_id
    end
  end
end
