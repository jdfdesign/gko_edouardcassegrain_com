# TODO: Merge with Content class

class Game < ActiveRecord::Base
  publishable
  has_images
  translates :title, :body, :properties, :meta_title, :meta_description, :meta_keywords, :slug, :feature_title
  categorizable
  acts_as_list :scope => [:section_id]
  default_scope :order => 'games.position'
  belongs_to :site
  belongs_to :section
  image_accessor :preview
  attr_accessible :type, :body, :category_ids, :account_id, :meta_description, :author_id, :title, :slug, :meta_title, :section_id, :meta_keywords, :feature_title, :properties 
  class << self
    def preview_size
      '410x410#'
    end 
    
    def in_homepage
      where("games.show_in_homepage = ?", 1)
    end
    
    def with_globalize_like(column, query)
      joins(:translations).with_locales(I18n.locale).where("#{self.translation_class.table_name}.#{column.to_s} LIKE ?", "%#{query}%")
    end

    def with_title(q)
      with_globalize_like(:title, q)
    end

    def by_permalink(slug)
      joins(:translations).where("#{self.translation_class.table_name}.slug = ?", slug)
    end

    def in_site(site_id)
      where("games.site_id = ?", site_id)
    end
    
    def with_section(section_id)
      where("games.section_id = ?", section_id)
    end

    def previous(record, field = "published_at")
      with_section(record.section_id).order("#{field} DESC").where("#{field} < ?", record.send(field)).first
    end

    def next(record, field = "published_at")
      with_section(record.section_id).order("#{field} ASC").where("#{field} > ?", record.send(field)).first 
    end

  end

  validates :title, :presence => true
  validates :section_id, :site_id, :presence => true

  before_validation do |r|
    r.site_id = r.section.site_id if r.section.present?
    r.slug = r.title if r.slug.blank? && r.title.present?
    r.slug = r.slug.parameterize if slug_changed? && r.slug.present?
  end

  def next(field = "published_at")
    self.class.base_class.next(self, field)
  end

  def previous(field = "published_at")
    self.class.base_class.previous(self, field)
  end

  def permalink(locale=nil)
    locale ||= ::Globalize.locale
    read_attribute(:slug, :locale => locale)
  end
  
  # Used for hint in admin space and cache
  # Warn : Permalink can be blank if it is not published
  def public_url(locale=nil)
    locale ||= ::Globalize.locale
    p = self.permalink(locale)
    return nil unless p.present?
    u = [self.section.path(locale), p]
    if(locale != ::I18n.default_locale.to_sym)
      u.unshift(locale.to_s)
    end
    u = u.join('/')
    u = '/' + u
    u
  end
  
  # Get public urls for all locales
  def public_urls
    urls = []
    self.used_locales.each do |l|
      urls << self.public_url(l)
    end
    urls.flatten.compact.uniq
  end
  
  def to_param(title=nil)
    title == :permalink ? permalink : super()
  end

  def labelize
    translated_locales.include?(Globalize.locale) ? self.title : "<span class='warning'>!</span>(#{read_attribute(:title, :locale => I18n.default_locale)})".html_safe
  end
  
  def thumbnail(geometry = nil)
    geometry ||= self.class.preview_size
    if preview.present?
      preview.thumb(geometry)
    else
      preview = image_assignments.where("image_assignments.position = ?", 1).first.try(:image)
      preview.image.thumb(geometry) if preview
    end
  end
  
  # TODO: Merge with Content class
  # Indicate if this page should be included in robot.txt
  # use trackable? rather than checking the attribute directly. this
  # allows sub-classes to override trackable? if they want to provide
  # their own definition.
  def trackable?
    published?
  end
end
