class Order < ApplicationRecord
  enum status: {pendding: 0, aprove: 1, processing: 2, reject: 3}, _prefix: :orders

  belongs_to :user
  belongs_to :address
  has_many :order_details, dependent: :destroy

  validates :total, presence: true
  validates :phone, presence: true

  scope :order_latest, ->{order created_at: :desc}
end
