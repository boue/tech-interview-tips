
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

describe "Authorization", type => :feature do

  it "let's user login and shows logout link" do
    visit '/'
    click_link('Sign in')
    click_link('Using GitHub')
    page.should have_link "Logout"

    # example for waiting
    # find("href").click_link("baz")
    # <a href="/auth/github">Using GitHub</a>

  end
end

