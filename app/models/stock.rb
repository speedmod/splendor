class Stock < ActiveRecord::Base
  belongs_to :development, foreign_key: 'card_id'
  scope :level, -> (level) { where(level: level) }

  def virgin?
    development.virgin?
  end

  def to_s
    development.to_s
  end
end
