
class SongsController < ApplicationController

get '/songs' do
  @songs = Song.all
  # binding.pry
  erb :'/songs/index'
end

get '/songs/new' do
  @genres = Genre.all
  erb :'/songs/new'

end

get '/songs/:slug' do
  @genres = Genre.all
  @song = Song.find_by_slug(params[:slug])
  erb :'songs/show'
end

post '/songs' do
  @song = Song.create(:name => params["Name"])
  @genres = Genre.all
  @song.genre_ids = params[:genres]
  @song.artist = Artist.find_or_create_by(:name => params["Artist Name"])
  @song.save
  # flash[:message] = "Successfully created song."
  redirect("/songs/#{@song.slug}")
end

get '/songs/:slug/edit' do
  @genres = Genre.all
  @song = Song.find_by_slug(params[:slug])
  erb :'songs/edit'
end

patch '/songs/:slug' do
  @song = Song.find_by_slug(params[:slug])
  @song.genre_ids = params[:genres]
  @song.update(params[:song])
  @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
 # binding.pry
  @song.save
# binding.pry
  # flash[:message] = "Successfully updated song."
  redirect("/songs/#{@song.slug}")
# binding.pry

end
end
