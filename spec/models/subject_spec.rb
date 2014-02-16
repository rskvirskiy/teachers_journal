require 'spec_helper'

describe Subject do
  describe '#create' do
    it 'should be create' do
      expect(Subject.create(name: 'subject').errors).to be_empty
    end

    it 'should not create when name is nil' do
      expect(Subject.create.errors).to be
      expect { Subject.create }.to_not change { Subject.count }
    end
  end
end
