module ErrorsHelper
  def format_flash_errors(errors)
    return if errors.blank?

    if errors.is_a?(Array)
      "<br/> * #{errors.join("<br/> * ")}"
    else
      "<br/> * #{errors}"
    end
  end

  def field_with_errors(errors, field_name)
    return unless errors.is_a?(ActiveModel::Errors) &&
                  errors[field_name].present?

    :field_with_errors
  end
end
