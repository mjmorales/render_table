require 'erb'
require 'ostruct'

class RenderTable::Base
  include ERB::Util

  attr_accessor :records, :header, :html, :override, :table_id, :table_class

  def self.render
    table = new
    yield table
    table.render
  end

  def initialize(args = {})
    @records     = args[:records]
    @header      = args[:header]      || []
    @override    = args[:override]    || {}
    @table_id    = args[:table_id]    || RenderTable.configuration.table_id
    @table_class = args[:table_class] || RenderTable.configuration.table_class
    @html        = args[:html]        || RenderTable.configuration.html
  end

  def rows
    # TODO: Add implementation for rendering rows and cells
    row = OpenStruct.new
    cell = OpenStruct.new
    cell.value = 'Hello World'
    row.cells = [cell]
    [row]
  end

  def render
    ERB.new(template, 0, '%<>').result(binding)
  end

  private

  def table
    self
  end

  def template
    <<-ERB
      <% table.rows.each do |row| %>
      <% row.cells.each do |cell| %>
      <%= cell.value %>
      <% end %>
      <% end %>
    ERB
  end
end
