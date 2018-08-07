require "application_system_test_case"

class WhatsppMessagesTest < ApplicationSystemTestCase
  setup do
    @whatspp_message = whatspp_messages(:one)
  end

  test "visiting the index" do
    visit whatspp_messages_url
    assert_selector "h1", text: "Whatspp Messages"
  end

  test "creating a Whatspp message" do
    visit whatspp_messages_url
    click_on "New Whatspp Message"

    fill_in "Data", with: @whatspp_message.data
    fill_in "Spam", with: @whatspp_message.spam
    fill_in "User", with: @whatspp_message.user_id
    click_on "Create Whatspp message"

    assert_text "Whatspp message was successfully created"
    click_on "Back"
  end

  test "updating a Whatspp message" do
    visit whatspp_messages_url
    click_on "Edit", match: :first

    fill_in "Data", with: @whatspp_message.data
    fill_in "Spam", with: @whatspp_message.spam
    fill_in "User", with: @whatspp_message.user_id
    click_on "Update Whatspp message"

    assert_text "Whatspp message was successfully updated"
    click_on "Back"
  end

  test "destroying a Whatspp message" do
    visit whatspp_messages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Whatspp message was successfully destroyed"
  end
end
