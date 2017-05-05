class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  # association
  belongs_to :user
  belongs_to :event
  has_many :comments, as: :commentable
  belongs_to :election

  # fields
  field :seq, type: Integer
  field :title
  field :content
  field :likes, type: Integer, default: 0
  field :coordinates, type: Hash
  mount_uploader :image, ImageUploader

  # validation
  validates_presence_of :title, :content

  # scope
  default_scope -> { order(_id: :desc) }

  # callbacks
  before_create :assign_id
  before_save :set_location

  # methods
  protected

  def assign_id
    self.seq = Sequence.generate_id(election, :vote)
  end

  def set_location
    self.extract_geocoordinates
  end

  def extract_geocoordinates
    return unless image || self.image_changed?

    img_lat = image.get_exif('GPSLatitude').split(', ') rescue nil
    img_lng = image.get_exif('GPSLongitude').split(', ') rescue nil

    lat_ref = image.get_exif('GPSLatitudeRef') rescue nil
    lng_ref = image.get_exif('GPSLongitudeRef') rescue nil

    return unless img_lat && img_lng && lat_ref && lng_ref
    return if img_lat.blank? && img_lng.blank? && lat_ref.blank? && lng_ref.blank?

    latitude = to_frac(img_lat[0]) + (to_frac(img_lat[1])/60) + (to_frac(img_lat[2])/3600)
    longitude = to_frac(img_lng[0]) + (to_frac(img_lng[1])/60) + (to_frac(img_lng[2])/3600)

    latitude = latitude * -1 if lat_ref == 'S'  # (N is +, S is -)
    longitude = longitude * -1 if lng_ref == 'W'   # (W is -, E is +)

    self.coordinates = {latitude: latitude, longitude: longitude}

    # if geo = Geocoder.search("#{latitude},#{longitude}").first
    #   self.city = geo.city
    #   self.state = geo.state
    #   self.zipcode = geo.postal_code
    # end
  end

  def to_frac(strng)
    numerator, denominator = strng.split('/').map(&:to_f)
    denominator ||= 1
    numerator/denominator
  end
end
