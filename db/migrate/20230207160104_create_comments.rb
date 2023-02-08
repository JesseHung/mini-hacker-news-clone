class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :level, default: 0
      t.belongs_to :post, foreign_key: true
      t.belongs_to :comment, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
