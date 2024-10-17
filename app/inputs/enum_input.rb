class EnumInput < SimpleForm::Inputs::CollectionInput
  def input(wrapper_options)
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    collection = object.class.send(attribute_name.to_s.pluralize)&.keys

    label_method = :titleize
    value_method = :to_s

    @builder.collection_select(
      attribute_name, collection, value_method, label_method,
      input_options, merged_input_options
    )
  end

  def input_options
    options = super
    options[:include_blank] = if options.key?(:prompt)
      options[:prompt]
    else
      "Select #{attribute_name.to_s.titleize}"
    end
    options
  end
end
