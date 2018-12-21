require 'render_table/version'
require 'render_table/configuration'
require 'render_table/html'
require 'render_table/base'
require 'render_table/row'
require 'render_table/cell'
require 'render_table/table'

module RenderTable
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= RenderTable::Configuration.new
    yield(configuration)
  end
end
