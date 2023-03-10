# frozen_string_literal: true

require 'application_system_test_case'

class Notification::RetirementTest < ApplicationSystemTestCase
  setup do
    @delivery_mode = AbstractNotifier.delivery_mode
    AbstractNotifier.delivery_mode = :normal
  end

  teardown do
    AbstractNotifier.delivery_mode = @delivery_mode
  end

  test 'notify admins and mentors when a user retire' do
    visit_with_auth notifications_path, 'komagata'
    find('#notifications.loaded', wait: 10)
    within first('.card-list-item') do
      assert_no_selector '.card-list-item-title__link-label', text: '๐ข kimuraใใใ้ไผใใพใใใ'
    end

    visit_with_auth new_retirement_path, 'kimura'
    find('label', text: 'ใจใฆใ่ฏใ').click
    click_on '้ไผใใ'
    page.driver.browser.switch_to.alert.accept
    assert_text '้ไผๅฆ็ใๅฎไบใใพใใ'

    visit_with_auth notifications_path, 'komagata'
    find('#notifications.loaded', wait: 10)
    within first('.card-list-item.is-unread') do
      assert_selector '.card-list-item-title__link-label', text: '๐ข kimuraใใใ้ไผใใพใใใ'
    end
  end

  test 'notify admins when three months after retirement' do
    mock_log = []
    stub_info = proc { |i| mock_log << i }
    Rails.logger.stub(:info, stub_info) do
      visit_with_auth '/scheduler/daily/after_retirement', 'komagata'
    end

    visit '/notifications'
    assert_text 'yameoใใใ้ไผใใฆใใ3ใซๆใ็ต้ใใพใใใ'
    assert_text 'kensyuowataใใใ้ไผใใฆใใ3ใซๆใ็ต้ใใพใใใ'
    assert_match 'Message to Discord.', mock_log.to_s
  end
end
