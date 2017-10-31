require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  describe 'validations' do
    it 'has a valid Factory' do
      expect(build(:group_event)).to be_valid
    end

    it 'has another valid Factory' do
      expect(build(:filled_group_event)).to be_valid
    end

    it 'is valid with just name' do
      expect(build(:group_event, name: 'Test')).to be_valid
    end

    it 'is valid with just start date' do
      expect(build(:group_event, start_date: Date.today)).to be_valid
    end

    it { is_expected.to validate_numericality_of(:duration).only_integer.is_greater_than_or_equal_to(0) }

    it 'can only be published with all fields' do
      expect(build(:filled_group_event, published: true)).to be_valid
    end

    it 'will validate incorrect dates' do
      expect(build(:filled_group_event, duration: 10, published: true)).to_not be_valid
    end
  end

  describe 'fill duration' do
    let(:group_event) { create(:filled_group_event, published: true) }
    it { expect(group_event.duration).to eq(1) }
  end

  describe 'fill start_date' do
    let(:group_event) { create(:filled_group_event, start_date: nil, duration: 1, published: true) }
    it { expect(group_event.start_date).to eq(Date.new(2017, 10, 30)) }
  end

  describe 'fill end_date' do
    let(:group_event) { create(:filled_group_event, end_date: nil, duration: 1, published: true) }
    it { expect(group_event.end_date).to eq(Date.new(2017, 10, 31)) }
  end
end
