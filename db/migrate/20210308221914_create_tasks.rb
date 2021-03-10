class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user
      t.references :board
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
