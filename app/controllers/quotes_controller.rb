class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  def index
    @quotes = Quote.all
  end

  def show
  end

  
  def new
    @quote = Quote.new
  end

  
  def edit
  end

  
  def create
    @quote = current_user.quotes.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render action: 'show', status: :created, location: @quote }
      else
        format.html { render action: 'new' }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @quote = current_user.quotes.find(params[:id])
     if params[:quote] && params[:quote].has_key?(:user_id)
      params[:quote].delete(:user_id)
    end
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url }
      format.json { head :no_content }
    end
  end

  private
    
    def set_quote
      @quote = Quote.find(params[:id])
    end


    
    def quote_params
      params.require(:quote).permit(:content, :user_id) if params[:quote]
    end
end
