class RenderTable::Configuration
  attr_accessor :table_id, :table_class, :html

  def initialize
    @table_id = 'default-table-id'
    @table_class = 'default-table-class'
    @html = RenderTable::Configuration.default_html
  end

  def self.default_html
    {
      rows: {
        class: {},
        id: {}
      },
      cells: {
        class: {},
        id: {}
      }
    }
  end
end
