class AddWayFieldImgOnMeal < ActiveRecord::Migration[8.0]
  def change
    add_column :meals, :way_img, :string, null: true, default: nil
  end
end
