# frozen_string_literal: true

require 'rspec'
require_relative '../lib/bookmark_analyzer.rb'

describe BookMarkAnalyzer do
  before :each do
    @bookmarks = BookMarkAnalyzer.new

  end
  it 'should have elements' do
    expect(@bookmarks).not_to be_empty
  end

  it  'should have method 2' do


  end


end
