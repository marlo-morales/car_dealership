module CarsHelper
  def condition_select(form, options: {}, html_options: {})
    html_options.reverse_merge!(class: "form__control", required: true)
    
    value = form.object&.condition && Car.conditions[form.object.condition]
    form.select :condition, options_for_conditions(value), options, html_options
  end

  def options_for_conditions(value)
    options_for_select(Car.conditions.map { |key, val| [key.titleize, val] }, value)
  end
end
