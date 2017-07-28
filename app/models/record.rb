class Record < ApplicationRecord
	belongs_to :user

	enum status: [ :uploaded, :processed ]
end