# Watir WebDriver FutureLearn Learning Hour


### Setup instructions

- Download this git repository `$ git clone git@github.com:neudabei/watir_learning_hour.git` 
- `$ cd watir_learning_hour` and run `$ bundle install` 
- Install Firefox: https://download.mozilla.org/?product=firefox-47.0.1-SSL&os=osx&lang=en-US
(alternatively see these instructions for using Watir WebDriver with Chrome: https://watirwebdriver.com/chrome/)
- Watir documentation: https://watir.com/documentation/ and https://watirwebdriver.com/
- Watir source code: https://github.com/watir/watir-webdriver/



### Introduction

Watir WebDriver can be used to give instructions to your browser in Ruby.

Watir WebDriver is popular for testing. In this learning hour we focus on using Watir for interacting with websites to browse through them and read data. Watir WebDriver uses Selenium-WebDriver under the hood.

The Watir syntax is very idiomatic. Once you create an instance of a Watir browser by calling `Watir::Browser.new` you can send it commands, such as `browser.goto 'http://www.google.com'`. If not run headless, which is the default, you can see a browser window and follow the executed instructions. 

You can combine manual browsing with commands in Ruby. Verify how the current page, even after manual browsing is tracked by Watir. You can verify this by manually browsing to a different page from your Watir Browser window and calling `browser.url`.

The hardest part is often finding how to uniquely identify and access elements of interest on a site. Elements can be found by their HTML attributes, such as `class`, `id`, `name`, e.g. `browser.button(:name => 'submit')`, or by using xPath. Often there is more than one way to find information. Note that you can also ask Watir to return all types of an element on a page, e.g. `browser.h1s` will return all `h1` headers on the present page. You can iterate over the returned results with Ruby's built in methods, such as `Array#each` or `String#include?`. 



### Get started with Watir

- include the library: `require 'watir-webdriver'` 
- create an instance of a new browser: `browser = Watir::Browser.new` 
- direct the browser to a url: `browser.goto 'http://www.futurelearn.com'` 
- Fill out a simple form: 


```ruby
  require 'watir-webdriver'
  browser = Watir::Browser.new
  browser.goto 'bit.ly/watir-webdriver-demo'
  browser.text_field(:id => 'entry_1000000').set 'your name'
  browser.select_list(:id => 'entry_1000001').select 'Ruby'
  browser.select_list(:id => 'entry_1000001').selected? 'Ruby'
  browser.button(:name => 'submit').click
  browser.text.include? 'Thank you'

  # An example from https://watirwebdriver.com/
```

- Get the names of Coursera's partners and write them to a file:

```ruby
require 'watir-webdriver'
browser = Watir::Browser.new
browser.goto 'https://www.coursera.org/about/partners'

# Coursera lists they have 145 partners. 
browser.divs(class: 'partner-box-wrapper card-one-clicker flex-1').count
# => 145 indeed

# Get all partners names
scraped_list = browser.divs(class: 'partner-box-wrapper card-one-clicker flex-1').map(&:text)

class FileMaker
  require 'csv'
  attr_reader :scraped_list

  def initialize(scraped_list)
    @scraped_list = scraped_list
  end

  def save_file
    File.open("scraped_list.txt", "w+") do |file|
      file.puts scraped_list
    end
  end
end

FileMaker.new(scraped_list).save_file
```



### Further reading

- A tutorial for interacting with Watir: https://www.sitepoint.com/watir-webdriver-control-browser/
- A freemium ebook on Watir: https://leanpub.com/watirways/read
- An ebook on Watir: https://leanpub.com/watir-recipes
