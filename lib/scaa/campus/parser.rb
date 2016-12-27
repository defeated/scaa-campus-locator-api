require 'nokogiri'
require 'open-uri' # FIXME: https://twin.github.io/improving-open-uri/
require 'thread'
require 'thwait'

module Scaa
  module Campus
    # scrape scaa homepage list of campuses
    class Parser
      USER_AGENT = 'ScaaCampusLocator/0.1'.freeze
      DEFAULT_URL = 'http://scaaeducation.org/campuses/american-campuses/'.freeze

      attr_reader :results

      def initialize(url: DEFAULT_URL)
        @uri = URI.parse url
        @mutex = Mutex.new
        @results = []
        @threads = []
      end

      def parse!
        fetch_pages.each do |page|
          @threads << Thread.new do
            fetch_campuses(page).each do |row|
              @mutex.synchronize { @results.push from_row(row) }
            end
          end
        end
        ThreadsWait.all_waits(*@threads)
      end

      private

      def fetch(uri, selector)
        doc = Nokogiri::HTML uri.open('User-Agent' => USER_AGENT)
        doc.css selector
      end

      def fetch_pages
        fetch @uri, '#course-list ~ span > a'
      end

      def fetch_campuses(page)
        uri = URI.join @uri, page.attr(:href) # ensure url starts with fqdn
        fetch uri, '#course-list .polytechnic_courses'
      end

      def from_row(row)
        {
          name:     from_col(row, '.course-campus'),
          address:  from_col(row, '.course-address'),
          url:      from_col(row, '.course-website')
        }
      end

      def from_col(row, selector)
        row.at_css(selector).text.strip
      end
    end
  end
end
