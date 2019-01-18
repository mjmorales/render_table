class RenderTable::Configuration
  attr_accessor :table_id, :table_class, :html, :cell_value

  def initialize
    @table_id = RenderTable::Configuration.default_table_id
    @table_class = RenderTable::Configuration.default_table_class
    @html = RenderTable::Configuration.default_html
    @cell_value = RenderTable::Configuration.default_cell_value
  end

  class << self
    def default_html
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

    def default_table_id
      ''
    end

    def default_table_class
      ''
    end

    def default_cell_value
      '---'
    end
  end
end
