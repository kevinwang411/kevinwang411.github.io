class AddForeignKeys < ActiveRecord::Migration
    def change
        change_table :bets do |t|
            t.references :user
        end
    end
end