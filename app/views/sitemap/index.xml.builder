@base_url = "#{request.protocol}#{request.host_with_port}" 

xml.instruct!

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  
  site_locales.each do |locale|
    @site.sections.published.with_translations(locale).nested_set.each do |section|  
      if !section.redirect_url.present?
        # Add XML entry only if there is a valid page_url found above.
        xml.url do
          path = url_for([section])
          path = "" if path == "/"
          if default_locale?(locale)
            xml.loc "#{@base_url}#{path}"
          else
            xml.loc "#{@base_url}/#{locale.to_s}#{path}"
          end
          xml.lastmod section.updated_at.to_date
          xml.priority section.home? ? 1 : 0.9
        end 
        
        if section.is_a?(GameList)
          if(@games = section.games.published.with_translations(locale))
             @games.each do |game|
               if default_locale?(locale)
                 xml.loc "#{@base_url}#{url_for([game.section, game])}"
               else
                 xml.loc "#{@base_url}/#{locale.to_s}#{url_for([game.section, game])}"
               end
               xml.lastmod game.updated_at.to_date
               xml.priority 1
             end
          end
        end 

      end
    end
  end
end
