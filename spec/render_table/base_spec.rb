RSpec.describe RenderTable::Base do
  let(:records) { [1, '1', 1.0] }
  let(:header) { %i[class] }
  subject { RenderTable::Base.new(records: records, header: header) }

  describe '.render' do
    it 'returns an ERB result with instance context' do
      result = subject.render
      expect(result).to include 'Integer', 'String', 'Float'
    end
  end

  describe 'self.render' do
    it 'allows for class inflection with block provided' do
      result = RenderTable::Base.render do |t|
        t.records = records
        t.header = header
      end

      expect(result).to include 'Integer', 'String', 'Float'
    end
  end
end
