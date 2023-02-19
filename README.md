# Solidus Chartkick

A [Chartkick](https://chartkick.com) dashboard tab for your solidus app. This extension works by taking a list of SolidusChartkick::Expression objects in your configuration file. 

The expression object is a simple wrapper around a lambda which generates a Chartkick chart, and a label to display on the page. The lambdas have 3 arguments. 

```ruby
period: :day, :week, or :month
start_gt: start time as selected by user in their admin panel
end_lt: finish time as selected by user in their admin panel
```

Basic installation will create a configuation file like: 

```ruby
SolidusChartkick.configure do |config|
  include Chartkick::Helper

  # User Created Count
  config.expressions << SolidusChartkick::Expression.new('Users Created', ->(period, start_gt, end_lt) {
    scope = Spree::User.group_by_period(period, :created_at, range: start_gt..end_lt)
    line_chart scope.count
  })

  # Order Total Sum
  config.expressions << SolidusChartkick::Expression.new('Order Totals', ->(period, start_gt, end_lt) {
    scope = Spree::Order.complete.group_by_period(period, :completed_at, range: start_gt..end_lt)
    line_chart scope.sum(:total)
  })

  # Order Containing Product Count (We only sell 1 of a product in a cart max at Minimal Audio)
  config.expressions << SolidusChartkick::Expression.new('Products Sold', ->(_period, start_gt, end_lt) {
    scope = Spree::Order.where(completed_at: start_gt.beginning_of_day..end_lt.end_of_day).joins(:products)
    column_chart scope.group(:name).count
  })
end
```

Results look like: 

<img width="1686" alt="Screenshot 2023-02-19 at 2 40 32 PM" src="https://user-images.githubusercontent.com/11396462/219979604-5f6c6518-58f3-44c4-84f2-84f4d255fc41.png">

## Installation

Add solidus_chartkick to your Gemfile:

```ruby
gem 'solidus_chartkick'
```

Bundle your dependencies and run the installation generator:

```shell
bin/rails generate solidus_chartkick:install
```

## Usage

<!-- Explain how to use your extension once it's been installed. -->

## Development

### Testing the extension

First bundle your dependencies, then run `bin/rake`. `bin/rake` will default to building the dummy
app if it does not exist, then it will run specs. The dummy app can be regenerated by using
`bin/rake extension:test_app`.

```shell
bin/rake
```

To run [Rubocop](https://github.com/bbatsov/rubocop) static code analysis run

```shell
bundle exec rubocop
```

When testing your application's integration with this extension you may use its factories.
Simply add this require statement to your `spec/spec_helper.rb`:

```ruby
require 'solidus_chartkick/testing_support/factories'
```

Or, if you are using `FactoryBot.definition_file_paths`, you can load Solidus core
factories along with this extension's factories using this statement:

```ruby
SolidusDevSupport::TestingSupport::Factories.load_for(SolidusChartkick::Engine)
```

### Running the sandbox

To run this extension in a sandboxed Solidus application, you can run `bin/sandbox`. The path for
the sandbox app is `./sandbox` and `bin/rails` will forward any Rails commands to
`sandbox/bin/rails`.

Here's an example:

```
$ bin/rails server
=> Booting Puma
=> Rails 6.0.2.1 application starting in development
* Listening on tcp://127.0.0.1:3000
Use Ctrl-C to stop
```

### Updating the changelog

Before and after releases the changelog should be updated to reflect the up-to-date status of
the project:

```shell
bin/rake changelog
git add CHANGELOG.md
git commit -m "Update the changelog"
```

### Releasing new versions

Please refer to the dedicated [page](https://github.com/solidusio/solidus/wiki/How-to-release-extensions) on Solidus wiki.

## License

Copyright (c) 2023 Minimal Audio, released under the New BSD License.
