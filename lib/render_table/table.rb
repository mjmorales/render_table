class RenderTable::Table < RenderTable::Base
  def template
    <<-HTML
      <table id="<%= table.table_id %>" class="<%= table.table_class %>">
        <thead>
          <tr>
            <% table.header.each do |header| %>
              <th><%= header.to_s %></th>
            <% end %>
            <% if table.options %>
              <th></th>
            <% end %>
          </tr>
        </thead>
        <tbody>
        <% table.rows.each do |row| %>
          <tr id="<%= row.id %>" class="<%= row.class %>">
            <% row.cells.each do |cell| %>
              <td id="<%= cell.id %>" class="<%= cell.class %>">
                <%= cell.value %>
              </td>
            <% end %>
            <% if table.options %>
              <td><%= options_cell(row.record, row.row_index) %></td>
            <% end %>
          </tr>
        <% end %>
        </tbody>
      </table>
    HTML
  end
end
