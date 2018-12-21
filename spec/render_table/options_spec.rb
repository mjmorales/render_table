require 'tempfile'

RSpec.describe RenderTable::Options do
  subject { RenderTable::Options }
  let(:records) { [1, 2, 3] }
  let(:table) do
    RenderTable::Table.new(records: records)
  end

  context 'class methods' do
    describe '.generate' do
      it 'returns a rendered ERB string from inline paramater' do
        template = '<a href="<%= index %>">Inline Template <%= record %></a>'
        expect(subject.generate(table, template, records[0], 0))
          .to eq '<a href="0">Inline Template 1</a>'
      end

      it 'returns a rendered ERB string from file' do
        template_path = File.join(__dir__, '../support/options.html.erb')
        expect(subject.generate(table, template_path, records[0], 0))
          .to eq '<a href="0">File Template 1</a>'
      end
    end
  end
end
