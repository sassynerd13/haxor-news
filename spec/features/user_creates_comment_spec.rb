require 'spec_helper'

feature 'User comments on an article' do
  background do
    @article = create(:article)
  end

  scenario 'unsuccessfully when not signed in' do
    visit root_path
    click_link '0 comments'
    expect(page).to_not have_button 'Add Comment'

    # Open question: Does this belong in a feature spec? If not here, where?
    page.driver.submit(:post, article_comments_path(@article), { comment: attributes_for(:comment) })
    expect(page).to have_content 'You need to sign in or sign up'
  end

  context 'when signed in', :js do
    background do
      @user = create(:user)
      sign_in_as(@user)
      visit root_path
      click_link '0 comments'
    end

    scenario 'successfully' do
      fill_in 'Enter comment...', with: 'Get off my lawn!'
      click_button 'Add Comment'

      expect(page).to have_content 'Comment added!'
      within('.comment', text: 'Get off my lawn!') do
        expect(page).to have_content "by #{@user.email} less than a minute ago"
      end
    end

    scenario 'unsuccessfully with a blank body' do
      click_button 'Add Comment'

      expect(page).to_not have_content 'Comment added!'
      expect(page).to have_content "Body can't be blank"
    end
  end
end
