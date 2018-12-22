require_relative "lib/jira"
require_relative "lib/github"

jira = Jira::Client.new
github = GitHub::Client.new

puts "enter a pull request url:"
pr = github.get_pull_request(gets.chomp)
issue = jira.create_issue(
  summary: pr["title"],
  description: pr["body"]
)
puts "Jira ticket created successfully:"
puts "  -> " + issue[:html_url]

comment = github.comment(pr["comments_url"], "**JIRA**: #{issue[:html_url]}")

puts "GitHub comment created successfully:"
puts "  -> " + comment["html_url"]