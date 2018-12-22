require 'pry'
require 'httparty'
require 'dotenv/load'
require_relative 'helpers'

module Jira
  class Client
    attr_reader :current_user
    include Helpers
    def initialize
      username = env('JIRA_USERNAME')
      @current_user = request(
        :get,
        "#{env('JIRA_URL')}/rest/api/2/user?username=#{username}",
      )
    end
    def create_issue(options)
      username, project = env('JIRA_USERNAME', 'JIRA_PROJECT')
      data = {
        fields: {
          project: {
            key: project
          },
          summary: options[:summary],
          description: options[:description] || "",
          issuetype: {
            name: "Task"
          },
          assignee: {
            name: username
          }
        }
      }
      res = request( 
        :post,
        "#{env('JIRA_URL')}/rest/api/2/issue",
        body: data.to_json,
      )
      res.merge(
        html_url: "#{env('JIRA_URL')}/browse/#{res['key']}"
      )
    end
    def basic_auth
      email, password = env('JIRA_EMAIL', 'JIRA_API_TOKEN')
      {
        username: email,
        password: password
      }
    end
    def request(method, path, extra = {})
      JSON.parse(
        HTTParty.send(method, path, extra.merge(
          headers: headers,
          basic_auth: basic_auth
        )).body
      )
    end
  end
end

if __FILE__ == $0
    jira = Jira::Client.new
    binding.pry
end