class Product < ActiveRecord::Base
  belongs_to :user
  has_one :purchase

  validates :name, :amount, presence: true
end
