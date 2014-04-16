class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :favorites, as: :favoritable, dependent: :destroy
  has_many :kudos, as: :kudosible, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :actions, as: :actionable, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  after_create :create_action
  acts_as_taggable
  is_impressionable
  # default_scope -> { order('created_at DESC') }

  scope :unanswered,
    select("questions.id, title, slug")
    joins(:answers).
    where("answer.id IS NULL")
    order("question.created_at DESC")

  scope :most_answered,
    select("questions.id, title, slug, count(answers.id) AS answers_count").
    joins(:answers).
    group("questions.id").
    order("answers_count DESC")


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

  def create_action
    Action.create(
      actionable: self,
      content: self.title,
      user: User.find(self.user_id)
    )
  end
end