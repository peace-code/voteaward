class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geocoder::Model::Mongoid

  # association
  belongs_to :user
  has_many :votes

  # fields
  field :title
  field :content
  field :address
  field :coordinates, type: Array
  field :limit, type: Integer, default: 10
  field :likes, type: Integer, default: 0
  mount_uploader :image, ImageUploader

  # index
  index({ coordinates: "2d" })

  # validation
  validates_presence_of :title, :content

  # scope
  default_scope -> { order(_id: :desc) }


  # geocode
  geocoded_by :address

  # callbacks
  after_validation :geocode

  # scope
end
