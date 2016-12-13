class AddDetailsToSubscriptionPlans < ActiveRecord::Migration
  def change
    add_column :plans, :amount_of_listings, :text
    add_column :plans, :poster_templates, :text
    add_column :plans, :notification_permissions, :text
    add_column :plans, :analytic_package, :text
    add_column :plans, :support_package, :text
  end
end
