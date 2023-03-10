# frozen_string_literal: true

require 'application_system_test_case'

class Footprint::RegularEventsTest < ApplicationSystemTestCase
  setup do
    @regular_event = regular_events(:regular_event1)
  end

  test 'should be create footprint in /regular_events/:id' do
    visit_with_auth regular_event_path(@regular_event), 'sotugyou'
    within '.user-icons' do
      assert_text '見たよ'
      assert_css '.a-user-icon.is-sotugyou'
    end
  end

  test 'should not footpoint with my own regular event' do
    visit_with_auth regular_event_path(@regular_event), 'komagata'
    within '.user-icons' do
      assert_no_text '見たよ'
      assert_no_css '.a-user-icon.is-komagata'
    end
  end

  test 'show link if there are more than ten footprints' do
    user_data = User.unhibernated.unretired.last(11)
    user_data.map do |user|
      Footprint.create(
        user_id: user.id,
        footprintable_id: @regular_event.id,
        footprintable_type: 'RegularEvent'
      )
    end

    visit_with_auth regular_event_path(@regular_event), 'komagata'
    assert_css '.user-icons__more'
  end

  test 'has no link if there are less than ten footprints' do
    user_data = User.unhibernated.unretired.last(10)
    user_data.map do |user|
      Footprint.create(
        user_id: user.id,
        footprintable_id: @regular_event.id,
        footprintable_type: 'RegularEvent'
      )
    end

    visit_with_auth regular_event_path(@regular_event), 'komagata'
    assert_no_css '.user-icons__more'
  end

  test 'click on the link to view the rest of footprints' do
    user_data = User.unhibernated.unretired.last(11)
    user_data.map do |user|
      Footprint.create(
        user_id: user.id,
        footprintable_id: @regular_event.id,
        footprintable_type: 'RegularEvent'
      )
    end

    visit_with_auth regular_event_path(@regular_event), 'komagata'

    find('.user-icons__more').click
    assert_no_css '.user-icons__more'
  end
end
