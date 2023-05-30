class AddAllMemberToRegularEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :regular_events, :all_member, :boolean, null: false, default: false
  end
end
