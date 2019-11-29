class BasePresenter < SimpleDelegator
  def initialize(model, view)
    @model, @view = model, view
    super(@model)
  end

  def columns
    raise StandardError.new 'Method not implemented'
  end

  def edit_link(*args)
    @view.edit_polymorphic_path(@model)
  end

  def new_link(*args)
    @view.new_polymorphic_path(@model)
  end
end
