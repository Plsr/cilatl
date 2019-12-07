require 'rails_helper'

describe "the saving process" do
  before :each do
    User.create(email: 'user@example.com', password: 'password')
  end

  it "signs me in" do
    # Sign in
    visit '/sign_in'
    fill_in 'session_email', with: 'user@example.com'
    fill_in 'session_password', with: 'password'
    click_button 'Sign in'

    # Expect redrirect
    expect(current_path).to eql(root_path)
    expect(page).to have_content("You haven't added anything yet.")

    page_mock = eval(file_fixture('meta_data_page.rb').read)
    allow_any_instance_of(MetaData).to receive(:page).and_return(page_mock)

    fill_in 'bookmark[link]', with: 'http://example.com'
    click_button 'Save'

    expect(page).to have_content(page_mock[:title])

    click_on page_mock[:title]
    expect(page).to have_content(page_mock[:title])
    expect(page).to have_content('of the quote what you want, but I interpret it like this: There are times, in writing, when you have')
  end
end
