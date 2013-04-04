require 'RMagick' 

class SamplesController < ApplicationController

	#attr_reader :image = "assets/samples/1/afmk1.jpg"

	attr_reader :image #= "samples/1"

	attr_reader :images

	def index
		@image = "assets/samples/1/afmk1.jpg"
		
	end 

	def show
		im = image(params[:id],1).resize_to_fill(200,200).gamma_correct(1.0).border(1,1, "#000")	
		send_data im.to_blob, :type	=> 'image/png' , :disposition => 'inline'
	end

	def image (sample, number)
		Magick::Image.read("#{Rails.root}/app/assets/images/samples/#{sample}/afmk#{number}.jpg").first
	end		
end
