# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
grapes = ['Cabernet Sauvignon', 'Merlot', 'Syrah', 'Shiraz', 'Pinot Noir',
          'Zinfandel', 'Chardonnay', 'Sauvignon Blanc', 'Semillon', 'Riesling',
          'Pinot Gris', 'Chenin Blanc', 'Malbec', 'Tempranillo', 'Sangiovesee',
          'Nebbiolo', 'Carbernet Franc', 'Gamay', 'Grenache', 'Zinfindel',
          'Semillon']

grapes.each do |grape|
  Grape.create(name: grape)
end
