require 'RMagick' 

class SamplesController < ApplicationController

	#attr_reader :image = "assets/samples/1/afmk1.jpg"

	attr_reader :image #= "samples/1"

	attr_reader :images

	def index
		@image = "assets/samples/1/afmk1.jpg"
		
	end 

	def show
		im = Magick::Image.read("#{Rails.root}/app/assets/images/samples/1/afmk1.jpg").first
		send_data im.to_blob, :type	=> 'image/png' , :disposition => 'inline'
	end
end
