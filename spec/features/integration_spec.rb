
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
