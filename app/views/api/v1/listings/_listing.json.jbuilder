json.id listing.id
json.address listing.address
json.price listing.price.to_f
json.description listing.description
json.expiry_date listing.expiry_date
json.floor_area listing.floor_area
json.bedroom_count listing.bedroom_count
json.bathroom_count listing.bathroom_count
json.building_type listing.b_type
json.building_style listing.b_style
json.property_taxes listing.property_taxes
json.next_open_house listing.next_open_house ? listing.next_open_house.start : nil
json.agent_profile do
  json.partial! 'api/v1/agent_profiles/agent_profile', agent_profile: listing.agent_profile
end
json.notifications listing.notifications.order(created_at: :desc).limit(5) do |notification|
  json.partial! 'api/v1/notifications/notification', notification: notification
end
json.photos listing.photos do |photo|
  json.partial! 'api/v1/photos/photo', photo: photo
end
