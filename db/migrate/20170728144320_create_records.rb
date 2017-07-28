class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
    	t.references :user
    	t.integer :status
    	t.string :s3_url

    	t.timestamps
    end
  end
end
