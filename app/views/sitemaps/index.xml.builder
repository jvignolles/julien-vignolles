cache 'sitemap', expires_in: 1.day do
  xml.instruct! :xml, version: '1.0'
  xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
    @static_pages.each do |page|
      xml.url do
        xml.loc        page[:url]
        xml.priority   page[:priority]
        xml.changefreq page[:frequency]
      end
    end
    @projects.each do |project|
      xml.url do
        xml.loc        front_project_url(project)
        xml.priority   0.5
        xml.changefreq 'weekly'
        xml.lastmod    project.updated_at.strftime("%F")
      end
    end
  end
end
