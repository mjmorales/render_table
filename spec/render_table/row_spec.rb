RSpec.describe RenderTable::Row do
    let(:records) { [1, '1', 1.0] }
    let(:header) { [:class, :to_s, :to_i, :to_f] }
    let(:table) { RenderTable::Table.new(records: records, header: header) }
    before(:each) do
      table.html[:rows][:classes] = {
        'is-integer' => ->(record, _row_index) { record.is_a? Integer },
        'is-first' => ->(_record, row_index) { row_index.zero? },
        'is-last' => ->(_record, row_index) { row_index == 2 }
      }

      table.html[:rows][:ids] = {
        'first' => ->(_record, row_index) { row_index.zero? },
        'last' => ->(_record, row_index) { row_index == 2 }
      }
    end

    subject { RenderTable::Row.new(records[0], 0, table) }

  describe '.class' do
    it 'returns "is-integer is-first" for first row' do
      expect(subject.class).to eq 'is-integer is-first'
    end
  end

  describe '.id' do
    it 'returns "first" for first row' do
      expect(subject.id).to eq 'first'
    end
  end

  describe '.cells' do
    before(:each) { @cells = subject.cells }

    it 'returns cells for each header' do
      expect(@cells.count).to eq header.count
    end

    it 'returns a collection of RenderTable::Cell objects' do
      expect(@cells).to all( be_an(RenderTable::Cell) )
    end
  end
end
