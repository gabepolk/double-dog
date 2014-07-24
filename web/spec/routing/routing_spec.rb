require 'spec_helper'

describe 'routing to signin' do
  it "routes /signin to sessions#new" do
    expect(get: "/signin").to route_to(
      controller: "sessions",
      action: "new"
    )
  end
end

describe 'routing to signup' do
  it "routes /signup to user#new" do
    expect(get: "signup").to route_to(
      controller: "users",
      action: "new"
    )
  end
end
