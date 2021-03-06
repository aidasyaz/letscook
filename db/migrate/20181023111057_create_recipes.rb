class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.references :user

      t.string :name
      t.string :description
      t.string :ingredients
      t.string :instructions

      t.datetime :posted_at
      t.timestamps
    end
  end
end
