class PortfoliosController < ApplicationController
  def index
    @portfolio_items = Portfolio.all
  end

  def angular
    @angular_portfolio_items = Portfolio.angular
  end

  def new
    @portfolio_item = Portfolio.new
    #build = instantiate 3 versions of the portfolio item's technologies and make them available to the form
    3.times { @portfolio_item.technologies.build }
  end

  def show
    @portfolio_item = Portfolio.find(params[:id])
  end

  def create
    @portfolio_item = Portfolio.new(params.require(:portfolio).permit(:title, :subtitle, :body, technologies_attributes: [:name])) #if you see anything coming in under tech attibutes flag with a name, then let it continue. "strong params" are a security

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: 'portfolio_item was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio_item }
      else
        format.html { render :new }
        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @portfolio_item = Portfolio.find(params[:id])
  end

  def update
    @portfolio_item = Portfolio.find(params[:id])

    respond_to do |format|
      if @portfolio_item.update(params.require(:portfolio).permit(:title, :subtitle, :body))
        format.html { redirect_to portfolios_path, notice: 'The record was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    # perform the lookup
    @portfolio_item = Portfolio.find(params[:id])
    # destroy/delete the record
    @portfolio_item.destroy
    # redirect to another page
    respond_to do |format|
      format.html { redirect_to portfolios_path, notice: 'The record was succesfully deleted.' }
    end
  end

end
