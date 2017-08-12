class AddAnalysisDataToRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :records, :analysis_data, :json, default: nil
    add_column :records, :analyzed_at, :datetime
    add_column :records, :plate, :string, index: true
  end
end
