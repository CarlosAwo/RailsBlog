class CreateSubscribers < ActiveRecord::Migration[7.1]
  def change
    create_table :subscribers do |t|
      t.string :email
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
