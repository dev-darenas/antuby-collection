module ApplicationHelper
  include Pagy::Frontend

  def presenter(model, presenter_class=nil)
    klass = presenter_class || "#{model.class.name.demodulize}Presenter".constantize
    presenter = klass.new(model, self)
    return yield(presenter) if block_given?
    presenter
  end

  FLASH_KEYS = {
    notice: 'info',
    success: 'success',
    error: 'error',
    alert: 'warning'
  }.freeze

  def flash_class(key)
    FLASH_KEYS[key.to_sym]
  end
end
