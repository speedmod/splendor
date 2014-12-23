class Development < ActiveRecord::Base
  belongs_to :player
  
  scope :level, -> (level) { where(level: level) }
  scope :type, -> (type) { where(bonus: type) }
  scope :diamond, -> { type("diamond") }
  scope :sapphire, -> { type("sapphire") }
  scope :emerald, -> { type("emerald") }
  scope :ruby, -> { type("ruby") }
  scope :onyx, -> { type("onyx") }
  
  def to_s
    "LV#{level} #{bonus} Point:#{point}(D:#{diamond},S:#{sapphire},E:#{emerald},R:#{ruby},O:#{onyx})"
  end
end
