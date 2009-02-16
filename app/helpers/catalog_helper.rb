module CatalogHelper
  def image_tag_with_check(source, options = {})
    if image_exists?(source)
      image_tag(source, options)
    else
      image_tag("no-image.png")
    end
  end
  
  def image_exists?(source)
    File.exist?("#{RAILS_ROOT}/public/images/#{source}")
  end
end
