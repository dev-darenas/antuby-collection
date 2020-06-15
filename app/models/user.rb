class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :session_limitable

  # relations
  belongs_to :enterprise, autosave: true
  accepts_nested_attributes_for :enterprise

  # TODO
  # User with Collection Advisor role relation wit activities
  # User with debt collector role relation wit activities
  has_many :activities,
           -> { where type_activity: :task },
           foreign_key: :collection_advisor_id,
           class_name: 'Activity'

  has_many :activities_created,
           foreign_key: :created_by_id,
           class_name: 'Activity'

  has_many :notes
  has_many :invoices,
           foreign_key: :collector_advisor_id,
           class_name: :Invoice
  has_many :clients,
           through: :invoices,
           source: :third

  delegate :name, :name=, to: :enterprise, prefix: true, allow_nil: true
  after_create :assign_default_role
  after_create :send_notification

  def enterprise
    super || build_enterprise
  end

  def name
    "#{first_name} #{last_name}"
  end

  def active_for_authentication?
    p "#{enterprise.registration_activated?} && #{enterprise.active?} || #{self.has_role?(:admin)}"
    super && enterprise.registration_activated? && (enterprise.active? || self.has_role?(:admin))
  end

  def inactive_message
    if enterprise.registration_activated?
      if !enterprise.active?
        "Empresa Desactivada"
      end
    else
      "Falta Verificar tu cuenta"
    end
  end

  private

  def assign_default_role
    self.add_role(:admin) if self.roles.blank?
  end

  def send_notification
    UserNotificationMailer.new_register(self).deliver_later
    Admin.all.each do |admin|
      AdminNotificationMailer.new_register(self, admin).deliver_later
    end
  end
end
