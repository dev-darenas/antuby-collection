class Third < ApplicationRecord
  belongs_to :enterprise
  has_one :address, as: :addressable
  has_many :contacts
  has_many :invoices

  delegate :description, :description=,
           to: :find_or_build_address,
           prefix: :address

  def find_or_build_address
    address || build_address
  end
end
