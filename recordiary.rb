#!/usr/bin/env ruby
require "date"
require "thor"
class Recordiary < Thor
	def self.exit_on_failure?
    true
  end

	desc "record TEXT", "to record the text"
		
	DIR 			= ENV['RECORDIARY_DIR'] || Dir.pwd
	FILE_NAME = Date.today.strftime("%Y%m%d.md").freeze
	PATH      = DIR + '/' + FILE_NAME
	NO_WORK 	= "don't work".freeze
	def record(text=NO_WORK)
		#textが与えられたら、今日のファイルに追記して、標準出力にファイルの中身を表示する
		if text != NO_WORK
			write_add(text: text.to_s)
			show
			return
		end
		#textが与えられず、ファイルがある場合には中身を表示して、ファイルがない場合にはコメントを表示する
		if File.exist?(PATH)
			show
		else
			comment
		end
	end
	
	private 
		def write_add(file_name: PATH, text:)
			File.open(file_name, "a") do |file|
				file.puts "- #{text}"
			end
		end

		def show(file_name: PATH)
			File.open(file_name, "r") do |file|
				file.each_line{|line| puts line}
			end
		end

		def comment
			p "Happy. You don't have work, today. "
		end
end
Recordiary.start