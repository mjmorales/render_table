RSpec.describe RenderTable do
  it 'has a version number' do
    expect(RenderTable::VERSION).not_to be nil
  end

  describe '.configuration' do
    it 'returns configured table id' do
      expect(RenderTable.configuration.table_id).to eq 'test-table-id'
    end

    it 'returns configured table class' do
      expect(RenderTable.configuration.table_class).to eq 'test-table-class'
    end
  end
end
