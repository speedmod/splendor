class BoardsController < ApplicationController
  def init
    Stock.delete_all
    devs = Development.all.shuffle
    devs.each do |d|
      # 並び順を保持
      Stock.create(level: d.level, card_id: d.id)
    end
  end
  
  def index
    init if params[:new_game].present?
    @devs_1 = Stock.level(1).select { |s| s.virgin? }
    @devs_2 = Stock.level(2).select { |s| s.virgin? }
    @devs_3 = Stock.level(3).select { |s| s.virgin? }    
  end

  # 場を進める
  def update
    # player_id: プレイしたプレイヤーのID
    # action: アクションの種類（文字列）
    # (buy)
    # card_id:
    # (get)
    # diamond: sapphire: emerald: ruby: onyx
    # (hand)
    # 山札から
    # hidden: true, card_id: 
    # 場から
    # hidden: false, card_id:
  end
end
