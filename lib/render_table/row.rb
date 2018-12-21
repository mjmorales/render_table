
class RenderTable::Row
  attr_accessor :record, :row_index, :html

  def self.rows_for_table(table)
    table.records.collect.with_index do |record, row_index|
      RenderTable::Row.new(record, row_index, table)
    end
  end

  def initialize(record, row_index, table)
    @record = record
    @row_index = row_index
    @table = table
    @html = @table.html[:rows]
  end

  def class
    RenderTable::Html.html_string(@html[:classes], @record, @row_index)
  end

  def id
    RenderTable::Html.html_string(@html[:ids], @record, @row_index)
  end

  def cells
    RenderTable::Cell.cells_for_row(self, @table)
  end
end
