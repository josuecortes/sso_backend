puts "Seeding default roles..."

master_role = Role.find_or_create_by!(name: 'master')
admin_role  = Role.find_or_create_by!(name: 'administrador')
normal_role = Role.find_or_create_by!(name: 'normal')

puts "Seeding default users..."

master_user = User.find_or_create_by!(email: 'master@sso.com') do |user|
  user.password = '123456'
  user.password_confirmation = '123456'
  user.name = "Master of SSO"
end

admin_user = User.find_or_create_by!(email: 'administrador@sso.com') do |user|
  user.password = '123456'
  user.password_confirmation = '123456'
  user.name = "Administrador of SSO"
end

puts "Assigning roles..."

UserRoleAssignment.find_or_create_by!(user: master_user, role: master_role, active: true)
UserRoleAssignment.find_or_create_by!(user: admin_user,  role: admin_role,  active: true)

puts "Seeding completed ✅"
