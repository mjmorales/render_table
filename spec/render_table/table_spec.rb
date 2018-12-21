RSpec.describe RenderTable::Table do
  let(:records) { [1, '1', 1.0] }
  let(:header) { %i[class] }
  subject { RenderTable::Table.new(records: @records, header: header) }

  describe '.render' do
    it 'template assigns default id and class to table' do
      result = subject.render
      expect(result).to include '<table id="test-table-id" class="test-table-class">'
    end

    it 'template assigns id and class to table' do
      subject.table_id = 'my-table-id'
      subject.table_class = 'my-table-class'
      result = subject.render
      expect(result).to include '<table id="my-table-id" class="my-table-class">'
    end
  end
end
