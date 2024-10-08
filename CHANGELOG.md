# GIBBLER, CHANGES

## Releases

### 0.9.0 (2012-04-20)

* FIXED: Gibbler::Complex now checks has_method? and will use that before instance variables.
* CHANGE: Gibbler is now a class which supplies the default standalone usage
* CHANGE: Ruby object mixins must now be explicitly loaded via "require 'gibbler/mixins'"
* CHANGE: Removed Gibbler.enable_debug/disable_debug
* CHANGE: Gibbler.digest now returns nil for an empty Array
* ADDED: Gibbler.delimiter

### 0.8.10 (2011-10-23)

* CHANGE: Gibbler::Hash and Gibbler::Array now skip values that have no __gibbler method

### 0.8.9 (2011-02-11)

* FIXED: Remove debug output.

### 0.8.8 (2011-02-11)

* FIXED: Bundler calls freeze on an instance of Gem::Platform

### 0.8.7 (2011-02-07)

* CHANGE: Only call gibbler_debug when in debug mode

### 0.8.6 (2010-12-24)

* FIXED: Gibber::VERSION (File error)

### 0.8.5 (2010-12-23)

* CHANGE: Gibbler::Complex will skip fields with no __gibbler method
* ADDED: Gibbler.debug=

### 0.8.4 (2010-06-19)

ADDED: Support for Gibbler.default_base which affects all generated digests.

### 0.8.3 (2010-05-04)

* ADDED: Support for global secret (Gibbler.secret) which is prepended to all digests.

### 0.8.2 (2010-04-29)

* FIXED: test exception for "String has list of attic vars" tryouts when bundled with my other libraries.
* CHANGE: Gibbler::Complex.gibbler will now append fields when called multiple times.

### 0.8.1 (2010-04-11)

NOTE: Digest calculation for Range objects has changed.
Ranges or objects containing Ranges will have different
digests than those created in previous releases.

* FIXED: "can't iterate from Float" error for Ranges containing a Float
* CHANGE: Range digests are now based on the format "CLASS:FIRST:LAST:VALUE"

### 0.8.0 (2010-04-08)

* CHANGE: Gibber::Object#__gibbler now accepts only 1 optional argument: digest_type
* ADDED: Gibbler::Digest#to_i which assumes base 16
* ADDED: Gibbler::Object#gibbler now accepts a digest type
* ADDED: Gibbler::Digest#to_s and #base can take a base argument

### 0.7.7 (2010-03-29)

* ADDED: Gibbler::Digest#shorten

### 0.7.6 (2010-03-18)

* FIXED: The previous fix missed the case where gibbler_fields was null

### 0.7.5 (2010-03-18)

