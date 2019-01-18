class RenderTable::Configuration
  attr_accessor :table_id, :table_class, :html, :cell_value

  def initialize
    @table_id = 'default-table-id'
    @table_class = 'default-table-class'
    @html = RenderTable::Configuration.default_html
    @cell_value = RenderTable::Configuration.default_cell_value
  end

  def self.default_html
    {
      rows: {
        classes: {},
        ids: {}
      },
      cells: {
        classes: {},
        ids: {}
      }
    }
  end

  def self.default_cell_value
    '---'
  end
end
