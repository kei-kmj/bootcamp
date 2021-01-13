# frozen_string_literal: true

class Report < ApplicationRecord
  include Commentable
  include Checkable
  include Footprintable
  include Searchable
  include Reactionable
  include Watchable
  include WithAvatar
  include Mentioner

  enum emotion: {
    sad: 0,
    soso: 1,
    happy: 2
  }

  has_many :learning_times, -> { order(:started_at) }, dependent: :destroy, inverse_of: :report
  validates_associated :learning_times
  accepts_nested_attributes_for :learning_times, reject_if: :all_blank, allow_destroy: true
  has_and_belongs_to_many :practices # rubocop:disable Rails/HasAndBelongsToMany
  belongs_to :user, touch: true
  alias sender user

  validates :title, presence: true, uniqueness: { scope: :user_id }, length: { maximum: 255 }
  validates :description, presence: true
  validates :user, presence: true
  validates :reported_on, presence: true, uniqueness: { scope: :user }
  validates :learning_times, length: { minimum: 1, message: ': 学習時間を入力してください。' }

  after_create ReportCallbacks.new
  after_update ReportCallbacks.new
  after_destroy ReportCallbacks.new

  columns_for_keyword_search :title, :description

  mentionable_as :description

  scope :default_order, -> { order(reported_on: :desc, created_at: :desc) }

  scope :unchecked, lambda {
    includes(:checks).where(checks: { id: nil })
  }

  scope :wip, -> { where(wip: true) }

  scope :not_wip, -> { where(wip: false) }

  scope :list, lambda {
    with_avatar
      .preload([:comments, { checks: { user: { avatar_attachment: :blob } } }])
      .default_order
  }

  def self.faces
    @faces ||= emotions.keys
                       .zip(%w[emotion/sad.svg emotion/soso.svg emotion/happy.svg])
                       .to_h
                       .with_indifferent_access
  end

  def previous
    Report.where(user: user)
          .where('reported_on < ?', reported_on)
          .order(created_at: :desc)
          .first
  end

  def next
    Report.where(user: user)
          .where('reported_on > ?', reported_on)
          .order(:reported_on)
          .first
  end

  def first?
    serial_number == 1
  end

  def serial_number
    Report.select(:id)
          .where(user: user)
          .order(:created_at)
          .index(self) + 1
  end
end
