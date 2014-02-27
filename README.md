# AJAXer News 2: CoffeeScript Boogaloo

It's back! Again! This time I'm giving you the Rails code for my Hacker News clone, but this version has no JSON API and no AJAX of any kind... yet. Your task is to AJAXify comment submission using CoffeeScript. No plain JavaScript allowed!

You can do this using either of the two AJAX techniques we've seen: Create a JSON API, or use JS templates with `remote: true` &ndash; in this case they would be `.js.coffee.erb` templates. In either case, make sure you're inserting the new comment at the correct position in the list, given that comments are sorted by score.

**Note:** This project has existing feature specs, and they should all still pass once your changes are in place. The only wrinkle is that you'll need to add a `:js` tag to features or contexts that use AJAX, as described in the "Test" section below.

## Setup

1. Install [PhantomJS](http://phantomjs.org/) (one-time, like installing Postgres)
  * **Mac:** `brew install phantomjs`
  * **Ubuntu:** `sudo apt-get install phantomjs`
2. Install [Poltergeist](https://github.com/jonleighton/poltergeist)
  * Add `gem 'poltergeist'` to the `:test` group in the `Gemfile`
  * In `spec_helper.rb`, add: `require 'capybara/poltergeist'`
  * In `spec_helper.rb`, add: `Capybara.javascript_driver = :poltergeist`
  * Ensure `database_cleaner` is configured to use truncation for specs tagged `:js`
3. Install [CoffeeScript Rails Source Maps](https://github.com/markbates/coffee-rails-source-maps)
  * Add `gem 'coffee-rails-source-maps'` to the `:development` group in the `Gemfile`
  * In `.gitignore`, add the line: `/public/assets/source_maps`

## Test

* In `user_creates_comment_spec.rb`, change `context 'when signed in' do` to `context 'when signed in', :js do`. Run RSpec and all tests should still pass, though you should see them run a bit slower.
* In `app/assets/javascripts`, create a file `test.js.coffee` and put some CoffeeScript code in there with a `debugger` statement somewhere. Go to the Sources tab in your Chrome console, reload the site, and you should see the debugger paused in your CoffeeScript code, not the compiled JavaScript.
