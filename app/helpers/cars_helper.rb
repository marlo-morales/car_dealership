module CarsHelper
  def condition_select(form, options: {}, html_options: {})
    html_options.reverse_merge!(class: "form__control", required: true)

    value = form.object&.condition && Car.conditions[form.object.condition]
    form.select :condition, options_for_conditions(value), options, html_options
  end

  def options_for_conditions(value)
    options_for_select(Car.conditions.map { |key, val| [key.titleize, val] }, value)
  end

  def options_for_makes(selected)
    options_for_select(CAR_MAKES, selected)
  end

  def filters_make_select(selected: nil)
    select_tag(:make, options_for_makes(selected), include_blank: t("cars.filter.make"), id: :filter_by_make)
  end

  def filters_year_select(selected: nil)
    year_select(options: { value: selected, prompt: t("cars.filter.year") }, html_options: { id: :filter_by_year, name: :year, class: '', required: false })
  end
end
