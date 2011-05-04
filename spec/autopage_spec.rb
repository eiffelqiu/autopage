require File.dirname(__FILE__) + '/spec_helper.rb'

class String
  include Autopage
end

describe "autopage" do

  before :all do
    @array = "xxxxxx".split_page(3)
    @array1 = "xxxxxx".split_page(5)
    @array2 = "xxxxxx".split_page(10)    
    @htmlStr = "xxxxxx".tab_page(3)
  end
  
  describe '#split_page' do
    it 'split_page should return an array' do
      @array.should be_kind_of(Array)
      @array.should == ['xxx','xxx']
      @array1.should == ['xxxxx','x']
      @array2.should == ['xxxxxx']
    end
  end

  describe '#tab_page' do
    it 'tab_page should return an html tab code' do
      @htmlStr.should be_kind_of(String)
      @htmlStr.strip.should == %{<div id='idTabs'><ul><li><a href='#page1'>1</a></li><li><a href='#page2'>2</a></li></ul><div id='page1'>xxx</div><div id='page2'>xxx</div></div>}
    end
  end
  
end
