class AddPriceToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :price, :decimal

  end
end
