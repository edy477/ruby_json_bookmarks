# frozen_string_literal: true

require 'faraday'
require 'json'
require 'date'

class BookMarkAnalyzer
  attr_reader :bookmarks

  BASE_URL = 'https://gist.githubusercontent.com/diegoacuna/47740d1d76f06aa8ced9a0db448e90a5/raw/576ea6d802741c21ef600995763e69661b254fb8/coding_challenge_endpoint.json'

  def initialize
    response = Faraday.get(BASE_URL)
    @bookmarks = JSON.parse(response.body, symbolize_names: true)
  end

  def most_bookmarked_projects(site, month)
    filtered_by_site = @bookmarks.select { |element| element[:sites].include? site }

    filtered_by_site.select do |item|
      item[:bookmarks].each do |x|
        if get_date_format(x[:created_at]) == month
        end
      end
    end
    filtered_by_site.sort_by { |x| x[:bookmarks].length }.map { |x| x[:title] }.reverse!
  end

  def print_bookmarks
    puts @bookmarks
  end

  def get_date_format(date)
    Date.parse(date).strftime('%m').to_i
  end

  def best_performant_sites(month)
    filtered_by_month = @bookmarks.select { |x| Date.parse(x[:created_at]).strftime('%m').to_i == month }
    sites = filtered_by_month.map { |m| m[:sites] }.flatten.uniq
    temp = []
    sites.each do |x|
      temp.push([x, filtered_by_month.select do |tp|
                      tp[:sites].include? x
                    end.map { |x| x[:pageviews].to_i }.reduce(0) { |sum, count| sum + count }])
    end
    temp.sort_by { |x| [x[1]] }
  end

  def bookmarks_per_month(month)
    @bookmarks.map do |x|
      x[:bookmarks]
    end.flatten.select { |x| get_date_format(x[:created_at]) == month }.length
  end
end

books = BookMarkAnalyzer.new

# books.print_bookmarks
# p books.most_bookmarked_projects('cl', 6)
# p books.best_performant_sites(6)
# p books.bookmarks_per_month(6)
