module CatalogHelper

  def cat_image_with_popup(image_file, image_id)
    result = ""
    if image_exists?("vegi/#{image_file}.jpg")
      result += image_tag "vegi/#{image_file}.jpg", :onclick => "Effect.Appear('#{image_id}', {duration: 0.3});"
      result += "<div style='position:relative;'>"
      result += "  <div id='#{image_id}' class='img_popup' style='display:none;'>"
      result += image_tag("vegi-large/#{image_file}.jpg")
      result += "  </div>"
      result += "</div>" 
    else
      image_tag("no-image.png")
    end
  end
  
  def image_exists?(source)
    File.exist?("#{RAILS_ROOT}/public/images/#{source}")
  end

  
end

