require 'test_helper'

class WhatsppMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @whatspp_message = whatspp_messages(:one)
  end

  test "should get index" do
    get whatspp_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_whatspp_message_url
    assert_response :success
  end

  test "should create whatspp_message" do
    assert_difference('WhatsppMessage.count') do
      post whatspp_messages_url, params: { whatspp_message: { data: @whatspp_message.data, spam: @whatspp_message.spam, user_id: @whatspp_message.user_id } }
    end

    assert_redirected_to whatspp_message_url(WhatsppMessage.last)
  end

  test "should show whatspp_message" do
    get whatspp_message_url(@whatspp_message)
    assert_response :success
  end

  test "should get edit" do
    get edit_whatspp_message_url(@whatspp_message)
    assert_response :success
  end

  test "should update whatspp_message" do
    patch whatspp_message_url(@whatspp_message), params: { whatspp_message: { data: @whatspp_message.data, spam: @whatspp_message.spam, user_id: @whatspp_message.user_id } }
    assert_redirected_to whatspp_message_url(@whatspp_message)
  end

  test "should destroy whatspp_message" do
    assert_difference('WhatsppMessage.count', -1) do
      delete whatspp_message_url(@whatspp_message)
    end

    assert_redirected_to whatspp_messages_url
  end
end
