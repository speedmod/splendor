# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
require 'fileutils'

@exec_methods = [:create_cards]

def create_cards
  load_file = Rails.root.join('db', 'cards.csv')
  ActiveRecord::Base.transaction do
    CSV.foreach(load_file) do |cols|
      Development.create(level: cols[0],
                         bonus: cols[1],
                         point: cols[2],
                         diamond: cols[3],
                         sapphire: cols[4],
                         emerald: cols[5],
                         ruby: cols[6],
                         onyx: cols[7])
    end
  end
end

def exec
  # if Rails.env.test?
  #   # テスト時はmaster_prefecturesのみ実行
  #   # rake db:seedはテスト実施時に勝手に呼ばれます
  #   master_prefectures
  # else
  @exec_methods.to_a.each do |method|
    tmp_seeds_dir = Rails.root.join('tmp/seeds', Rails.env)
    FileUtils.mkdir_p(tmp_seeds_dir) unless tmp_seeds_dir.exist?
    if tmp_seeds_dir.join(method.to_s).exist?
      puts "Skip calling #{method}."
    else
      puts "Applying #{method}."
      send(method)
      FileUtils.touch(tmp_seeds_dir.join(method.to_s))
    end
  end
  # end
end

exec

