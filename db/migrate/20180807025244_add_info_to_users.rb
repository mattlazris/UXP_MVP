class AddInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :birthday, :datetime
    add_column :users, :nationality, :string
    add_column :users, :gender, :string
    add_column :users, :description, :text
    add_column :users, :host, :boolean, :default => false
  end
end
