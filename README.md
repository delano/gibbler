# Gibbler - v0.10.0

Git-like hashes and history for Ruby objects for Ruby 3.1+.

Check out [this post on RubyInside](http://www.rubyinside.com/gibbler-git-like-hashes-and-history-for-ruby-objects-1980.html).

* [Repo](https://github.com/delano/gibbler)
* [Docs](https://delanotes.com/gibbler)
* [Sponsor](https://solutious.com/)
* [Inspiration](https://www.youtube.com/watch?v=fipD4DdV48g)

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
  $ bundle add gibbler
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
  $ gem install gibbler
```


## Usage

### Example 1 -- Standalone Usage

```ruby
require 'gibbler'

g = Gibbler.new 'id', 1001   # => f4fb3796ababa3788d1bded8fdc589ab1ccb1c3d
g.base(36)                   # => sm71s7eam4hm5jlsuzlqkbuktwpe5h9

g == 'f4fb3796ababa3788d1bded8fdc589ab1ccb1c3d'   # => true
g === 'f4fb379'              # => true
```

### Example 2 -- Mixins Usage

```ruby
require 'gibbler/mixins'

"kimmy".gibbler              # => c8027100ecc54945ab15ddac529230e38b1ba6a1
:kimmy.gibbler               # => 52be7494a602d85ff5d8a8ab4ffe7f1b171587df

config = {}
config.gibbler               # => 4fdcadc66a38feb9c57faf3c5a18d5e76a6d29bf
config.gibbled?              # => false

config[:server] = {
    :users => [:dave, :ali],
    :ports => [22, 80, 443]
}
config.gibbled?              # => true
config.gibbler               # => ef23d605f8c4fc80a8e580f9a0e8dab8426454a8

config[:server][:users] << :yanni

config.gibbler               # => 4c558a56bc2abf5f8a845a69e47ceb5e0003683f

config.gibbler.short         # => 4c558a56

config.gibbler.base36        # => 8x00l83jov4j80i9vfzpaxr9jag23wf

config.gibbler.base36.short  # => 8x00l83j
```

### Example 3 -- Object History

Gibbler can also keep track of the history of changes to an object. By default Gibbler supports history for Hash, Array, and String objects. The `gibbler_commit` method creates a clone of the current object and stores in an instance variable using the current hash digest as the key.

```ruby
require 'gibbler/mixins'
require 'gibbler/history'

a = { :magic => :original }
a.gibbler_commit             # => d7049916ddb25e6cc438b1028fb957e5139f9910

a[:magic] = :updated
a.gibbler_commit             # => b668098e16d08898532bf3aa33ce2253a3a4150e

a[:magic] = :changed
a.gibbler_commit             # => 0b11c377fccd44554a601e5d2b135c46dc1c4cb1

a.gibbler_history            # => d7049916, b668098e, 0b11c377

a.gibbler_revert! 'd7049916' # Return to a specific commit
a.gibbler                    # => d7049916ddb25e6cc438b1028fb957e5139f9910
a                            # => { :magic => :original }

a.delete :magic

a.gibbler_revert!            # Return to the previous commit
a.gibbler                    # => 0b11c377fccd44554a601e5d2b135c46dc1c4cb1
a                            # => { :magic => :changed }


a.gibbler_object 'b668098e'  # => { :magic => :updated }
a.gibbler_stamp              # => 2009-07-01 18:56:52 -0400
```

![](https://delanotes.com/gibbler/img/whoababy.gif)


### Example 4 -- Method Aliases

If you have control over the namespaces of your objects, you can use the method aliases to tighten up your code a bit. The "gibbler" and "gibbled?" methods can be accessed via "digest" and "changed?", respectively. (The reason they're not enabled by default is to avoid conflicts.)

```ruby
require 'gibbler/aliases'

"kimmy".digest               # => c8027100ecc54945ab15ddac529230e38b1ba6a1
:kimmy.digest                # => 52be7494a602d85ff5d8a8ab4ffe7f1b171587df

a = [:a, :b, :c]
a.digest                     # => e554061823b8f06367555d1ee4c25b4ffee61944
a << :d
a.changed?                   # => true
```

The history methods also have aliases which remove the "gibbler_" prefix.


```ruby
    require 'gibbler/aliases'
    require 'gibbler/history'

    a = { :magic => :original }
    a.commit
    a.history
    a.revert!
    # etc...
```

### Example 5 -- Different Digest types

By default Gibbler creates SHA1 hashes. You can change this globally or per instance.

```ruby
require 'gibbler/mixins'

Gibbler.digest_type = Digest::MD5

:kimmy.gibbler               # => 0c61ff17f46223f355759934154d5dcb

:kimmy.gibbler(Digest::SHA1) # => 52be7494a602d85ff5d8a8ab4ffe7f1b171587df
```

In Jruby, you can grab the digest types from the openssl library.

```ruby
require 'openssl'

Gibbler.digest_type = OpenSSL::Digest::SHA256

:kimmy.gibbler               # => 1069428e6273cf329436c3dce9b680d4d4e229d7b7...
```

### Example 6 -- All your base

```ruby
require 'gibbler/mixins'

:kimmy.gibbler               # => 52be7494a602d85ff5d8a8ab4ffe7f1b171587df
:kimmy.gibbler.base(16)      # => 52be7494a602d85ff5d8a8ab4ffe7f1b171587df
:kimmy.gibbler.base(36)      # => 9nydr6mpv6w4k8ngo3jtx0jz1n97h7j

:kimmy.gibbler.base(10)      # => 472384540402900668368761869477227308873774630879
:kimmy.gibbler.to_i          # => 472384540402900668368761869477227308873774630879
```

### Example 7 -- Global secret

Gibbler can prepend all digest inputs with a global secret. You can set this once per project to ensure your project's digests are unique.

```ruby
require 'gibbler/mixins'

:kimmy.gibbler               # => 52be7494a602d85ff5d8a8ab4ffe7f1b171587df

Gibbler.secret = "sUp0r5ekRu7"

:kimmy.gibbler               # => 6c5f5aff4d809cec7e7da091214a35a2698489f8
```

### Supported Classes

Gibbler methods are available only to the classes which explicitly include them [see docs'(https://delanotes.com/gibbler) for details on which classes are supported by default). You can also extend custom objects:

```ruby
class FullHouse
    include Gibbler::Complex
    attr_accessor :roles
end

a = FullHouse.new
a.gibbler                    # => 4192d4cb59975813f117a51dcd4454ac16df6703

a.roles = [:jesse, :joey, :danny, :kimmy, :michelle, :dj, :stephanie]
a.gibbler                    # => 6ea546919dc4caa2bab69799b71d48810a1b48fa
```

`Gibbler::Complex` creates a digest based on the name of the class and the names and values of the instance variables. See the RDocs[http://delano.github.com/gibbler] for other Gibbler::* types.

If you want to support all Ruby objects, add the following to your application:

```ruby
class Object
    include Gibbler::String
end
```

`Gibbler::String` creates a digest based on the name of the class and the output of the to_s method. This is a reasonable default for most objects however any object that includes the object address in to_s (e.g. "Object:0x0x4ac9f0...") will produce unreliable digests (because the address can change).

As of 0.7 all Proc objects have the same digest: `12075835e94be34438376cd7a54c8db7e746f15d`.

### Some things to keep in mind

* Digest calculation may change between minor releases (as it did between 0.6 and 0.7)
* Gibbler history is not suitable for very large objects since it keeps complete copies of the object in memory. This is a very early implementation of this feature so don't rely on it for production code.
* Don't forget to enjoy your life!

## What People Are Saying

* "nice approach - everything is an object, every object is 'gittish'" -- [@olgen_morten](https://twitter.com/olgen_morten/statuses/2629909133)
* "gibbler is just awesome" -- [@TomK32](https://twitter.com/TomK32/statuses/2618542872)
* "wie cool ist Gibbler eigentlich?" -- [@we5](https://twitter.com/we5/statuses/2615274279)
* "it's nice idea and implementation!" --[HristoHristov](https://www.rubyinside.com/gibbler-git-like-hashes-and-history-for-ruby-objects-1980.html#comment-39092)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Contributing

Bug reports and pull requests are welcome [GitHub Issues](https://github.com/delano/gibbler/issues). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/delano/gibbler/blob/main/CODE_OF_CONDUCT.md).

### Thanks

* Kalin Harvey ([krrh](https://github.com/kalin)) for the early feedback and artistic direction.
* Alex Peuchert ([aaalex](https://github.com/aaalex)) for creating the screencast.

* Andrea Barber


## Code of Conduct

Everyone interacting in the Gibbler project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/delano/gibbler/blob/main/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
