# == Schema Information
#
# Table name: merchants
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  email      :string(255)
#  cif        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Merchant < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :disbursements, dependent: :destroy

  validates :name, :email, :cif, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :cif, uniqueness: true, length: { is: 10 }
end
