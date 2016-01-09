class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  # fields
  field :content

  # validations
  validates_presence_of :content

  # scope
  default_scope -> { order(_id: :asc) }
end
