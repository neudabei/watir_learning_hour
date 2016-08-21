### (POSSIBLE) SOLUTIONS

require 'watir-webdriver'
browser = Watir::Browser.new

# 1.) Get the title of all computer science programs from coursera.org
browser.goto 'https://www.coursera.org/browse/computer-science/software-development?languages=en'
browser.h2s.each { |h2| puts h2.text }


# --------------------------------------------------------------------------- #


# 2.) Get all edX course categories
browser.goto 'https://www.edx.org/subjects'
browser.divs(:class => 'subject-title').each { |subject| puts subject.text }


# --------------------------------------------------------------------------- #


# 3.) Search for 'Italian' on https://futurelearn.com/search and verify one of the results is 'INTRODUCTION TO ITALIAN'
browser.goto 'https://futurelearn.com/search'
browser.text_field(id: 'q').set('Italian')
browser.button(name: 'commit').click
browser.text.include?('INTRODUCTION TO ITALIAN')


# --------------------------------------------------------------------------- #


# 4.) Join a FutureLearn course 3 times
class CourseEnrolment
  require 'watir-webdriver'
  attr_reader :browser

  def initialize
    @browser = Watir::Browser.new :firefox
    
    join_course
    register
  end

  private

  def join_course
    browser.goto 'https://www.futurelearn.com/courses'
    browser.a(:class => 'title', :title => 'Creative Coding').click
    browser.button(:value => 'Join now – just started').click
  end

  def register
    random_string = ('a'..'z').to_a.shuffle.first(8).join

    browser.text_field(:id => 'user_first_name').set 'Jane'
    browser.text_field(:id => 'user_last_name').set 'Doe'
    browser.text_field(:id => 'user_email').set "jane_doe_#{random_string}@yahoo.com"
    browser.text_field(:id => 'user_password').set '12345678'
    browser.button(:name => 'commit').click
  end
end

3.times do
  CourseEnrolment.new
end


# --------------------------------------------------------------------------- #


# 5.) Save screenshots of major mooc platforms
mooc_platforms = {
                  'Futurelearn' => 'http://www.futurelearn.com',
                  'Coursera' => 'http://coursera.org/',
                  'edX' => 'http://edx.org/',
                  'Udemy' => 'http://udemy.com/',
                  'Lynda' => 'https://www.lynda.com/'
                  }

mooc_platforms.each do |name, url|
  browser.goto url
  browser.screenshot.save name + ' - screenshot.png'
end
# More information on screenshots: https://watirwebdriver.com/screenshots/
