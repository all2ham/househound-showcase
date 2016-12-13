class PosterLight < Prawn::Document
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::AssetTagHelper

  def initialize(listing, view)
    super(:left_margin => 0,:top_margin => 0,:right_margin =>0, :bottom_margin=>0, :page_size => "LETTER")
    @listing = listing
    @agent_profile = @listing.user.agent_profile
    @view = view
    float do
      image "#{Rails.root}/app/assets/images/listings/posterbg_light.jpg",:width => 612, :height => 792
    end
    pdf_address
    pdf_mainimage
    pdf_smallimages
    pdf_bedcount
    pdf_bathcount
    pdf_price
    pdf_qr
    pdf_agent_pic
    pdf_agent_name
    pdf_agent_info
    pdf_broker
  end

  def pdf_address
    font("Helvetica",:size =>35)
    fill_color "373737"
    text_box "#{@listing.address.line_1}", :align=>:center,:at => [0,750],:width=>612
  end

  def pdf_mainimage
    require 'open-uri'
    photo1 =  photos[0] if photos.count > 0
    if photos.count == 1
      image open(photo1.photo.url), :at=>[170,674],:width => 275, :height => 205
    elsif photos.count <=3
      image open(photo1.photo.url), :at=>[98,674],:width => 275, :height => 205
    else
      image open(photo1.photo.url), :at=>[29,674],:width => 275, :height => 205
    end
  end

  def pdf_smallimages
    require 'open-uri'
    photo2 =  photos[1] if photos.count > 1
    photo3 =  photos[2] if photos.count > 2
    photo4 =  photos[3] if photos.count > 3
    photo5 =  photos[4] if photos.count > 4
    if photos.count >= 2
      if photos.count <= 3
        image open(photo2.photo.url), :at=>[381,674],:width => 131, :height => 98
        if photos.count == 3
          image open(photo3.photo.url), :at=>[381,567],:width => 131, :height => 98
        end
      else
        image open(photo2.photo.url),:at=>[312,674],:width => 131, :height => 98
        image open(photo3.photo.url), :at=>[312,567],:width => 131, :height => 98
        image open(photo4.photo.url), :at=>[452,674],:width => 131, :height => 98
        if photos.count <= 5
          image open(photo5.photo.url), :at=>[452,567],:width => 131, :height => 98
        end
      end
    end
  end

  def photos
    @listing.photos.limit(5).to_a
  end

  def pdf_price
    font("Helvetica",:size =>28)
    fill_color "373737"
    text_box "Price: #{number_to_currency(@listing.price)}", :align=>:center,:at => [295,430],:width=>300
  end

  def pdf_bedcount
    font("Helvetica",:size =>28)
    fill_color "373737"
    text_box "#{@listing.bedroom_count}", :align=>:center,:at => [15,430],:width=>70
  end

  def pdf_bathcount
    font("Helvetica",:size =>28)
    fill_color "373737"
    text_box "#{@listing.bathroom_count}", :align=>:center,:at => [150,430],:width=>70
  end

  def pdf_qr
    require 'open-uri'
    def qurl
      "#{@listing.qr_code(125,125)}"
    end
    image open(qurl),:at => [15,275]
  end

  def pdf_agent_pic
    require 'open-uri'
    if @agent_profile.photo
      def agentpic
        @agent_profile.photo
      end
      image open(agentpic.photo.url), :at=>[27,121],:width => 78, :height => 94
    end
  end

  def pdf_agent_name
    font("Helvetica",:size =>30)
    fill_color "373737"
    text_box "#{@agent_profile.name}", :align=>:left,:at => [120,114],:width=>340
  end
  def pdf_agent_info
    font("Helvetica",:size =>16)
    fill_color "373737"
    text_box "#{@agent_profile.phone_number}", :align=>:left,:at => [120,80],:width=>340
    text_box "#{@agent_profile.email}", :align=>:left,:at => [120,60],:width=>340
  end
  def pdf_broker
    float do
      image "#{Rails.root}/app/assets/images/listings/broker_placeholder.jpeg",:at => [490,121], :width => 94, :height => 94
    end
  end
end