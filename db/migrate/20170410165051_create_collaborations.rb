class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.references :wiki, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
