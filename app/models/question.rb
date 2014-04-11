class Question < ActiveRecord::Base
  has_many :answers
  has_many :favorites, as: :favoritable
  has_many :comments, as: :commentable

  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true

  default_scope -> { order('created_at DESC') }
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  validates_presence_of :title, :slug, :content

  def should_generate_new_friendly_id?
    headline_changed?
  end

end