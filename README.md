# RenderTable

RenderTable is a set of extensible table building modules that make displaying tabular data easy.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'render_table'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install render_table

## Usage
### Rendering a table
Invoke the .render method on the table class with the template you want to render.

Within an ERB template:
```ruby
<%= RenderTable::Table.render(records: User.all, header: [:id, :email, :name, :created_at]) %>
```
Records can be any collection that responds to .each

You can also pass .render a block:
```ruby
<%= RenderTable::Table.render do |table| %>
    <% table.records = User.all
    <% table.header = [:id, :email, :name, :created_at] %>
<% end %>
```

### Table ID and Classes
To add an id or class to the rendered table
```ruby
table.table_id = 'my-table-id'
table.table_class = 'my-table-class'
```
```html
<table id="my-table-id" class="my-table-class">
```
You can also set global defaults for thse values within an initializer.
```ruby
RenderTable.configure do |config|
  config.table_id = 'table-id'
  config.table_class = 'table-class'
end
```
### Overrides 
To override the value of a cell regardless of its header pass a hash of procedures mapped to the overriden header.
```ruby
<%= RenderTable::Table.render do |table| %>
    <% table.records = User.all
    <% table.header = [:id, :not_a_real_method] %>
    <% table.override = {
        not_a_real_method: ->(_cell, _cell_index) { 'hello world' }
    } %>
<% end %>
```
```html
<table>
    <thead>
        <tr>
            <th>id</th>
            <th>not_a_real_method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>hello world</td>
        </tr>
</table>
```
Overrides can be any object that responds to .call(record, index)
```ruby
class User::NameOverride
    def self.call(record, index)
        record.name.upcase
    end
end

RenderTable::Table.render do |table|
    table.records = User.all
    table.header = [:id, :name]
    table.override = { name: User::NameOverride }
end
```

### Row and Cell CSS
To add dynamically created class and ids to row and cell elements pass a hash of procedures mapped to the desired class/id names.
#### Rows
```ruby
table.html[:rows][:classes] = {
    'is-user' => ->(record, _row_index) { record.is_a? User },
    'is-first' => ->(_record, row_index) { row_index.zero? }
}

table.html[:rows][:ids] = {
    'first' => ->(_record, row_index) { row_index.zero? },
    'last' => ->(record, _index) { record == records.last }
}
```
```html
<tbody>
    <tr id="first" class="is-first is-user">...</tr>
    <tr class="is-user">...</tr>
    <tr id="last" class="is-user">...</tr>
</tbody>
```
#### Cells
```ruby
table.html[:cells][:classes] = {
    'is-integer' => ->(cell_value, _cell_index) { cell_value == Integer },
    'is-first' => ->(_cell_value, cell_index) { cell_index.zero? },
}

table.html[:cells][:ids] = {
    'first' => ->(_record, cell_index) { cell_index.zero? }
}
```

```html
<tr>
    <td id="first" class="is-integer is-first">1</td>
    <td>john.doe@example.com</td>
</tr>
```
### Options Column
To add control elements to a row you can pass an inline template or file path to the 'options' attribute.
#### Inline Template
```ruby
RenderTable::Table.render do |table|
    table.records = User.all
    table.header = [:id, :name]
    table.options = "<%= link_to 'Edit', edit_user_path(record) %>"
end
```
```html
<table>
    <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>John Doe</td>
            <td><a href="users/1/edit/">Edit</a></td>
        </tr>
    </tbody>
</table>
```
You may also path a file path where a template can be rendered
```ruby
...

table.options = File.join(__dir__, './options.html.erb')
```

### Custom table templates
To add a custom table render class, create a new class that inherits from RenderTable::Base and provide a new implementation for .template

Example Div Table template.
```ruby
class RenderTable::DivTable < RenderTable::Base
  def template
    <<-HTML
      <div id="<%= table.table_id %>" class="div-table <%= table.table_class %>">
        <div class="div-table-thead">
          <div class="div-table-tr">
            <% table.header.each do |header| %>
              <div class="div-table-td"><%= header.to_s %></div>
            <% end %>
            <% if table.options %>
              <div class="div-table-td"></div>
            <% end %>
          </div>
        </div>
        <div class="div-table-tbody">
        <% table.rows.each do |row| %>
          <div id="<%= row.id %>" class="div-table-tr <%= row.class %>">
            <% row.cells.each do |cell| %>
              <div id="<%= cell.id %>" class="div-table-td <%= cell.class %>">
                <%= cell.value %>
              </div>
            <% end %>
            <% if table.options %>
              <div class="div-table-td"><%= options_cell(row.record, row.row_index) %></div>
            <% end %>
          </div>
        <% end %>
        </div>
      </div>
    HTML
  end
end
```

Then call .render on the newly created class.

```ruby
RenderTable::DivTable.render do |table|
    table.records = User.all
    table.header = [:id, :name]
end
```

# Changing defaults
To modify the default values on rendered tables call the .configuration method from a required initializer.
```ruby
# config/render_table_config.rb
  RenderTable.configure do |config|
    config.table_id = 'test-table-id'
    config.table_class = 'test-table-class'
    config.cell_value = '---'
    config.html = {
        rows: {
          classes: {},
          ids: {}
        },
        cells: {
          classes: {},
          ids: {}
        }
      }
  end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjmorales/render_table. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RenderTable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mjmorales/render_table/blob/master/CODE_OF_CONDUCT.md).
