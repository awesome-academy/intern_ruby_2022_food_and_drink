class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_details, dependent: :destroy

  enum status: {pending: 0, approved: 1, processing: 2, rejected: 3}

  delegate :name, to: :user, prefix: true
  delegate :name, to: :address, prefix: true

  class << self
    def statuses_i18n
      statuses.each_with_object({}) do |(k, _), obj|
        obj[I18n.t("orders.status.#{k}")] = k
      end
    end
  end

  def status_i18n
    I18n.t("orders.status.#{status}")
  end
end
