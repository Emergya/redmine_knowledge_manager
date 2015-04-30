class CreateKnowledgesAndUsersKnowledges < ActiveRecord::Migration
  def self.up
    create_table :knowledges, :force => true do |t|
      t.column :name, :string, :null => false
      t.column :main, :boolean, :default => 0
    end

    create_table :user_knowledges, :force => true do |t|
      t.column :user_id, :integer, :null => false
      t.column :knowledge_id, :integer, :null => false
      t.column :level, :integer, :null => false, :default => 1
    end
  end

  def self.down
    drop_table :knowledges
    drop_table :user_knowledges
  end
end
