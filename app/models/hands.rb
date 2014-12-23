class Hands < ActiveRecord::Base
  belongs_to :player
  has_one :development
end
