# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
MosterType.create(name:'fire', feature: 'fire', rank: '1')
MosterType.create(name:'water', feature: 'water', rank: '2')
MosterType.create(name:'wind', feature: 'wind', rank: '3')
MosterType.create(name:'earth', feature: 'earth', rank: '4')
MosterType.create(name:'sky', feature: 'sky', rank: '5')
