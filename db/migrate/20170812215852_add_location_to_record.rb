class AddLocationToRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :records, :location, :json, default: nil
  end
end
