class ChoicesController < ApplicationController
  def index
    render json: {
      species: {
        'Dog' => [
          'Siberian Husky',
          'German Shepherd'
        ],
        'Cat' => [
          'Siamese',
          'American Curl',
          'Scottish Fold'
        ],
        'T-Rex' => [
          'Pangean Pint'
        ]
      },
      size: ['small', 'medium', 'big'],
      color: ['black', 'white', 'light', 'dark'],
      age: ['young', 'middle-aged', 'old'],
      sex: ['male', 'female']
    }
  end
end