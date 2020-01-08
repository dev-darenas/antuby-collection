module ActivitiesHelper
  def display(object, type_activity)
    return '' if object.type_activity.nil? && type_activity == 'task'
    return object&.type_activity != type_activity ? 'none' : ''
  end
end
