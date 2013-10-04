require 'spec_helper'

describe "Static pages" do
  subject { page }
  let(:login) { "Sign in" }
  
  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    it_should_behave_like "all static pages"

    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
      it "should pluralize sidebar feed header" do
        expect(page).to have_content("micropost".pluralize(user.feed.count))
      end
      describe "pagination" do
        it "should paginate the feed" do
          30.times { FactoryGirl.create(:micropost, user: user, content: "Consectetur adipiscing elit") }
          visit root_path
          page.should have_selector("div.pagination")
        end
      end
      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end
        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    it_should_behave_like "all static pages"

    let(:heading)    { 'Help' }
    let(:page_title) { '' }
  end

  describe "About page" do
    before { visit about_path }
    it_should_behave_like "all static pages"

    let(:heading)    { 'About Us' }
    let(:page_title) { '' }
  end

  describe "Contact page" do
    before { visit contact_path }
    it_should_behave_like "all static pages"

    let(:heading)    { 'Contact' }
    let(:page_title) { '' }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "sample app"
    expect(page).to have_content('Welcome to the Sample App')
    click_link "Home"
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
  end
end
