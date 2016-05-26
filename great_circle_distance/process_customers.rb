#!/usr/bin/env ruby

require 'json'
require './distance_calculator'

# exit if ARGV empty
abort("Usage: ruby process_customer.rb <filename>") if ARGV.empty?
filename = ARGV.first
office_geocode = {:latitude => 53.3381985, :longitude => -6.2592576}

begin
  file_handle = File.open(filename, "r")
rescue => e
  raise "Unable read file #{filename} - #{e.message}"
end

customers = {}
file_handle.each_line { |line|
  data = JSON.parse(line)
  user_id = data.delete("user_id")
  customers[user_id] = data
}

customers.sort.each { |user_id, data|
  current_geocode = {:latitude => data['latitude'].to_f, :longitude => data['longitude'].to_f}
  distance = DistanceCalculator.calculate_distance(current_geocode, office_geocode)

  unless distance > 100.00
    puts "User Id: #{user_id} \t Name: #{data['name']} \t Distance(in km): #{distance}"
  end
}
