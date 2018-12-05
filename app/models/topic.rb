class Topic
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  has_many :questions

  field :title, type: String

  validates :title, presence: true
end
