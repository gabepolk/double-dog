require 'spec_helper'

describe DoubleDog::CreateAccount do

  describe 'Validation' do

    context "when there is no session" do
      it "requires the creator to be an admin" do
        script = DoubleDog::CreateAccount.new
        expect(script).to receive(:admin_session?).and_return(false)

        result = script.run(:session_id => 'nope', :username => 'a', :password => 'b')
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :not_admin
      end
    end

    context "when there is a session" do
      before(:each) do
        @script = DoubleDog::CreateAccount.new
        expect(@script).to receive(:admin_session?).and_return(true)
      end

      it "requires a username" do
        result = @script.run(:session_id => 0, :password => 'bluh')
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :invalid_username
      end

      it "requires a username to be at least three characters" do
        result = @script.run(:session_id => 0, :username => 'ab', :password => 'bluh')
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :invalid_username
      end

      it "requires a password" do
        result = @script.run(:session_id => 0, :username => 'bob')
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :invalid_password
      end

      it "requires a password with at least three characters" do
        result = @script.run(:session_id => 0, :username => 'bob', :password => '12')
        expect(result[:success?]).to eq false
        expect(result[:error]).to eq :invalid_password
      end

      it "creates an account" do
        result = @script.run(:session_id => 0, :username => 'bob', :password => 'letmein')
        expect(result[:success?]).to eq true

        user = result[:user]
        expect(user.id).to_not be_nil
        expect(user.username).to eq 'bob'
        expect(user.has_password? 'letmein').to eq true
      end
    end

  end
end
