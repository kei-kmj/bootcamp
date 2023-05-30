class RenameAllMemberColumnInRegularEvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :regular_events, :all_member, :join_all
  end
end
