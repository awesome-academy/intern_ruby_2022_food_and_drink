class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :messages
  has_many :rooms
  accepts_nested_attributes_for :addresses, allow_destroy: true
  enum role: {
    user: Settings.const.users.role.user,
    admin: Settings.const.users.role.admin
  }

  enum status: {active: 1, block: 2}

  before_save :email_downcase

  validates :name, presence: true,
    length: {
      minium: Settings.const.users.name.length.min,
      maximum: Settings.const.users.name.length.max
    }
  validates :email, presence: true,
    length: {
      minium: Settings.const.users.email.length.min,
      maximum: Settings.const.users.email.length.max
    },
    format: {with: Settings.const.users.email.regex},
    uniqueness: true

  validates :phone, uniqueness: true

  validates :password, presence: true,
    length: {minimum: Settings.const.users.password.length.min},
    allow_nil: true

  scope :latest_user, ->{order created_at: :desc}

  def email_downcase
    email.downcase!
  end

  class << self
    def statuses_i18n
      statuses.each_with_object({}) do |(k, _), obj|
        obj[I18n.t("user.status.#{k}")] = k
      end
    end

    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.name = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end

  def status_i18n
    I18n.t("user.status.#{status}")
  end
end
