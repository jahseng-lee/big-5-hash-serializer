require 'uri'
require 'net/http'
require 'net/https'
require 'json'

class BigFiveResultsPoster
  attr_reader :response_code, :token, :errors

  API_ENDPOINT = "https://recruitbot.trikeapps.com/api/v1/roles/senior-team-lead/big_five_profile_submissions"

  def initialize(results_hash:, email:)
    @results_hash = results_hash
    @email = email
    @response_code = nil
    @token = nil
    @errors = nil
  end

  def post
    final_hash = @results_hash.merge(
      { "EMAIL" => @email }
    )

    results = Net::HTTP.post(
      URI(API_ENDPOINT),
      final_hash.to_json,
      "Content-Type" => "application/json"
    )

    @response_code = results.code
    if results.code == "201"
      @token = response.body["receipt_token"]
    else
      @errors = response.body["error_message"]
    end
  end
end
