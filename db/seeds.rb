# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Plan.create(
#   name: 'Free Plan',
#   price: 0,
#   stripe_plan_id: 'free'
# )

Plan.create(
  name: 'Plus',
  price: 4999,
  stripe_plan_id: 'plus1',
  description: 'Feature packed and ready to offer uncompromised utility. The plus package offers push notifications and analytics.',
  amount_of_listings: '10',
  poster_templates: '5',
  notification_permissions: '2/d/l',
  analytic_package: 'full',
  support_package: '24h email'
)

Plan.create(
  name: 'Premium',
  price: 9999,
  stripe_plan_id: 'premium1',
  description: 'HouseHound with no limits. Full featured with several poster types, extreme push notifications and a complete anaytics dashboard.',
  amount_of_listings: '20',
  poster_templates: 'custom',
  notification_permissions: '2/d/l',
  analytic_package: 'full',
  support_package: '24h email + phone'
)
