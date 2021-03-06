require "rails_helper"

describe "User Logout", type: :request do
  context "when a valid token is passed in the header" do
    before(:all) do
      @signed_user = create(:user)
      get(
        "/api/v1/auth/logout",
        {},
        "Accept" => "application/json",
        "Authorization" => login(@signed_user)
      )
    end
    it "returns a status code" do
      expect(response.status).to eq 200
    end

    it "returns json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "returns success message" do
      expect(json(response.body)[:success]).to eq language.logout_success
    end

    it "should update user status to false" do
      expect(@signed_user.reload.status).to eq false
    end
  end

  context "when a token is not passed in the header" do
    before(:all) do
      get(
        "/api/v1/auth/logout",
        "Accept" => "application/json"
      )
    end

    it "returns a status code of 401" do
      expect(response.status).to eq 401
    end

    it "returns json data" do
      expect(response.content_type).to eq Mime::JSON
    end

    it "returns error message" do
      expect(json(response.body)[:error]).to eq language.access_denied
    end
  end
end
