class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do

    ##{ message: "Hello world" }.to_json
    games=Game.all.order(:title).limit(25)
    games.to_json

  end

  get '/games/:id' do
    game = Game.find(params[:id])

    # include associated reviews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
