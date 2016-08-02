class LessonVersion < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :media, class_name: "MediaContent", foreign_key: "media_id", :dependent => :destroy
  has_many :topic_items, as: :topicable
  has_many :topics, -> { distinct }, through: :topic_items
  has_many :contributions, as: :contribution
  has_many :user_contributors, through: :contributions, source: :contributor, :source_type => 'User'
  validates_presence_of :name, :media
  accepts_nested_attributes_for :media, allow_destroy: true
  accepts_nested_attributes_for :topic_items, :reject_if => :all_blank, :allow_destroy => true

  def contributors
    return self.user_contributors
  end
end
