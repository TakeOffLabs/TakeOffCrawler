# TakeOffCrawler

TakeOffCrawler parses a text and identifies URLs, which are crawled to obtain meta-content like title and description and relevant photos. 

## Demo
![Sample 1](http://f.cl.ly/items/3Y2A1A3r39330o1m1713/Screen%20Shot%202014-02-12%20at%2012.14.33%20PM.png)
![Sample 2](http://f.cl.ly/items/1F2o08033b3m3v432l2L/Screen%20Shot%202014-02-12%20at%2012.15.58%20PM.png)
![Sample 3](http://f.cl.ly/items/112U0x1N3S3F001D0H35/Screen%20Shot%202014-02-12%20at%2012.16.06%20PM.png)

## Installation

Add to your Gemfile and run the `bundle` command to install it.

 ```ruby
 gem "take_off_crawler", git: "git@github.com:TakeOffLabs/TakeOffCrawler.git"
 ```

**Requires Ruby 1.9.2 or later.**


## Usage

To use the gem, run the following command:

  ```ruby
  rails g take_off_crawler:install
  rake db:migrate
  ```
This will generate a model called TakeOffCrawler::Links in which we will save all crawled links.
Then pass the content of a text field to the controller and get your link objects like this:

  ```ruby
  @link = TakeOffCrawler.preview content
  ```
  
You can choose to display the content in whatever form you want.