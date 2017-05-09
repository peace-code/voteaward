class Promise
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :candidate
  has_and_belongs_to_many :awards
  belongs_to :election

  field :show_candidate, type: Boolean, default: true
  field :seq, type: Integer, default: 1
  field :reason
  field :area
  field :sex
  field :age
  field :likes, type: Integer, default: 0

  validates_presence_of :reason, :area, :sex, :age
  validates_uniqueness_of :user_id

  default_scope -> { order(_id: :desc) }

  before_create :assign_id

  private

  def assign_id
    Sequence.generate_id(self.election, :promise)
    self.seq = Sequence.get_last_id(self.election, :promise)
  end
end
