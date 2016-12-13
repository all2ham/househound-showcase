User.create!(
    email: 'mike@househound.co',
    password: 'password',
    password_confirmation: 'password',
    role: 'Admin',
    confirmed_at: DateTime.now,
    active: true
)

User.create!(
    email: 'allan@househound.co',
    password: 'password',
    password_confirmation: 'password',
    role: 'Admin',
    confirmed_at: DateTime.now,
    active: true
)