module ApplicationHelper
  def presenter(model, presenter_class=nil)
    klass = presenter_class || "#{model.class.name.demodulize}Presenter".constantize
    presenter = klass.new(model, self)
    return yield(presenter) if block_given?
    presenter
  end
end
