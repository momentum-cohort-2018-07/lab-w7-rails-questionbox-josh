class RenameQuestionInQuestionToBody < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :question, :body
  end
end
