class Award
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user
  has_many :comments, as: :commentable
  has_and_belongs_to_many :promises
  belongs_to :election

  #fields
  field :title
  field :content
  field :prize
  field :address
  field :url

  # validations
  validates_presence_of :title, :content, :prize

  # scopes
  default_scope -> { order(_id: :desc) }

end
