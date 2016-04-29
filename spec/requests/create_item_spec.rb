require "rails_helper"

describe "Item Create Action", type: :request do
  let(:bucketlist) { create(:bucketlist) }

  context "creating an item with valid data" do
    before do
      post(
        "/api/v1/bucketlists/#{bucketlist.id}/items",
        { item: { name: "New item", done: false } }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "should return a status code of 201" do
      expect(response.status).to eq 201
    end

    it "should return json data" do
      expect(Mime::JSON).to eq response.content_type
    end

    # it "should return the correct location" do
    #   item_id = json(response.body)[:id]
    #   binding.pry
    #   expect(response.location).to eq api_v1_bucketlist_item_url(item_id)
    # end

    it "should return the created item" do
      item = json(response.body)
      expect(item[:name]).to eq "New item"
      expect(item[:done]).to eq false
    end
  end

  context "creating an item with invalid data" do
    before do
      post(
        "/api/v1/bucketlists/#{bucketlist.id}/items",
        { item: { name: nil, done: false } }.to_json,
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      )
    end

    it "should return a status code of 422" do
      expect(response.status).to eq 422
    end

    it "should return error messages" do
      expect(json(response.body)[:error]).to eq "Unable to create new item"
    end
  end
end
