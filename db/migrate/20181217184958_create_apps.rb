class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.string :client_id, null: false
      t.string :client_secret, null: false
      t.datetime :expired_at, null: true

      t.timestamps

      t.index :client_id
    end
  end
end
