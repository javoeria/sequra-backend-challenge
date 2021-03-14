# == Schema Information
#
# Table name: shoppers
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  email      :string(255)
#  nif        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Shopper < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, :email, :nif, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :nif, uniqueness: true, length: { is: 10 }
end
