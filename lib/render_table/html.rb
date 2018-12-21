module RenderTable::Html
  def self.html_string(html_procedure_hash, record, index)
    accumulated_html_strings = []
    html_procedure_hash.each do |html_string, procedure|
      next unless procedure.call(record, index)
      accumulated_html_strings << html_string
    end

    accumulated_html_strings.join(' ')
  end
end
