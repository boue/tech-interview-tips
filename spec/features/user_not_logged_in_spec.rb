require 'spec_helper'

describe "Options when not logged in", :type => :feature do

  it "shows Sign in link" do
    visit '/'
    expect(page).to have_content 'Sign in'
  end

  it "prevents adding a question if not signed in" do
    visit '/'
    click_link('Post a Question')
    expect(page).to have_content 'Sign in'
    expect(current_path).to eq('/')
  end

end

describe "Authorization", :js => true do

  xit "let's user login and shows logout link" do
    # create_omniauth_user
    visit '/'
    click_link('Sign in')
    find("#github").click_link('Using GitHub')
    expect(page).to have_content "Sign out"

    # this follows the 'using github' link but returns a 500
    #  Internal server error, maybe because it has no user.
    # line 22 may not be enough
  end
end

