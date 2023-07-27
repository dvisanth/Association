require 'rails_helper'

RSpec.describe "topics/show", type: :view do
  before(:each) do
    assign(:topic, Topic.create!(
      name: "Name",
      facts: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
