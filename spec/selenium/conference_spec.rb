require File.expand_path(File.dirname(__FILE__) + "/common")

describe "web conference selenium tests" do
  it_should_behave_like "in-process server selenium tests"


  it "should create a web conference" do
    course_with_teacher_logged_in
    get "/courses/#{@course.id}/conferences"

    conference_title = 'new conference'
    driver.find_element(:link, 'Make a New Conference').click

    driver.find_element(:id, 'web_conference_title').clear
    driver.find_element(:id, 'web_conference_title').send_keys(conference_title)
    driver.find_element(:id, 'add_conference_form').submit
    wait_for_ajaximations
    driver.find_element(:link, conference_title).click
    driver.find_element(:id, 'content').text.include?(conference_title).should be_true

  end

  it "should cancel creating a web conference" do
    course_with_teacher_logged_in
    get "/courses/#{@course.id}/conferences"

    conference_title = 'new conference'
    driver.find_element(:link, 'Make a New Conference').click
    driver.find_element(:id, 'web_conference_title').clear
    driver.find_element(:id, 'web_conference_title').send_keys(conference_title)
    driver.find_element(:css, '#add_conference_form button.cancel_button').click
    wait_for_animations
    driver.find_element(:css, '#add_conference_form div.header').text.include?('Start').should be_false
  end

end
