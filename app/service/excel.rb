module Excel

  #実行の仕方
  #0 gem install roo  （インストール済ならスキップ）
  #1 ターミナル起動
  #2 cd app/service
  #3 ruby excel.rb 
  require 'roo'

  xlsx = Roo::Excelx.new('sample.xlsx')
  sheet = xlsx.sheet(0)
  # p sheet.last_row      #行
  # p sheet.last_column   #列

  # データ出力
  2.upto(xlsx.last_row) do |row|  
    puts "#{xlsx.cell(row, 9)} #{xlsx.cell(row, 10)}"
  end
end