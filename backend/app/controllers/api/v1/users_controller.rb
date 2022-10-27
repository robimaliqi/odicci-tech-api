class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # pk_ddb58c0be93b06ddd4bbb7111c98696e98

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.valid?
      # post to klaviyo

      url = URI("https://a.klaviyo.com/api/profiles/")
      require "net/http"
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["revision"] = '2022-10-17'
      request["content-type"] = 'application/json'
      request["Authorization"] = 'Klaviyo-API-Key pk_ddb58c0be93b06ddd4bbb7111c98696e98'
      body = {data: {
        type: :profile,
        attributes: {
          email: @user.email,
          phone_number: @user.phone_number,
          external_id: @user.id,
          first_name: @user.first_name,
          last_name: @user.last_name
        }
        }}
      request.body = body.to_json

      response = http.request(request)
      if response.is_a?(Net::HTTPSuccess)
        puts response.read_body
        render json: @user, status: :created
      else 
        render json: response.read_body, status: :unprocessable_entity
      end
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:first_name, :last_name, :email, :phone_number, :date_of_birth)
    end
end
