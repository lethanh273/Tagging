class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.references :post, index: true
      t.references :article, index: true
      t.boolean :recent

      t.timestamps
    end
  end
end
