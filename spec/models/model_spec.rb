require 'spec_helper'

describe Answer do
  context "associations" do
    it { should belong_to :question }
    it { should belong_to :category }
    it { should belong_to :user }
    it { should have_many :favorites }
    it { should have_many :kudos }
  end
end