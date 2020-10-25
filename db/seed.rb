# frozen_string_literal: true

user = CreateAdminService.new.call
puts 'Super user created with following email: ' << user.email
