class ChangePost < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :active, true
  end
end
