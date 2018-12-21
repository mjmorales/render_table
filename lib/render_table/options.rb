module RenderTable::Options
  def self.generate(table, template, record, index)
    template = File.read(template) if File.exist? template
    ERB.new(template, 0, '%<>').result(binding)
  end
end
