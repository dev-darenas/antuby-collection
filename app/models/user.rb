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

  def enterprise
    super || build_enterprise
  end

  def name
    "#{first_name} #{last_name}"
  end

  def active_for_authentication?
    super && (enterprise.active? || self.has_role?(:admin))
  end

  private
  def assign_default_role
    self.add_role(:admin) if self.roles.blank?
  end
end
