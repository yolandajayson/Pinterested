class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
def index
  @pins = Pin.all
end
  
def show
end

def new
  @pin = current_user.pins.build
end

def edit
end

def create
  @pin = current_user.pins.build(pin_params)
  respond_to do |format|
    if @pin.save
      format.html { redirect_to @pin, notice: 'Pin was successfully created.' } # --> (MM) You were missing the closing curly brace here.
      format.json { render show, status: :created, location: @pin }    
    else  # (MM) --> this was missing
      format.html { render :new }
      format.json { render json: @pin.errors, status: :unprocessable_entity }
    end
  end
end
def update
  respond_to do |format|  # so was this
    if @pin.update(pin_params)
      # this line was missing: format.html and the curly braces
      format.html { redirect_to @pin, notice: 'Pin was successfully updated' }
      # Not sure what happened here, but the next line is the correct code:
      format.json { render :show, status: :ok, location: @pin }
      # And the following is what you had there:
      # render action: "edit"
      else
        format.html { render :edit }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
    end # missing too
  end
end # missing too
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url, notice: 'Pin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
# def correst_user  --> (MM) This was your original code; make sure to check your spelling! (this was a syntax error)
# This wasn't what caused the error you were having, but it would have caused problems down the road.
def correct_user
  @pin=current_user.pins.find_by(id: params[:id])
    redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
end

private
  def set_pin
    @pin = Pin.find(params[:id])
  end
  
  def pin_params
    params.require(:pin).permit(:description)
  end
end
