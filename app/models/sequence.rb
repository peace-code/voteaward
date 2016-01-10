class Sequence
  include Mongoid::Document
  field :object
  field :last_id, type: Integer

  def self.generate_id(object)
    @seq=where(:object => object).first || create(:object => object)
    @seq.inc(last_id: 1)
  end

  def self.get_last_id(object)
    @seq=where(:object => object).first
    (@seq.blank?) ? 0 : @seq.last_id
  end
end
