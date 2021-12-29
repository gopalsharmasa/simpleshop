class Region < ApplicationRecord
	has_many :shops
	validates :title, presence: true
end
