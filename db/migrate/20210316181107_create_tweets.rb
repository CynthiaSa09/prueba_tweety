class CreateTweets < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.text :content, null: false
      t.string :image
      t.integer :likes, default: 0

      t.timestamps
    end
  end
end
