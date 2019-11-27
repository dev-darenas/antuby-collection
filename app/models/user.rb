class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  delegate :name, :name=, to: :enterprise, prefix: true, allow_nil: true

  def enterprise
    super || build_enterprise
  end

  def name
    "#{first_name} #{last_name}"
  end
end
