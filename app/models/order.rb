class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_details, dependent: :destroy

  enum status: {pending: 0, approved: 1, processing: 2, rejected: 3}
  scope :by_start_date,
        ->(start_date){where("created_at >= :start_date", start_date: start_date)}
  scope :by_end_date,
        ->(end_date){where("created_at <= :end_date", end_date: end_date)}
  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true
  delegate :name, to: :address, prefix: true

  class << self
    def statuses_i18n status = nill
      statuses.each_with_object({}) do |(k, _), obj|
        next if k == "pending"
        next if status.present? && k == status

        obj[I18n.t("orders.status.#{k}")] = k
      end
    end
  end

  def status_i18n
    I18n.t("orders.status.#{status}")
  end

  ransacker :created_at, type: :date do
    Arel.sql("date(created_at)")
  end

  def self.ransackable_scopes _auth_object = nil
    %i(by_start_date by_end_date)
  end
end
