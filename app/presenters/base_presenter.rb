class BasePresenter < SimpleDelegator
  DATE_FORMAT = "%d/%b/%Y %H:%M".freeze

  def initialize(model, view)
    @model, @view = model, view
    super(@model)
  end

  def columns
    raise StandardError.new 'Method not implemented'
  end

  def created
    @model.created_at.strftime(DATE_FORMAT)
  end

  def edit_link(*args)
    @view.edit_polymorphic_path(@model)
  end

  def new_link(*args)
    @view.new_polymorphic_path(@model)
  end

  def currency(value)
    @view.number_to_currency(value, separator: ".", delimiter: ".", precision: 0)
  end
end
