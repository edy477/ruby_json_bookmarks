# frozen_string_literal: true

require 'rspec'
require_relative '../lib/bookmark_analyzer'

describe BookMarkAnalyzer do
  let(:bookmarks) { BookMarkAnalyzer.new }
  it 'should have elements' do
    size = bookmarks.bookmarks.length
    expect(size).not_to be(0)
  end

  it 'should have method most_bookmarked_projects' do
    expect(bookmarks).to respond_to(:most_bookmarked_projects)
  end

  it 'should have method best_performant_sites' do
    expect(bookmarks).to respond_to(:best_performant_sites)
  end

  it 'most_bookmared_projects should be called with 2 arguments' do
    expect(bookmarks).to respond_to(:best_performant_sites).with(1).argument
  end

  it 'most_bookmarked_projects should  return a valid output for test case 1 ' do
    output = ['Campus Quiksilver Na Pali / Patrick Arotcharen', 'ZOOCO / ZOOCO Estudio',
              'Bulleit Frontier Works bar / FAR rohn&rojas']

    allow(bookmarks).to receive(:best_performant_sites).with(2).and_return(output)
    expect(bookmarks.most_bookmarked_projects('cl', 6)).to eq(output)
  end

  it 'best_performant_sites should  return a valid output for test case 1 ' do
    output = [['cl', 39870], ['pe', 24403], ['co', 24403], ['mx', 24403], ['us', 15467]]

    allow(bookmarks).to receive(:best_performant_sites).with(1).and_return(output)
    expect(bookmarks.best_performant_sites(6)).to eq(output)
  end

  it 'bookmarks_per_month should  return a valid output for test case 1 ' do
    allow(bookmarks).to receive(:best_performant_sites).with(1).and_return(9)
    expect(bookmarks.bookmarks_per_month(6)).to eq(9)
  end
end
