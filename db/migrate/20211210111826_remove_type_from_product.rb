class RemoveTypeFromProduct < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :type, :string
  end
end
