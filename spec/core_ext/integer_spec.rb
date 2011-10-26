describe Integer do

  context '#closest_fibonacci' do
    it 'should return closest fibonacci number less than itself' do
      0.closest_fibonacci.should be_nil
      1.closest_fibonacci.should == 0
      2.closest_fibonacci.should == 1
      3.closest_fibonacci.should == 2
      4.closest_fibonacci.should == 3
      5.closest_fibonacci.should == 3
      8.closest_fibonacci.should == 5

      99.closest_fibonacci.should == 89      
      156.closest_fibonacci.should == 144
    end
  end

  context '.fibonacci' do
    it 'should return an array or the size specified' do
      seq = Integer.fibonacci(:size => 10)
      seq.size.should == 10
      seq.should == [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
    end

    it 'should include zero when specified' do
      seq = Integer.fibonacci(:size => 10, :zero => true)
      seq.size.should == 10
      seq.should == [0, 1, 2, 3, 5, 8, 13, 21, 34, 55]
    end

    it 'should return a single number when last is true' do
      seq = Integer.fibonacci(:size => 10, :last => true)
      seq.is_a?(Array).should_not be_true
      seq.should == 89
    end

    it 'should return the closest number to the max' do
      seq = Integer.fibonacci(:max => 150)
      seq.is_a?(Array).should_not be_true
      seq.should == 144
    end

    it 'should return size if last is true and size is smaller than 2' do
      Integer.fibonacci(:size => 0, :last => true).should == 0
      Integer.fibonacci(:size => 1, :last => true).should == 1
    end

    it 'should return array if last is false and size is smaller than 2' do
      Integer.fibonacci(:size => 0).should == []
      Integer.fibonacci(:size => 1).should == [1]

      Integer.fibonacci(:size => 0, :zero => true).should == [0]
      Integer.fibonacci(:size => 1, :zero => true).should == [0, 1]
    end

    it 'should through an error if neither size or max are provided' do
      lambda{ Integer.fibonacci }.should raise_error(ArgumentError)
    end
  end

end
