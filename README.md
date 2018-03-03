## Fuzz: interactively select Ruby objects with `rofi`, `dmenu`, or `pick`

[![Build Status](https://travis-ci.org/hrs/fuzz.svg?branch=master)](https://travis-ci.org/hrs/fuzz)
[![Maintainability](https://api.codeclimate.com/v1/badges/326b820a889742177ec2/maintainability)](https://codeclimate.com/github/hrs/fuzz/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/hrs/fuzz/badge.svg?branch=master)](https://coveralls.io/github/hrs/fuzz?branch=master)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

I often write scripts in which a user needs to choose one of a number of
possibilities: maybe they need to select a directory, or a file, or an action,
or just an arbitrary object.

[rofi][] and [dmenu][] are really cool tools for that! They provide a visual way
for a user to use fuzzy searching to choose among a selection of strings.
[pick][] provides a similar service on the command line with ncurses.

Unfortunately, though, these tools do *just* choose between strings. But my
scripts would often be a lot simpler if the user were able to select arbitrary
Ruby objects. Fuzz manages the translation between lists of strings that can be
selected through these visual pickers and the associated collection of Ruby
objects, which makes it a bit easier to write interactive and OOP-friendly Ruby
scripts.

[rofi]: https://github.com/DaveDavenport/rofi
[dmenu]: https://tools.suckless.org/dmenu
[pick]: https://github.com/calleerlandsson/pick

### For example

I'm a fan of the excellent [RubyTapas screencasts][], and I'd like a script to
let me interactively search through their titles to pick one to play. Here's a
way I could do that:

```ruby
require "fuzz"

# Instantiate some File objects:
episodes = Dir.glob("~/ruby_tapas_episodes/*")

# Have the user pick one with rofi:
choice = Fuzz::Selector.new(episodes).pick

# Play the selected file with VLC:
system("vlc \"#{ choice.path }\"")
```

The call to `#pick` will call `#to_s` on every episode, display the results
through `rofi` (the default picker), get the user's choice, and use that to
return the corresponding object.

[RubyTapas screencasts]: https://www.rubytapas.com/

### Caching selections

If you run your script frequently you may find that you often make the same
selections. It's convenient to have those selections appear near the top of the
list.

Fuzz can maintain a script-specific record of your previous selections and
order your options from most to least popular. Just include an optional `:cache`
argument when creating a `Fuzz::Selector`:

```ruby
Fuzz::Selector.new(
  some_objects,
  cache: Fuzz::Cache.new("~/.cache/fuzz/my_script_cache"),
)
```

You'll want to use a different file for each script. Using the same cache file
for different scripts will probably yield weird results.

I think `~/.cache/fuzz/` is a nice directory for your personal script caches,
and it complies with the [XDG Base Directory Specification][], but you can keep
'em wherever you'd like.

[XDG Base Directory Specification]: https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

### Supplying a default value

If the user enters a string that doesn't correspond to an object,
`Fuzz::Selector#pick` will normally return `nil`.

However, you can manually specify a default return value with the `default:`
option:

```ruby
Fuzz::Selector.new(
  [1, 2, 3],
  default: 42,
).pick # => returns 42 if the user picks a value other than 1, 2, or 3
```

### Choosing a different picker

Fuzz ships with support for `rofi` and `dmenu`. The `Fuzz::Selector` constructor
takes an optional `picker:` argument to pick a picker.

For example, to use `dmenu` as your picker:

```ruby
Fuzz::Selector.new(
  some_objects,
  picker: Fuzz::DmenuPicker.new,
)
```

Or to search in a terminal with the `pick` tool:

```ruby

Fuzz::Selector.new(
  some_objects,
  picker: Fuzz::PickPicker.new,
)
```

The `rofi` picker is the default, but you can also explicitly specify it:

```ruby
Fuzz::Selector.new(
  some_objects,
  picker: Fuzz::RofiPicker.new,
)
```

If your chosen picker can't be found (perhaps it's not installed, or not in your
`$PATH`), `Fuzz::Selector#pick` will raise a `Fuzz::MissingExecutableError`.

### Extending `fuzz` with new pickers

It's possible to extend `fuzz` to use a picker of your choice. The object
supplied to `picker:` must implement a `#pick` method, which should take an
array of strings and return a string.

Here's a simple example with a silly picker that always chooses the first
option:

```ruby
def PickFirst
  def pick(choices)
    choices.first
  end
end

selector = Fuzz::Selector.new(
  [1, 2, 3, 4, 5],
  picker: PickFirst.new,
)

selector.pick # => 1
```

Your custom pickers will probably be more interactive than this! =)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "fuzz"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fuzz

### Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

### Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/hrs/fuzz. This project is intended to be a safe, welcoming
space for collaboration, and contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org) code of conduct.

### Code of Conduct

Everyone interacting in the Fuzz project’s codebases, issue trackers, chat rooms
and mailing lists is expected to follow the [code of
conduct](https://github.com/hrs/fuzz/blob/master/CODE_OF_CONDUCT.md).
