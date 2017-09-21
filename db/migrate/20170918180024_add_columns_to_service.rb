class AddColumnsToService < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :name, :string
    add_column :services, :initial_price, :float
    add_column :services, :subsequent_price, :float
    add_column :services, :community_rice, :float
  end
end
