# -*- coding: utf-8 -*-

require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'logger'
require 'csv'

puts "Ruby: #{RUBY_VERSION}"

log = Logger.new('./rubyflie.log')
#logger.level = Logger::DEBUG
# 各ログレベルのログメッセージを'/tmp/rubyflie.log'に出力
#log.debug('*debug log')
#log.info('*info log')
#log.warn('*warn log')
#log.error('*error log')
#log.fatal('*fatal log')
#log.unknown('*unknown log')

log.debug('Start Crawling...')

class Crawler
    def run
        #Net::HTTP.prepend Module.new {
        #    def use_ssl=(flag)
        #      super
        #      self.ciphers = "DEFAULT:!DH"
        #    end
        #}

        #puts '-----------------------'
        #url = example_url
        #doc = Nokogiri::HTML(URI.open(
        #    url, :proxy => 'http://localhost:5432',
        #    #:ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE
        #))

        #puts doc.title
        puts '-----------------------'

        proxy_addr = "localhost"
        proxy_port = 5432
        host = example_url
        #path = "/"
        
        #url = URI.parse(host + path)
        url = URI.parse(host)
        #req = Net::HTTP::Get.new(url.path)
        puts "url: #{url}"
        res = Net::HTTP.start(url.host, 443, proxy_addr=proxy_addr, proxy_port=proxy_port) { |http|
        #res = Net::HTTP.start(url.host, 443, :use_ssl=>true) { |http|
        #res = Net::HTTP.start(url.host, 443, :use_ssl=>true) { |http|
                #http.request(req)
            http.get("/index.html")
            #http.get("/keiba/baba/index2.html")
    #	  @rss = RSS::Parser.parse(feed)
    #	  puts @rss
        }
        case res
            when Net::HTTPSuccess
                #log.info('Request OK')
                puts "HTTPSuccess"
                puts res
            when Net::HTTPRedirection
                puts "HTTPRedirection"
                puts res['location']
                puts res
            when Net::HTTPBadRequest
                #log.error('HTTPBadRequest')
                puts "HTTPBadRequest"
                puts "[がーん！] #{res}"
            else
                #log.unknown('*unknown log')
                res.value
        end
        
        puts 'res.body: ', res.body
    #	@rss = RSS::Parser.parse(res)
    #	puts @rss
        #feed = Net::HTTP.get(host, path).force_encoding('utf-8')
        #puts feed
        
        #@rss = RSS::Parser.parse("http://egingerz.hatenablog.com/rss")
        #erb :index

    end

private
    def example_url
        "https://www.example.xxxx"
    end
end

crawler = Crawler.new
crawler.run
