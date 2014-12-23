class Player < ActiveRecord::Base
  has_many :hands
  has_many :development

  # カードの数
  def cards(type)
    development.send(:"#{type}").size
  end
  
  # 各宝石の数（トークン数 + 発展カードボーナス）
  def power(type)
    eval(type) + development.send(:"#{type}").pluck(:points).sum
  end
  
  def to_s
    "#{name}: Token "
  end
end
