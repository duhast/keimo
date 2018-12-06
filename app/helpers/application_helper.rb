module ApplicationHelper
  BOOTSTRAP_FLASH = {
    alert: 'danger',
    notice: 'success',
    # notice: 'warning',
    # notice: 'info',
    # notice: 'light',
    # notice: 'dark'
  }

  def flashes
    flash.map do |type, message|
      content_tag(:div, message, class: "alert alert-#{BOOTSTRAP_FLASH[type.to_sym]}", role: 'alert')
    end.join.html_safe
  end

end
