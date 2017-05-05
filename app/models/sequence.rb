class Sequence
  include Mongoid::Document

  belongs_to :election

  field :object
  field :last_id, type: Integer

  def self.generate_id(election, object)
    @seq=where(election: election, object: object).first || create(election: election, object: object)
    @seq.inc(last_id: 1)
  end

  def self.get_last_id(election, object)
    @seq=where(election: election, object: object).first
    (@seq.blank?) ? 1 : @seq.last_id
  end
end
