class RemoveWrongColumnFromServices < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :services, :community_rice, :community_price
  end

  def self.down
    rename_column :services, :community_rice, :community_price
  end
end
