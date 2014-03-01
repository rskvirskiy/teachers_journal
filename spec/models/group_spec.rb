require 'spec_helper'

describe Group do
  describe '#create' do
    it 'should be create' do
      expect(Group.create(name: 'SP13s').errors).to be_empty
    end

    it 'should not create when name is nil' do
      expect(Group.create.errors).to be
      expect { Group.create }.to_not change { Group.count }
    end
  end
end
