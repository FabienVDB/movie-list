# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'net/http'
require 'json'
require 'uri'

puts 'Delete all movies'
Movie.destroy_all

uri_movies = URI('https://tmdb.lewagon.com/movie/top_rated')
response_movies = Net::HTTP.get_response(uri_movies)
results_movies = JSON.parse(response_movies.body)['results']

config_uri = URI('https://tmdb.lewagon.com/configuration')
response_config = Net::HTTP.get_response(config_uri)
results_config = JSON.parse(response_config.body)

base_url = results_config['images']['base_url']
poster_size = results_config['images']['poster_sizes'][4] # 'w500'

results_movies.each do |movie|
  title = movie['title']
  overview = movie['overview']
  poster_url = "#{base_url}#{poster_size}#{movie['poster_path']}"
  rating = movie['vote_average']
  puts "Create movie : #{title}"
  Movie.create(title: title, overview: overview, poster_url: poster_url, rating: rating)
end

puts 'Create list'
List.create(name: 'Drama')
List.create(name: 'All time favourites')
List.create(name: 'Best western movies')

puts 'All seeds loaded'
