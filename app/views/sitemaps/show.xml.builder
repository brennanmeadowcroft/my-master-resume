xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'

xml.urlset "xmlns" => "http://www.google.com/schemas/sitemap/0.9" do
  xml.url do
    xml.loc "http://#{request.host}/"
    xml.lastmod Time.now.to_s(:w3c)
    xml.changefreq "always"
  end
 
  @pages.each do |page|
    xml.url do
      xml.loc "http://#{request.host}#{page[:url]}"
      xml.lastmod Time.now.to_s(:w3c)
      xml.changefreq "daily"
      xml.priority 0.9
    end
  end
end