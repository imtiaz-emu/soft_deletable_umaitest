require 'faker'
require 'rails_helper'

RSpec.describe List, :type => :model do
  before do
    @list = List.new(title: Faker::Lorem.sentence)
  end

  subject { @list }

  describe "when title is not present" do
    before { @list.title = "" }
    it { should_not be_valid }
  end
end