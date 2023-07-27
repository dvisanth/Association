require 'rails_helper'

RSpec.describe "topics/new", type: :view do
  before(:each) do
    assign(:topic, Topic.new(
      name: "MyString",
      facts: "MyText"
    ))
  end

  it "renders new topic form" do
    render

    assert_select "form[action=?][method=?]", topics_path, "post" do

      assert_select "input[name=?]", "topic[name]"

      assert_select "textarea[name=?]", "topic[facts]"
    end
  end
end
