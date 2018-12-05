class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  include Concerns::Followable
  include Concerns::Votable

  belongs_to :user
  belongs_to :topic, counter_cache: true
  has_many :answers

  field :text, type: String
  field :anonymous, type: Boolean, default: false

  validates :user_id, presence: true
  validates :text, presence: true

  def author_name
    self.anonymous ? 'random passer' : self.user.name
  end

  def author_avatar
    self.anonymous ? 'https://robohash.org/random.png?size=300x300&set=set2' : self.user.avatar_url
  end


end
