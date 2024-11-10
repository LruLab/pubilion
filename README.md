# Pubilion

Pubilion is a Ruby gem that provides a simple way to use ActiveJob with Cloud Pub/Sub.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pubilion'
```

And execute command:

```bash
bundle install
```

## Usage

> [!NOTE]
> This gem is built to be used with rails.
> There is currently no usage in Plain Ruby.

### Configuration

1. Generate initializer file.

```bash
rails generate pubilion:install
```

2. Specify settings in the initializer file. See your `config/initializers/pubilion.rb` for details.

### Message Publish

1. Set queue adapter to `pub_sub`.

```ruby
# config/application.rb
config.active_job.queue_adapter = :pub_sub
```

or

```ruby
# app/jobs/application_job.rb (or any other job file)
class ApplicationJob < ActiveJob::Base
  self.queue_adapter = :pub_sub
end
```

2. Create a job class.

```ruby
# app/jobs/hello_job.rb
class HelloJob < ApplicationJob
  # `queue_as` is recognized as a Topic name.
  queue_as :topic_name

  def perform(*args)
    puts "Hello, World!"
  end
end
```

3. Call `perform_later`.

```ruby
HelloJob.perform_later
```

### Message Subscribe

> [!NOTE]
> Currently, the worker is support only single subscription.
> If you want to use multiple subscriptions, you need to create worker per subscription.

1. Run the worker.

```bash
bundle exec rake pubilion:worker:start
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LruLab/pubilion.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
