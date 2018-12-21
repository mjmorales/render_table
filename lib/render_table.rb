require 'render_table/version'
require 'render_table/configuration'

module RenderTable
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= RenderTable::Configuration.new
    yield(configuration)
  end
end
