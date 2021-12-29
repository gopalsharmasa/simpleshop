class Shop < ApplicationRecord
  belongs_to :region
  has_many :products, :dependent => :destroy
  validates :title, presence: true
end
