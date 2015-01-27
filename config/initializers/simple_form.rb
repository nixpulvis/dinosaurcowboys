SimpleForm.setup do |config|
  config.wrappers :default,
                  class: :input,
                  hint_class: 'field-with-hint',
                  error_class: 'field-with-errors' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label_input
    b.use :error, wrap_with: { tag: :p, class: :error }
    b.use :hint,  wrap_with: { tag: :p, class: :hint }
  end

  config.default_wrapper = :default
  config.boolean_style = :nested
  config.button_class = 'button'
  config.error_notification_tag = :div
  config.error_notification_class = 'alert alert-error'
  config.label_class = 'control-label'
  config.browser_validations = false
end
