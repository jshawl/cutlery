describe Jira::Client do
  before do
    stub_request(:get, /(.*).atlassian.net\/rest\/api\/2\/user\?username=(.*)/).
      to_return(status: 200, body: fixture("jira/user"))
    @jira = Jira::Client.new
  end
  it "is self aware" do
    expect(@jira.current_user).not_to be(nil)
  end
  it "can create issues" do
    stub_request(:post, /(.*).atlassian.net\/rest\/api\/2\/issue/).
      to_return(status: 200, body: fixture("jira/issue"))
    issue = @jira.create_issue(
      summary: "Jira issue summary",
      description: "Jira issue description"
    )
    expect(issue[:html_url]).to match("/browse/ABCD-1")
  end
end