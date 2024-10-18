class ImageInput < SimpleForm::Inputs::CollectionInput
  def input(wrapper_options)
    input_html_options[:data] = { target: "input", action: "change->upload-image#upload" }
    template.content_tag(:div, class: "flex justify-center mt-8", data: { controller: "upload-image" }) do
      template.content_tag(:div, class: "rounded-lg shadow-xl bg-gray-50") do
        template.content_tag(:div, class: "m-4") do
          output = ActiveSupport::SafeBuffer.new
          output << preview_image
          output << template.content_tag(:div, class: "mt-2 ", data: { upload_image_target: "preview" }) do
            if object.send(attribute_name).present?
              # append preview image to output
              template.image_tag(object.send("#{attribute_name}_url"), class: "max-h-44")
            end
          end
          output << template.content_tag(:div, class: "mt-2") do
            @builder.file_field(attribute_name, input_html_options)
          end
          output
        end
      end
    end
  end

  private

  def label_preview
    template.content_tag(:label, "Upload
      Image(jpg,png,jpeg)", class: "inline-block mb-2 text-gray-500")
  end

  def have_image_class
    object.send(attribute_name) ? "hidden" : ""
  end

  def preview_image
    template.content_tag(:div, class: have_image_class, data: { upload_image_target: "placeholder" }) do
      preview_output = ActiveSupport::SafeBuffer.new
      preview_output << label_preview
      preview_output << template.content_tag(:div, class: "flex items-center justify-center w-full") do
        template.content_tag(:label, class: "flex flex-col w-full h-32 hover:bg-gray-100 hover:border-gray-300") do
          template.content_tag(:div, class: "flex flex-col items-center justify-center pt-7") do
            output = ActiveSupport::SafeBuffer.new
            output << icon
          end
        end
      end
    end
  end

  def icon
    template.content_tag(:svg, aria: { hidden: true }, xmlns: "http://www.w3.org/2000/svg", fill: "currentColor", viewBox: "0 0 20 18", class: "w-12 h-12 text-gray-400 group-hover:text-gray-600") do
      template.content_tag(:path, "", d: "M18 0H2a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h16a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2Zm-5.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3Zm4.376 10.481A1 1 0 0 1 16 15H4a1 1 0 0 1-.895-1.447l3.5-7A1 1 0 0 1 7.468 6a.965.965 0 0 1 .9.5l2.775 4.757 1.546-1.887a1 1 0 0 1 1.618.1l2.541 4a1 1 0 0 1 .028 1.011Z")
    end
  end
end
