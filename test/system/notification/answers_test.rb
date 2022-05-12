# frozen_string_literal: true

require 'application_system_test_case'

class Notification::AnswersTest < ApplicationSystemTestCase
  setup do
    @notice_text = 'komagataさんから回答がありました。'
  end

  test "receive a notification when I got my question's answer" do
    visit_with_auth "/questions/#{questions(:question2).id}", 'komagata'
    within('.thread-comment-form__form') do
      fill_in('answer[description]', with: 'reduceも使ってみては？')
    end
    click_button 'コメントする'
    assert_text '回答を投稿しました！'

    visit_with_auth '/notifications', 'sotugyou'

    within first('.card-list-item.is-unread') do
      assert_text @notice_text
    end

    visit_with_auth '/', 'komagata'
    refute_text @notice_text
  end
end
