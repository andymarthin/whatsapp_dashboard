class ImageInput < SimpleForm::Inputs::CollectionInput
  def input(wrapper_options)
    input_html_options[:class] = "hidden"
    input_html_options[:data] = { action: "change->upload-image#preview", upload_image_target: "input" }
    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)
    template.content_tag(:div, class: "px-4 py-4", data: { controller: "upload-image" }) do
      output = ActiveSupport::SafeBuffer.new
      output << @builder.file_field(attribute_name, merged_input_options)
      output << preview_image
    end
  end

  private

  def label_preview
    @builder.label(attribute_name) do
      output = ActiveSupport::SafeBuffer.new
      output << icon
      output << template.content_tag(:h2, "Upload picture", class: "mb-2 text-xl font-bold tracking-tight text-gray-700")
      output << template.content_tag(:p, class: "font-normal text-sm text-gray-400 md:px-6") do
        "Choose photo size should be less than #{template.content_tag(:b, "2mb", class: "text-gray-600")}".html_safe
      end
      output << template.content_tag(:p, class: "font-normal text-sm text-gray-400 md:px-6") do
        "and should be in   #{template.content_tag(:b, "JPG, PNG, or GIF", class: "text-gray-600")} format.".html_safe
      end
      output << template.content_tag(:span, "", class: "text-gray-500 bg-gray-200 z-50")
      output
    end
  end

  def preview_class
    have_image? ? "max-w-sm p-6 bg-gray-100 rounded-lg items-center mx-auto text-center cursor-pointer" : "max-w-sm p-6 bg-gray-100 border-dashed border-2 border-gray-400 rounded-lg items-center mx-auto text-center cursor-pointer"
  end

  def have_image?
    object.send(attribute_name).present?
  end

  def preview_image
    template.content_tag(:div, class: preview_class, data: { upload_image_target: "preview" }) do
      if have_image?
        template.image_tag(object.send("#{attribute_name}_url"), class: "max-h-48 rounded-lg mx-auto", data: { action: "click->upload-image#chooseFile" })
      else
        label_preview
      end
    end
  end

  def icon
    template.content_tag(:svg, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24", "stroke-width": "1.5", stroke: "currentColor", class: "w-8 h-8 text-gray-700 mx-auto mb-4") do
      template.content_tag(:path, "", "stroke-linecap": "round", "stroke-linejoin": "round", d: "M3 16.5v2.25A2.25 2.25 0 005.25 21h13.5A2.25 2.25 0 0021 18.75V16.5m-13.5-9L12 3m0 0l4.5 4.5M12 3v13.5")
    end
  end
end
