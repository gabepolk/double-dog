describe 'routing to signin' do
  it "routes /login to login" do
    expect(get: "/login").to route_to(
      controller: "login",
      action: "show_login"
    )
  end
end
