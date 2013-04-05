require 'RMagick' 

class SamplesController < ApplicationController

	GAMMA_LOW = 0.5
	GAMMA_HIGH = 1.31

	SIGMA_LOW = 0.001
	SIGMA_HIGH = 0.51

	attr_reader :image 

	attr_reader :image_urls

	def index
		@image = "assets/samples/1/afmk1.jpg"
		
	end 

	def gamma_value (index, number)
		GAMMA_LOW + (index.to_f*((GAMMA_HIGH-GAMMA_LOW)/number))
	end

	def blur (image, index, number) 
		image.blur_image(0.0, SIGMA_HIGH - (index.to_f*(SIGMA_HIGH-SIGMA_LOW)/number))
	end

	def image_url (sample, index) 
		"#{sample}/thumbnails/#{index}"
	end

	def show
		@image_urls = Array.new
		12.times { |x|
			@image_urls[x] = image_url(params[:id], x)
		}
		@image_urls = @image_urls.each_slice(4).to_a

		#send_data images[1].to_blob, :type	=> 'image/png' , :disposition => 'inline'
	end

	def thumbnail
		image = image(params[:sample],1).resize_to_fill(100,100).gamma_correct(gamma_value(params[:id], 12))

		image = blur(image, params[:id], 12).border(2,2, "#000")
		send_data image.to_blob, :type	=> 'image/png' , :disposition => 'inline'
	end


	def image (sample, number)
		Magick::Image.read("#{Rails.root}/app/assets/images/samples/#{sample}/afmk#{number}.jpg").first
	end		
end
