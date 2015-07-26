class AddQuestionIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :question_id, :integer
    add_index :posts, :question_id
  end
end
