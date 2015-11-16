# 仕様
# Xlsxファイルを読み込んでモデルを作成するmodule
# 空白なセルは削除
# テキスト検索のクラス(方向, 順番, テキスト)をつくる
# モデルに登録する年が何年から何年までか計算するメソッドをつくる
# 栄養をハッシュ化するメソッド

module MenuRegister

require 'rubygems'
require 'roo'
require 'csv'
require 'json'

  class Registrar

  end

  class XlsxImporter

    def initialize(xlsx_path)
      @xlsx_path = xlsx_path
    end

    def convert
      begin
        xlsx = Roo::Excelx.new(@xlsx_path)
        xlsx.default_sheet = xlsx.sheets.first
        xlsx.to_csv(File::dirname(@xlsx_path) + '/new/' + File::basename(@xlsx_path, ".xlsx") + '.csv')
      rescue
        puts 'ファイルの読み込みまたは書き込みに失敗しました．'
      end
    end

  end

  class MenuFilter

    def getHeader
      pattern = %w(日 月 火 水 木 金 土)
      CSV.foreach(@file_path) do |row|
        return row if row.join =~ /(?=.*#{pattern.join(')(?=.*')})/
      end
      raise StandardError.new("File Broken\n")
    end

    def getMatchedRow(direction:, pattern:)
      file = iterationWay(direction: direction)
      file.each do |row|
        return row.flatten if row.join =~ /(?=.*#{pattern.join(')(?=.*')})/
      end
      raise StandardError.new("File Broken\n")
    end

    def getIndexArray(target:, pattern:)
      arr = []
      pattern.each do |p|
        target.each_with_index do |t, i|
          next if t.nil?
          arr << i if t.include?(p)
        end
      end
      return arr
    end

    def iterationWay(direction:)
      file = direction == 'by_row'? @file.by_row : @file.by_col
      return file
    end

    def mealFilter(row:, col:)
      file = @file.to_a
      meal = []

      # 献立の品物が空欄になるまで品物をさがす
      i = 0
      while %w{た 脂 炭 塩} - file[row+i][col].to_s.split("") != []
        unless file[row+i][col+2].nil?
          if file[row+i][col+2].include?('KC')
            meal << [file[row+i][col], file[row+i][col+2]]
          end
        end
        i += 1
        break if file[row+i][col].nil?
      end
      return meal
    end

    def nutritionFilter(row:, col:)
      file = @file.to_a
      nutrition = Hash.new

      i = 0
      while (%w{た 脂 炭 塩} - file[row+i][col].to_s.split("") != [])
        i += 1
        next if file[row+i][col].nil?
      end

      key = %i{energy protein fat carbohydrate salt}
      str = file[row+i][col]
      # p str
      split = str.split(/\D*[ ]\D*/)

      key.each_with_index do |v, i|
        # p v.class
        val = (v != :salt)? split[i].to_i : split[i].to_f
        nutrition.store(key[i], val)
      end
      return nutrition
    end

    def initialize
      @file_path = './new/' + Dir::glob('*.csv').first
      unless @file_path.nil?
        @file = CSV.read(@file_path, {col_sep: ',', skip_blanks: true, headers: getHeader})
      end
    end

    def filter
      col_head = getMatchedRow(direction:'by_col', pattern: %w(朝食 昼食 夕食))
      period_header = getIndexArray(target:col_head, pattern: %w(朝 昼 夕))
      daily_header = getIndexArray(target:@file.headers, pattern: %w(日 月 火 水 木 金 土))

      meal = Hash.new
      daily = Hash.new
      daily_header.each_with_index do |d, di|
        period_header.each_with_index do |p, pi|
          meal.store('menu', mealFilter(row: p, col: d))
          meal.store('nutrition', nutritionFilter(row: p, col: d))
        end
        daily.store('date', day[di])
        # daily.store('menu', menu)
        # daily.store('nutrition', nutrition)
      end
      # p daily
    end


  end
end
