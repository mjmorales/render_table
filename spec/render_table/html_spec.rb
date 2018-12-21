RSpec.describe RenderTable::Html do
  let(:html_classes_with_procedures) do
    {
      'is-integer' => ->(record, _index) { record.is_a? Integer },
      'is-string' => ->(record, _index) { record.is_a? String },
      'is-float' => ->(record, _index) { record.is_a? Float },
      'first-item-in-list' => ->(_record, index) { index.zero? }
    }
  end

  subject { RenderTable::Html }

  describe '.html_string' do
    it 'returns an html string for Integer record' do
      html_string = subject.html_string(html_classes_with_procedures, 1, 1)
      expect(html_string).to eq 'is-integer'
    end

    it 'returns an html string for Integer record with zero index' do
      html_string = subject.html_string(html_classes_with_procedures, 1, 0)
      expect(html_string).to eq 'is-integer first-item-in-list'
    end

    it 'returns an html string for String record' do
      html_string = subject.html_string(html_classes_with_procedures, '1', 1)
      expect(html_string).to eq 'is-string'
    end

    it 'returns an html string for Float record' do
      html_string = subject.html_string(html_classes_with_procedures, 1.0, 1)
      expect(html_string).to eq 'is-float'
    end
  end
end
