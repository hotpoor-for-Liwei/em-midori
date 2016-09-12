##
# This class provides methods to be inherited as route definition.
class Midori::API
  # Add GET method as a DSL for route definition
  # === Attributes
  # * +path+ [+String+, +Regex+] Accepts as part of path in route definition.
  # === Returns
  # nil
  # === Examples
  # String as router
  #   get '/' do
  #      puts 'Hello World'
  #   end
  #
  # Regex as router
  #   get /\/hello\/(.*?)/ do
  #      puts 'Hello World'
  #   end
  def get(path, &block) end

  # Add POST method as a DSL for route definition
  # === Attributes
  # * +path+ [+String+, +Regex+] Accepts as part of path in route definition.
  # === Returns
  # nil
  # === Examples
  # String as router
  #   post '/' do
  #      puts 'Hello World'
  #   end
  #
  # Regex as router
  #   post /\/hello\/(.*?)/ do
  #      puts 'Hello World'
  #   end
  def post(path, &block) end

  # Add PUT method as a DSL for route definition
  # === Attributes
  # * +path+ [+String+, +Regex+] Accepts as part of path in route definition.
  # === Returns
  # nil
  # === Examples
  # String as router
  #   put '/' do
  #      puts 'Hello World'
  #   end
  #
  # Regex as router
  #   put /\/hello\/(.*?)/ do
  #      puts 'Hello World'
  #   end
  def put(path, &block) end

  # Add DELETE method as a DSL for route definition
  # === Attributes
  # * +path+ [+String+, +Regex+] Accepts as part of path in route definition.
  # === Returns
  # nil
  # === Examples
  # String as router
  #   delete '/' do
  #      puts 'Hello World'
  #   end
  #
  # Regex as router
  #   delete /\/hello\/(.*?)/ do
  #      puts 'Hello World'
  #   end
  def delete(path, &block) end

  # Add OPTIONS method as a DSL for route definition
  # === Attributes
  # * +path+ [+String+, +Regex+] Accepts as part of path in route definition.
  # === Returns
  # nil
  # === Examples
  # String as router
  #   options '/' do
  #      puts 'Hello World'
  #   end
  #
  # Regex as router
  #   options /\/hello\/(.*?)/ do
  #      puts 'Hello World'
  #   end
  def options(path, &block) end

  # Add LINK method as a DSL for route definition
  # === Attributes
  # * +path+ [+String+, +Regex+] Accepts as part of path in route definition.
  # === Returns
  # nil
  # === Examples
  # String as router
  #   link '/' do
  #      puts 'Hello World'
  #   end
  #
  # Regex as router
  #   link /\/hello\/(.*?)/ do
  #      puts 'Hello World'
  #   end
  def link(path, &block) end

  # Add UNLINK method as a DSL for route definition
  # === Attributes
  # * +path+ [+String+, +Regex+] Accepts as part of path in route definition.
  # === Returns
  # nil
  # === Examples
  # String as router
  #   unlink '/' do
  #      puts 'Hello World'
  #   end
  #
  # Regex as router
  #   unlink /\/hello\/(.*?)/ do
  #      puts 'Hello World'
  #   end
  def unlink(path, &unlink) end

  METHODS = %w'get post put delete options link unlink' # :nodoc:

  # Magics to fill DSL methods through dynamically eval
  METHODS.each do |method|
    eval <<-end_eval
     def self.#{method}(path, &block)
        self.add_route('#{method.upcase}', path, block)
      end
     end_eval
  end

  private
  def self.add_route(method, route, block)
    @route = Array.new if @route.nil?
    @route << Midori::Route.new(method, route, block)
  end

  # def self.match(method, route)
  #
  # end
end

class Midori::Route
  attr_accessor :method, :route, :function

  def initialize(method, route, function)
    @method = method
    @route = route
    @function = function
  end
end