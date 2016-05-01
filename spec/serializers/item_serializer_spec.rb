require "rails_helper"

describe ItemSerializer, type: :serializer do
  let(:item) { create(:item) }

  let(:serializer) { ItemSerializer.new(item) }

  subject { json(serializer.to_json)[:item] }

  it "should have an id" do
    expect(subject[:id]).to eq item.id
  end

  it "should return item name" do
    expect(subject[:name]).to eq item.name
  end

  it "should return correct done status" do
    expect(subject[:done]).to eq item.done
  end

  it "should return the date created" do
    expect(subject[:date_created]).to eq item.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  it "should return date modified" do
    expect(subject[:date_modified]).to eq item.updated_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
