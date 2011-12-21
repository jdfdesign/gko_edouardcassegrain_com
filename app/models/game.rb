class Game < ActiveRecord::Base
  publishable
  translates :title, :body, :properties, :meta_title, :meta_description, :meta_keywords, :slug, :feature_title
  acts_as_list :scope => [:section_id]
  belongs_to :site
  belongs_to :section
  image_accessor :preview
  # What is the max image size a user can upload
  MAX_SIZE_IN_MB = 1
  # What is the max image format a user can upload
  FILE_TYPES = %w(image/jpg image/jpeg image/png image/gif)

  has_many  :image_assignments, 
            :as => :attachable, 
            :dependent => :destroy, 
            :order => :position
  has_many  :images, 
            :through => :image_assignments,
            :order => "image_assignments.position"

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


  # Used for hint in admin space
  def path
    section.path ? (section.path + "/" + permalink) : ""
  end
  
  def permalink
    slug
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
end
