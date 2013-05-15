require 'spec_helper'

describe Tag do
  it "can be instantiated" do
    Tag.new.should be_an_instance_of(Tag)
  end

  it "can be saved successfully" do
    Tag.create.should be_persisted
  end
end
