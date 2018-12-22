describe GitHub::Client do
  before do
    stub_request(:get, /api.github.com\/user/).
      to_return(status: 200, body: fixture("github/user"))
    stub_request(:get, /api.github.com\/repos\/(.*)\/(.*)\/issues\/[0-9]+/).
      to_return(status: 200, body: fixture("github/issue"))
    @github = GitHub::Client.new
  end
  it "is self aware" do
    expect(@github.current_user).not_to be(nil)
  end
  it "can view pull requests from an html url" do
    issue = @github.get_pull_request("https://github.com/owner/repo/pull/1")
    expect(issue["title"]).to eq("The GitHub Pull Request Title")
    expect(issue["body"]).to eq("The GitHub Pull Request Description")
  end
  it "can comment on a pull request" do
    issue = @github.get_pull_request("https://github.com/owner/repo/pull/1")
    body = "This is a comment on a pull request."
    stub_request(:post, /api.github.com\/repos\/(.*)\/(.*)\/issues\/[0-9]+\/comments/).
      to_return(status: 200, body: fixture("github/comment"))
    comment = @github.comment(issue["comments_url"], body)
    expect(comment["body"]).to eq(body)
  end
end