class RenderTable::Cell
  attr_accessor :header, :cell_index, :html

  def self.cells_for_row(row, table)
    table.header.collect.with_index do |header_cell, cell_index|
      RenderTable::Cell.new(header_cell, row, cell_index, table)
    end
  end

  def initialize(header, row, cell_index, table)
    @header = header
    @row = row
    @cell_index = cell_index
    @table = table
    @html = @table.html[:cells]
  end

  def value
    record = @row.record
    overriden_header = @table.override[header]
    return overriden_header.call(record, @cell_index) if overriden_header
    return record.send(header) if @row.record.respond_to? header
    RenderTable.configuration.cell_value
  end

  def class
    RenderTable::Html.html_string(@html[:classes], value, @cell_index)
  end

  def id
    RenderTable::Html.html_string(@html[:ids], value, @cell_index)
  end
end
