require 'gibbler'

class NilClass;            include Gibbler::Nil;       end
class String;              include Gibbler::String;    end
class Symbol;              include Gibbler::String;    end
class Fixnum;              include Gibbler::String;    end
class Bignum;              include Gibbler::String;    end
class TrueClass;           include Gibbler::String;    end
class FalseClass;          include Gibbler::String;    end
class Class;               include Gibbler::Object;    end
class Module;              include Gibbler::Object;    end
class Proc;                include Gibbler::Object;    end
class Regexp;              include Gibbler::String;    end
class Float;               include Gibbler::String;    end
class Date;                include Gibbler::String;    end
class Hash;                include Gibbler::Hash;      end
class Array;               include Gibbler::Array;     end
class Time;                include Gibbler::Time;      end
class DateTime < Date;     include Gibbler::DateTime;  end
class Range;               include Gibbler::Range;     end
class File;                include Gibbler::File;      end
class TempFile;            include Gibbler::File;      end
class MatchData;           include Gibbler::String;    end
class OpenStruct;          include Gibbler::Object;    end

# URI::Generic must be included towards the 
# end b/c it runs Object#freeze statically.
module URI; class Generic; include Gibbler::String;    end; end

# Bundler calls freeze on an instance of Gem::Platform
module Gem; class Platform; include Gibbler::Complex;  end; end

module Addressable; class URI; include Gibbler::String; end; end

