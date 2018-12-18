class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.references :app, null: false
      t.references :user, null: false
      t.string :access_token, null: false
      t.datetime :expired_at, null: true

      t.timestamps

      t.index :access_token
    end
  end
end
