class ChangeUserProfileToAgentProfile < ActiveRecord::Migration
  def change
    rename_table :user_profiles, :agent_profiles
  end
end
