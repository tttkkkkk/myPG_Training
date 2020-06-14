
module Excel
  require 'csv'
  require 'roo'

  CSV_EXPORT_HEADER = %w(処理区分 ブランド 店舗名)
  #[実行の手順]
  #0 gem install roo  （インストール済ならスキップ）
  #1 ターミナル起動
  #2 cd app/service
  #3 エクセル名の確認
  #4 ruby excel.rb
  xlsx = Roo::Excelx.new('sample.xlsx')
  sheet = xlsx.sheet(0)
  #ヘッダー
  headers = CSV_EXPORT_HEADER
  #データ
  outputs = []
  3.upto(xlsx.last_row) do |row|
    outputs << "a,#{xlsx.cell(row, 9)},#{xlsx.cell(row, 10)}"
  end

  #CSVファイル出力
  f = File.open("#{Time.now.strftime('%Y%m%d-%H%M')}.csv", 'w') # wは書き込み権限
  f.puts headers.join(',')
  f.puts outputs
  f.close
end