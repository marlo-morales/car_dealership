module DateHelper
  def year_select(options: {}, html_options: {})
    today = Date.today.year
    options.reverse_merge!(start_year: (today - 15), end_year: today)
    html_options.reverse_merge!(class: "form__control", required: true)
    options[:value] = options[:value].to_i if options[:value]

    select_year options[:value], options, html_options
  end
end
