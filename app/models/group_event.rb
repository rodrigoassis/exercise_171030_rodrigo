class GroupEvent < ApplicationRecord
  geocoded_by :location
  after_validation :geocode

  before_validation :calculate_duration, if: Proc.new { |r| r.start_date.present? && r.end_date.present? && r.duration.blank? }
  before_validation :calculate_start_date, if: Proc.new { |r| r.start_date.blank? && r.end_date.present? && r.duration.present? }
  before_validation :calculate_end_date, if: Proc.new { |r| r.start_date.present? && r.end_date.blank? && r.duration.present? }
  before_validation :confirm_dates, if: Proc.new { |r| r.start_date.present? && r.end_date.present? && r.duration.present? }

  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates_each :name, :description, :start_date, :end_date, :duration, :location do |record, attr, value|
    record.errors.add(attr, "can't be blank to publish") if record.published? && value.blank?
  end

  private

  def calculate_duration
    self.duration = (end_date - start_date).to_i
  end

  def calculate_start_date
    self.start_date = end_date - duration
  end

  def calculate_end_date
    self.end_date = start_date + duration
  end

  def confirm_dates
    self.errors[:base] << "Dates and Duration don't match" unless start_date == end_date - duration
  end
end
