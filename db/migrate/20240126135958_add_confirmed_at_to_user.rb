class AddConfirmedAtToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :confirmed_at, :date, default: nil
  end
end
