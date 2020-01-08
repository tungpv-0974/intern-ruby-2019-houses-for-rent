class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts do |t|
      t.string :name
      t.string :type
      t.integer :province_id
    end
  end
end
