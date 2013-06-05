class Event < ActiveRecord::Base
  STATES = %w(future current finished)

  validates :name, presence: true
  validates :conference, presence: true
  validates :date, presence: true
  validates :state, presence: true, inclusion: {in: STATES}

  attr_readonly :conference_id

  belongs_to :conference
  has_many :sessions, dependent: :destroy

  delegate :facebook_account, :twitter_account, :youtube_account, to: :conference

  def full_name
    "#{conference.name} #{name}"
  end
end
