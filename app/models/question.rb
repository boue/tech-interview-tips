class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :favorites, as: :favoritable
  has_many :kudos, as: :kudosible
  has_many :comments, as: :commentable, dependent: :destroy

  belongs_to :user

  acts_as_taggable

  validates :title, presence: true


  default_scope -> { order('created_at DESC') }

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  validates_presence_of :title, :slug

  def should_generate_new_friendly_id?
    title_changed?
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['title ilike ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end