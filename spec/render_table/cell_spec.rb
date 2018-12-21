RSpec.describe RenderTable::Cell do
  let(:records) { [1, '1', 1.0] }
  let(:table) { RenderTable::Table.new(records: records) }

  before(:each) do
    table.html[:cells][:classes] = {
      'is-integer' => ->(cell_value, _cell_index) { cell_value == Integer },
      'is-first' => ->(_cell_value, cell_index) { cell_index.zero? },
      'is-last' => ->(_cell_value, cell_index) { cell_index == 2 }
    }

    table.html[:cells][:ids] = {
      'first' => ->(_record, cell_index) { cell_index.zero? },
      'second' => ->(_record, cell_index) { cell_index == 1 },
      'last' => ->(_record, cell_index) { cell_index == 2 }
    }
  end

  let(:row) { RenderTable::Row.new(records[0], 0, table) }
  subject { RenderTable::Cell.new(:class, row, 0, table) }

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

  describe '.value' do
    it 'returns "Integer" for 1' do
      expect(subject.value).to eq Integer
    end

    it 'returns default value for undefined header methods' do
      subject.header = :not_a_real_method
      expect(subject.value).to eq RenderTable.configuration.cell_value
    end

    it 'returns an overridden value for header' do
      subject.header = :not_a_real_method
      table.header = [:not_a_real_method]
      table.override = {
        not_a_real_method: ->(_cell, _cell_index) { 'hello world' }
      }

      expect(subject.value).to eq 'hello world'
    end
  end
end
