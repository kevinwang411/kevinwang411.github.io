class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :date
      t.string :home_team
      t.string :road_team
      t.string :bet_type
      t.string :bet_n
      t.string :odds
      t.string :units
      t.string :reasoning
      t.string :outcome
      t.timestamps
    end
  end
end