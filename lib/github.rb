require 'pry'
require 'httparty'
require 'dotenv/load'
require_relative 'helpers'

module GitHub
  class Client
    attr_accessor :current_user
    include Helpers
    @@api_url = "https://api.github.com"
    def initialize
      @current_user = request(
        :get,
        "#{@@api_url}/user?access_token=#{env('GITHUB_API_TOKEN')}",
      )
    end
    def request(method, path, extra = {})
      JSON.parse(
        HTTParty.send(method, path, extra.merge(
          headers: headers
        )).body
      )
    end
    def get_pull_request(html_url)
      uri = URI.parse(html_url)
      owner_slash_repo = uri.path.slice(1,uri.path.length).split("/").first(2).join("/")
      id = uri.path.split("/").last
      url = "#{@@api_url}/repos/#{owner_slash_repo}/issues/#{id}?access_token=#{env('GITHUB_API_TOKEN')}"
      request(:get, url)
    end
    def comment(comments_url, body)
      request(
        :post,
        "#{comments_url}?access_token=#{env('GITHUB_API_TOKEN')}",
        body: {
          body: body
        }.to_json
      )
    end
  end
end

if __FILE__ == $0
    github = GitHub::Client.new
    binding.pry
end