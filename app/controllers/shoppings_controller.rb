class ShoppingsController < ApplicationController
    def index
      @group = Group.find(params[:group_id])
      @shopping = @group.shoppings.order(id: :desc)
    end
  
    def show
      @shopping = Shopping.find(params[:id])
    end
  
    def new
      @shopping = Shopping.new
    end
  
    def create
      @shopping = current_user.shoppings.new(shoppings_params.except(:group_ids))
      @groups = Group.where(id: shoppings_params[:group_ids])
      if @groups.empty?
        flash.now[:error] = 'Please choose at least one category!'
        render :new
      elsif @shopping.save
        @groups.each do |group|
          group.shoppings << @shopping
        end
        flash[:success] = "Transaction was created and added to Group #{@groups.length}!"
        redirect_to group_shoppings_path(params[:group_id])
      else
        flash.now[:error] = @shopping.errors.full_messages.to_sentence
        render :new
      end
    end
  
    def edit
      @shopping = Shopping.find(params[:id])
    end
  
    def update
      @shopping = Shopping.find(params[:id])
      @groups = Group.where(id: shoppings_params[:group_ids])
      if @groups.empty?
        flash.now[:error] = 'Please choose at least one category!'
        render :edit
      elsif @shopping.update(shoppings_params.except(:group_ids))
        @shopping.groups.delete_all
        @groups.each do |group|
          group.shoppings << @shopping unless group.shoppings.include?(@shopping)
        end
        flash[:success] = 'Transaction has been updated successfully!'
        redirect_to group_shoppings_path(params[:group_id])
      else
        flash.now[:error] = @shopping.errors.full_messages.to_sentence
        render :edit
      end
    end
  
    def destroy
      @shopping = Shopping.find(params[:id])
      if @shopping.destroy
        flash[:success] = 'Transaction has been deleted successfully!'
        redirect_to group_purchases_url(params[:group_id])
      else
        flash.now[:error] = @shopping.errors.full_messages.to_sentence
        render :show
      end
    end
  
    private
  
    def shoppings_params
      params.require(:shopping).permit(:name, :amount, group_ids: [])
    end
end