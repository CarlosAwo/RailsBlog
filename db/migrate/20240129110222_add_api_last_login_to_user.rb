class AddApiLastLoginToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :api_last_logout, :datetime, default: nil
  end
end
