module ApplicationHelper
  def page_title(prefix = nil)
    key = "#{controller_path.tr("/", ".")}.#{action_name}.page_title"
    title = t(
      key,
      prefix: prefix,
      site_name: t("site.name"),
      default: t("site.name")
    )

    content_for(:page_title, title)
  end
end
