require 'open-uri'

return if defined?(CAR_MAKES)

# Connecting to supercars.net
cars = Nokogiri::HTML(open("https://www.supercars.net/blog/all-brands/"))

# Collecting car makes per country...
CAR_MAKES = cars.css('.block-wrap-native .tipi-row-inner-style .tipi-row-inner-box .block-html-content ul li p').map do |make|
  make.content
end.uniq.sort
