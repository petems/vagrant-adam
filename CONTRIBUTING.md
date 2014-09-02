# Contributing

## Developing

If you'd like to submit a patch:

1. Fork the project.
2. Make your feature addition or bug fix.
3. Add [tests](#testing) for it. This is important so that it isn't broken in a
   future version unintentionally.
4. Commit. **Do not touch any unrelated code, such as the gemspec or version.**
   If you must change unrelated code, do it in a commit by itself, so that it
   can be ignored.
5. Send a pull request.

## Testing

### Install prerequisites

Install the latest version of [Bundler](http://gembundler.com)

    $ gem install bundler

Clone the project

    $ git clone git://github.com/petems/vagrant-adam.git

and run:

    $ cd vagrant-adam
    $ bundle install

Bundler will install all gems and their dependencies required for testing and developing.

### Unit Tests (rspec)

The unit tests can be run with:

```
bundle exec rake test:unit
```

The tests are also executed by Travis CI every time code is pushed to GitHub.

### Acceptance

Currently this repo ships with a set of basic acceptance tests that will:

* Provision a Vagrant instance.
* Attempt to run a given script

The acceptance tests use aruba, and can be ran like so:

```
bundle exec rake features:run
```