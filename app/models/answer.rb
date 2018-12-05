class Answer
  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::Votable

  belongs_to :user
  belongs_to :question, counter_cache: true

  field :text, type: String

  validates :user_id, presence: true
  validates :text, presence: true


end
