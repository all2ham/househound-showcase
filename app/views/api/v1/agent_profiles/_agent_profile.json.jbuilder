json.(agent_profile, :name, :phone_number, :email, :website)
json.photo do
  agent_profile.photo ? json.partial!('api/v1/photos/photo', photo: agent_profile.photo) : nil
end
json.organization agent_profile.brokerage
