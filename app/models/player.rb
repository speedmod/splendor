class Player < ActiveRecord::Base
  GEMS = [:diamond, :sapphire, :emerald, :ruby, :onyx]
  has_many :hands
  has_many :development

  # トークンをとる
  # 負の数も許容する
  # @return [True/False] 成功した場合にはtrue, 失敗したらfalse
  def get(dia: 0, sap: 0, eme: 0, rub: 0, ony: 0, gol: 0)
    if valid_get?(d:dia, s:sap, e:eme, r:rub, o:ony, g:gol)
      update(diamond: diamond + dia,
             sapphire: sapphire + sap,
             emerald: emerald + eme,
             ruby: ruby + rub,
             onyx: onyx + ony,
             gold: gold + gol)
    else
      false
    end
  end

  # 手札を確保する
  # @param [Development] card 確保したカード
  # @param [True/False] hidden 山札から→true、場から→false
  def hand(card: , hidden: false, gold_got: 1)
    Hand.create(player_id: id, development_id: card.id, hidden: hidden)
    update(gold: gold + gold_got)
  end
  
  # # 手札をとる（山札から）
  # def hand_hidden(level)
  #   Hand.create(player_id: id, development_id: card.id, hidden: true)
  # end

  # カードを買う
  # @param [Development] card 購入するカード
  # @return [True/False] 購入できたらtrue, できなければfalse
  def buy(card)
    req = gold_required(card)
    if gold < req
      false
    else
      GEMS.each do |type|
        pay(type, card.send(type) - bonus(type))
      end
      pay(:gold, req) 
    end
  end

  # 支払い
  # @param [Symbol] gem_type 宝石の種類
  # @param [Fixnum] number 支払う個数
  def pay(gem_type, number)
    diff = tokens(gem_type) - number
    rest = diff > 0 ? diff : 0
    update!(gem_type => rest)
  end

  # 手持ちのカードの宝石ごとのボーナス数
  # @param [Symbol] type 宝石の種類
  def bonus(type)
    development.send(type).size
  end

  # ある宝石のトークン数
  # @param [Symbol] type 宝石の種類
  def tokens(type)
    eval(type.to_s)
  end
  
  # 所有する宝石の数（トークン数 + 発展カードボーナス）
  # @param [String/Symbol] type 宝石の種類
  # @return [Fixnum] 
  def gems(type)
    tokens(type) + bonus(type)
  end
  
  def to_s
    "This method is under construction"
  end

  private
  # 確保時のトークン取得の妥当性
  # g以外は基本的に負の数（トークンを捨てることを意味する）
  def valid_hand?(d: , s: , e: , r: , o: , g:)
    return false if g > 1
    return false if d + s + e + r + o + g != 0
    # getした後のトークンの数
    all_tokens = diamond + d + sapphire + s + emerald + e +
                 ruby + r + onyx + o + gold + g
    return false if all_tokens > 10
    true
  end
  
  # get時のトークン取得の妥当性
  def valid_get?(d: , s: , e: , r: , o: , g:)
    return false if g > 0 # 黄金はgetでは捨てることしかできない
    return false if d > 2 || s > 2 || e > 2 || r > 2 || o > 2
    if (d == 2 && (s > 0 || e > 0 || r > 0 || o > 0))
      || (s == 2 && (d > 0 || e > 0 || r > 0 || o > 0))
      || (e == 2 && (d > 0 || s > 0 || r > 0 || o > 0))
      || (r == 2 && (d > 0 || s > 0 || e > 0 || o > 0))
      || (o == 2 && (d > 0 || s > 0 || e > 0 || r > 0)) 
      return false
    end
    # getしている全てのトークンの数
    return false if dia + sap + eme + rub + ony > 3
    # getした後のトークンの数
    all_tokens = diamond + dia + sapphire + sap + emerald + eme +
                 ruby + rub + onyx + ony + gold + g
    return false if all_tokens > 10
    true
  end

  # 黄金トークンの数を求める
  # @param [Development] card 購入対象カード
  # @return [Fixnum] cardを買うために必要な黄金トークンの数
  def golds_required(card)
    needs = 0
    GEMS.each do |gem|
      need = card.send(gem) - gems(gem)
      needs += need if need > 0
    end
    needs
  end

  # @deprecated
  def can_buy?(card)
    needs = 0
    GEMS.each do |gem|
      need = card.send(gem) - gems(gem)
      needs += need if need > 0
    end
    gold >= needs
  end
end
