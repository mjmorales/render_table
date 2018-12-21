RSpec.describe RenderTable::Table do
  let(:records) { [1, '1', 1.0] }
  let(:header) { %i[class] }
  subject { RenderTable::Table.new(records: records, header: header) }

  describe '.render' do
    it 'assigns default id and class to table' do
      result = subject.render
      expect(result).to include '<table id="test-table-id" class="test-table-class">'
    end

    it 'assigns id and class to table' do
      subject.table_id = 'my-table-id'
      subject.table_class = 'my-table-class'
      result = subject.render
      expect(result).to include '<table id="my-table-id" class="my-table-class">'
    end

    it 'creates an extra column not using options' do
      subject.options = File.join(__dir__, '../support/options.html.erb')
      result = subject.render
      expect(result).to include '<td><a href="0">File Template 1</a></td>',
                                '<td><a href="1">File Template 1</a></td>',
                                '<td><a href="2">File Template 1.0</a></td>'
    end
  end
end
