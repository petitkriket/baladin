# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

Passenger.destroy_all

Passenger.create!([{
  name: "1",
  shortcut: "7ou",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "2",
  shortcut: "a9",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "3",
  shortcut: "6if",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "4",
  shortcut: "u2u",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "5",
  shortcut: "zp8",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "6",
  shortcut: "a6s",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "7",
  shortcut: "n2q",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "8",
  shortcut: "i78",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "9",
  shortcut: "4s2",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "10",
  shortcut: "gk3",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "11",
  shortcut: "pl8",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "12",
  shortcut: "9g3",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "13",
  shortcut: "6k9",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "14",
  shortcut: "g8e",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "15",
  shortcut: "z5z",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "16",
  shortcut: "v7x",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "17",
  shortcut: "e2a",
  created_at: Time.now,
  updated_at: Time.now
},
{
  name: "18",
  shortcut: "x2k",
  created_at: Time.now,
  updated_at: Time.now
}])

p "Created #{Passenger.count} passengers"
#2
user = User.new(name: "François",
email: "francoismaurinpro@gmail.com",
role: 2,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#3
user = User.new(name: "Daniel",
email: "pierre.daniel22@wanadoo.fr",
role: 0,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#4
user = User.new(name: "Piver",
email: "piver.charles@gmail.com",
role: 0,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#5
user = User.new(name: "Marion",
email: "marion.lisch@gmail.com",
role: 0,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#6
user = User.new(name: "Dandel",
email: "dandel.alexandre@gmail.com",
role: 0,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#7
user = User.new(name: "Camille Paulhan",
email: "camille.paulhan@gmail.com",
role: 0,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#8
user = User.new(name: "Corradino",
email: "matthieu.corradino@gmail.com",
role: 0,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#9
user = User.new(name: "Zilio",
email: "mzilio@hotmail.fr",
role: 0,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#10
user = User.new(name: "Guionnet",
email: "contact@pointcontemporain.com",
role: 0,
locale: "fr",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

#11
user = User.new(name: "Gabriella",
email: "gabyeloman@hotmail.fr",
role: 0,
locale: "en",
password: 'modifier',
password_confirmation: 'modifier',
created_at: Time.now,
updated_at: Time.now,
confirmed_at: DateTime.now
)
user.skip_confirmation_notification!
user.save!

p "Created #{User.count} users"

Event.destroy_all
Event.create!([{
  #daniel
  address: "Jerusalemstraat 8, 1030 Schaarbeek, Belgium",
  passenger_id: 1,
  user_id: 3,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},
{
  #piver
  address: "1 Villa Armand, 75018 Paris, France",
  passenger_id: 2,
  user_id: 4,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},
{
  #marion
  address: "1 Rue Aristide Ollivier, 34000 Montpellier, France",
  passenger_id: 4,
  user_id: 5,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},
{
  #dandel
  address: "27 Rue Ramponeau, 75020 Paris, France",
  passenger_id: 2,
  user_id: 6,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},
{
  #camille paul
  address: "5 Rue de l'Hôtel de ville, 75004 Paris, France",
  passenger_id: 12,
  user_id: 7,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},
{
  #Corradino
  address: "2 Avenue Emile Bergerat, 75016 Paris, France",
  passenger_id: 8,
  user_id: 8,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},{
  #Zilio
  address: "133 Rue des Poissonniers, 75018 Paris, France",
  passenger_id: 10,
  user_id: 9,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},{
  #Zilio bis
  address: "133 Rue des Poissonniers, 75018 Paris, France",
  passenger_id: 6,
  user_id: 9,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},{
  #Guionnet
  address: "13 Rue Bichat, 75010 Paris, France",
  passenger_id: 7,
  user_id: 10,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
},{
  #Gabriella
  address: "Pharmacie Le Fleuron, Douala",
  passenger_id: 6,
  user_id: 11,
  published: true,
  created_at: Time.now,
  updated_at: Time.now
}])

p "Created #{Event.count} events"
