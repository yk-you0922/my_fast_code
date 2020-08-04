class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
