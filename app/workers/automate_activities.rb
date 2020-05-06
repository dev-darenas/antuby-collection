class AutomateActivities
  include Sidekiq::Worker

  def perform
    AutoTask.active.each do |auto_task|
      operation     = AutoTask.times[auto_task.time].to_sym
      date_activity =  Date.today.send(operation, auto_task.number_days)

      Invoices::Sale.active.where(payment_date: date_activity).each do |sale|
        unless sale.try(auto_task.type_task.pluralize)
                  .where(
                    type_activity: auto_task.type_activity.singularize,
                    status: [:pending, :cancel],
                    due_date: date_activity.beginning_of_day..date_activity.end_of_day
                  ).exists?

          invoice_sale = sale
                          .try(auto_task.type_task.pluralize)
                          .create(
                            due_date: date_activity,
                            status: :pending,
                            type_activity: auto_task.type_activity.singularize,
                            title: replace_data(auto_task.title, auto_task, sale),
                            description: replace_data(auto_task.description, auto_task, sale),
                            collection_advisor: sale.collector_advisor,
                            third_id: sale.third.id,
                            enterprise_id: sale.enterprise_id,
                            send_now: true
                          )
          
          p " Nueva tarea creada para la factura #{sale.code}"
        end
      end
    end
  end

  def  replace_data(string, auto_task, sale)
    string.gsub("\#{name_enterprise}", auto_task.enterprise.name)
    string.gsub("\#{code_bill}", sale.code)
    string.gsub("\#{total}", sale.total.to_s)
    string.gsub("\#{balance}", sale.balance.to_s)
    string.gsub("\#{payment_date}", sale.payment_date.to_s)
    string
  end
end
