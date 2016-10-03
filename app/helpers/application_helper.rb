module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  def number_to_euro(number)
    number_to_currency(number, unit: '€')
  end
end
