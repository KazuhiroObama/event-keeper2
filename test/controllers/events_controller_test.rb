require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { content: @event.content, deadline_of_participant_for_event: @event.deadline_of_participant_for_event, ending_time: @event.ending_time, event_day: @event.event_day, image: @event.image, maximum_number_of_people: @event.maximum_number_of_people, opening_time: @event.opening_time, organizer_id: @event.organizer_id, receptionist: @event.receptionist, title: @event.title } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { content: @event.content, deadline_of_participant_for_event: @event.deadline_of_participant_for_event, ending_time: @event.ending_time, event_day: @event.event_day, image: @event.image, maximum_number_of_people: @event.maximum_number_of_people, opening_time: @event.opening_time, organizer_id: @event.organizer_id, receptionist: @event.receptionist, title: @event.title } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
