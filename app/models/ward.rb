class Ward < ApplicationRecord
  belongs_to :district
  has_many :posts
  has_many :users
end