* FIXED: :undefined method `each' for :fieldname:Symbol when only one element in gibbler_fields

### 0.7.4 (2010-02-12)

* CHANGE: Remove hanna dependency [Diego Elio 'Flameeyes' Pettenò]

### 0.7.3 (2010-01-15)

* ADDED: Support for base36 representations of digests

### 0.7.2 (2009-12-08)

* FIXED: Gibbler::Complex no longer includes the '@' for instance
  variable names used in digest calculation.
* ADDED: Gibbler::Complex support for specifying which fields
  to use in digest calculation.

### 0.7.1 (2009-10-09)

* FIXED: Gibbler::Complex now sorts instance variables before processing.
  This resolves the issue of digest compatibility between 1.8, 1.9, and JRuby.

### 0.7.0 (2009-10-07)

NOTE: Digest calculation for Proc objects has changed. Procs
or objects containing Procs will have different digests than
those created in previous releases.

* CHANGE: Proc digests are now based on the values of obj.class
  and obj.name (if available).

### 0.6.4 (2009-10-07)

* FIXED: Now using correct superclass for DateTime (Date)
* CHANGE: aliases.rb will now require gibbler so you don't need to specify both.
  i.e. require 'gibbler'
       require 'gibbler/aliases'
* CHANGE: Gibbler::Object#gibbler returns the value of gibbler_cache when
  the object is frozen, without calculation.
* ADDED: Gibbler::Object#freeze to create digest before freezing.
* ADDED: Out of the box support for Regexp (Gibbler::String)
* ADDED: Gibbler::Object#digest_cache alias for gibbler_cache

### 0.6.3 (2009-09-30)

* FIXED: Won't save digest to cache if the object is frozen
* CHANGE: Renamed __gibbler_cache to gibbler_cache (with backwards compatability)
* CHANGE: Gibbler::Digest#== now returns true only for exact matches
* ADDED: Gibbler::Digest#shorter, Gibbler::Digest#tiny, Gibbler::Digest#===

### 0.6.2 (2009-09-15)

* FIXED: Enforce specific string format for Time objects. Fixes
  an issue with Ruby 1.8.7 which formats the to_s value differently
  than 1.8.6 and 1.9.1.
* ADDED: Support for NilClass, File, and URI

### 0.6.1 (2009-08-25)

* ADDED: Support for Date, Time, and DateTime. Time and DateTime
  refers to times in UTC.
* ADDED: Support for Range.

### 0.6.0 (2009-07-20)

NOTE: Digest calculation for Proc and Class objects have changed.
Digests created for these types will not match previous releases.

* FIXED: Proc digests no longer refer to Proc#binding
* CHANGE: The Gibbler module now raises an exception if it's included
* CHANGE: Module and Class now use the default Gibbler::Object digest
* ADDED: Gibbler::Object now contains a default digest method

### 0.5.4 (2009-07-17)

* FIXED: Improved support for Symbol and Fixnum objects with Attic 0.4

### 0.5.3 (2009-07-12)

* FIXED: Updated gemspec to fix missing files (aliases)
* CHANGE: conversion to attic instead of weirdo instance
  variables (@__gibbler__ and @__gibbler_history)
* NEW DEPENDENCY: attic

### 0.5.2 (2009-07-07)

* CHANGE: Moved Gibbler instance methods to Gibbler::Object
* ADDED: Proc.gibbler which is included by default
* ADDED: gibbler aliases to allow shorter methods by request.

### 0.5.1 (2009-07-06)

* CHANGE: Renamed gibbler_revert to gibbler_revert! (Thanks ivey)

### 0.5 (2009-07-01)

NOTE: This is a significant change from 0.4. Many method names
have been modified so this release is not backwards compatible.

* CHANGE: Now refer to "gibble" as "digest" in all docs and methods.
* CHANGE: Gibbler#gibble -> Gibbler#gibbler
* CHANGE: Gibble is now Gibbler::Digest
* ADDED: Gibbler::History, supporting gibbler_snapshots and gibbler_revert
  for the following objects: Array, Hash
* ADDED: Support for short, 8-character digests
* ADDED: Expanded test coverage

### 0.4 (2009-06-30)

NOTE: Calculated digests have changed since 0.3. Most digests created with
0.3 and earlier will not match those created in 0.4 for the same object

* FIXED: Hash and Array now use the class of the value for hashing
  rather than Hash or Array (respectively).
* FIXED: __gibbler methods now return a digest based on their own class.
  Previously, all digests were created by String.__gibbler so the class
  name from the original object got lost.
* CHANGE: Gibbler methods are no longer available to all Ruby classes
  by default. The default list is now: String, Hash, Array, Symbol,
  Class, Fixnum, Bignum.
* CHANGE: Renamed Gibbler.digest_type to Gibbler.digest_type
* ADDED: Custom objects can now "include Gibbler::Complex"

### 0.3 (2009-06-29)

* CHANGE: Renamed to_gibble -> gibble
* CHANGE: Renamed __default_gibbler to__gibbler
* CHANGE: Created Gibbler module, all other modules can
  include its junk into their namespace.
* ADDED: Object#hash and performance tryouts

### 0.2 (2009-06-25)

NOTE: Initial release
