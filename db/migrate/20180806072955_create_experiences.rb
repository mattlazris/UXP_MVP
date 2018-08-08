class CreateExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :experiences do |t|
      t.string :name
      t.string :description
      t.string :category
      t.float :price
      t.integer :capacity
      t.string :location
      t.string :language

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
