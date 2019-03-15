require_relative "../lib/big_five_results_text_serializer"
require_relative "../lib/big_five_results_poster"

text = File.readlines("big_five_traits.txt")

results_hash = BigFiveResultsTextSerializer.new(text: text).to_h
poster = BigFiveResultsPoster.new(
  results_hash: results_hash,
  email: "jahseng.lee@gmail.com"
)

poster.post

puts "Response code: #{poster.response_code}"
puts "Token: #{poster.token}"
puts "Error messages: #{poster.errors}"

