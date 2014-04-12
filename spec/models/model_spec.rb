require 'spec_helper'

describe User do
  context "associations" do
    it { should have_many :questions }
    it { should have_many :answers }
    it { should have_many :favorites }
    it { should have_many :kudos }
  end
end

describe Question do
  context "associations" do
    it { should belong_to :user }
    it { should have_many :favorites }
    it { should have_many :answers }
  end

  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end

describe Answer do
  context "associations" do
    it { should belong_to :question }
    it { should belong_to :category }
    it { should belong_to :user }
    it { should have_many :favorites }
    it { should have_many :kudos }
  end

  context "validations" do
    it { should validate_presence_of :content }
  end
end

describe Comment do
  context "associations" do
    it { should have_many :comments }
  end

  context "validations" do
    it { should validate_presence_of :content }
  end
end





describe Category do
  context "associations" do
    it { should have_many :answers }
  end

  context "validations" do
    it { should validate_uniqueness_of :content}
  end
end

describe Favorite do
  context "associations" do
    it { should belong_to :user }
    it { should belong_to :favoritable }
  end
end

describe Kudo do
  context "associations" do
    it { should belong_to :user }
    it { should belong_to :kudosible }
  end
end