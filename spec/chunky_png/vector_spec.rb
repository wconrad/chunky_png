require 'spec_helper'

describe ChunkyPNG::Vector do
  subject { ChunkyPNG::Vector.new([ChunkyPNG::Point.new(2, 4), ChunkyPNG::Point.new(1, 2), ChunkyPNG::Point.new(3, 6)]) }

  it { should respond_to(:points) }
  it { should have(3).items }

  it "should create a path from a string" do
    ChunkyPNG::Vector('(2,4) (1,2) (3,6)').should == subject
  end
  
  it "should create a vector from a flat array" do
    ChunkyPNG::Vector(2,4,1,2,3,6).should == subject
  end

  it "should create a vector from a nested array" do
    ChunkyPNG::Vector('2x4', [1, 2], :x => 3, :y => 6).should == subject
  end
  
  describe '#x_range' do
    it "should get the right range of x values" do
      subject.x_range.should == (1..3)
    end
  end
  
  describe '#y_range' do
    it "should get the right range of y values" do
      subject.y_range.should == (2..6)
    end
  end
  
  describe '#edges' do
    it "should get three edges when closing the path" do
      subject.edges(true).to_a.should == [[ChunkyPNG::Point.new(2, 4), ChunkyPNG::Point.new(1, 2)],
                                          [ChunkyPNG::Point.new(1, 2), ChunkyPNG::Point.new(3, 6)],
                                          [ChunkyPNG::Point.new(3, 6), ChunkyPNG::Point.new(2, 4)]]
    end
    
    it "should get two edges when not closing the path" do
      subject.edges(false).to_a.should == [[ChunkyPNG::Point.new(2, 4), ChunkyPNG::Point.new(1, 2)],
                                           [ChunkyPNG::Point.new(1, 2), ChunkyPNG::Point.new(3, 6)]]
    end
  end
end
