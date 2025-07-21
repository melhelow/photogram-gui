class PhotosController < ApplicationController

  def index
      matching_photos = Photo.all 
      @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photo_templates/index"})
  end

  def show
    #Parameters: {"path_id"=>"777"}
    url_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => url_id })

    @the_photo = matching_photos.at(0)

    render({ :template =>"photo_templates/show"})
    
  end

  def baii
    #Parameters: {"toast_id"=>"777"}

    the_id =params.fetch("toast_id")
    matching_photos = Photo.where({ :id => the_id })

    the_photo = matching_photos.at(0)

    the_photo.destroy

    #render({ :template => "photo_templates/baii"})

    redirect_to("/photos")
  end

  def create
  input_image = params["query_image"]
  input_caption = params["query_caption"]
  input_owner_id = params["query_owner_id"]

  if input_image.blank? || input_caption.blank? || input_owner_id.blank?
    render plain: "Missing required fields", status: 400
    return
  end

  a_new_photo = Photo.new
  a_new_photo.image = input_image
  a_new_photo.caption = input_caption
  a_new_photo.owner_id = input_owner_id

  a_new_photo.save

  redirect_to("/photos/#{a_new_photo.id}")
end


end
