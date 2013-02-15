# TODO: Merge with Content class

class Game < ActiveRecord::Base
  translates :title, :body, :meta_description, :meta_title, :slug, :feature_title, :properties 
  include Extensions::Models::BelongsToSection
  include Extensions::Models::BelongsToAccount
  include Extensions::Models::Sluggable
  include Extensions::Models::Publishable
  include Extensions::Models::Categorizable
  include Extensions::Models::HasManyImageAssignments
  
      
  
  class Translation
    attr_accessible :locale
  end
  
  attr_accessible :title, :body, :preview, :properties,  :feature_title, :properties

  acts_as_list :scope => [:section_id]
  default_scope :order => 'games.position'

  image_accessor :preview

  class << self
    def preview_size
      '410x410#'
    end 
    
    def in_homepage
      where("games.show_in_homepage = ?", 1)
    end

    def self.previous(record, field = "published_at")
      with_section(record.section_id).published.with_translations(I18n.locale).order("#{table_name}.#{field} ASC").where("#{table_name}.#{field} < ?", record.send(field)).last
    end

    def self.next(record, field = "published_at")
      with_section(record.section_id).published.with_translations(I18n.locale).order("#{table_name}.#{field} ASC").where("#{table_name}.#{field} > ?", record.send(field)).first
    end

  end

  validates :title, :presence => true, :uniqueness => {:scope => :section_id, :case_sensitive => false}

  def next(field = "published_at")
    self.class.next(self)
  end

  def previous(field = "published_at")
    self.class.previous(self)
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
