class Order < ApplicationRecord
  enum status: {pending: 0, aprove: 1, processing: 2, success: 3, reject: 4}, _prefix: :orders

  belongs_to :user
  belongs_to :address
  has_many :order_details, dependent: :destroy

  validates :total, presence: true
  validates :phone, presence: true

  delegate :name, to: :address, prefix: true
  delegate :email, to: :user, prefix: true
  scope :order_latest, ->{order created_at: :desc}

  class << self
    def statuses_i18n
      statuses.each_with_object({}) do |(k, _), obj|
        obj[I18n.t("order.status.#{k}")] = k
      end
    end
  end

  def status_i18n
    I18n.t("order.status.#{status}")
  end
end
