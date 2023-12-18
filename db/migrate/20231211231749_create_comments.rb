class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :parent_comment, null: true, foreign_key: { to_table: :comments }
      t.references :article, null: :false

      t.timestamps
    end
  end
end
