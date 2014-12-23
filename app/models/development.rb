class Development < ActiveRecord::Base
  belongs_to :player
  has_one :stock
  
  scope :level, -> (level) { where(level: level) }
  scope :virgin, -> { where(player_id: nil) }
  scope :type, -> (type) { where(bonus: type) }
  scope :diamond, -> { type("diamond") }
  scope :sapphire, -> { type("sapphire") }
  scope :emerald, -> { type("emerald") }
  scope :ruby, -> { type("ruby") }
  scope :onyx, -> { type("onyx") }
  
  def to_s
    "LV#{level} #{bonus} Point:#{point}(D:#{diamond},S:#{sapphire},E:#{emerald},R:#{ruby},O:#{onyx})"
  end

  def virgin?
    player_id.nil?
  end
end
