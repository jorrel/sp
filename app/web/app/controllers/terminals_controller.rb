class TerminalsController < ApplicationController
  before_filter :find_terminal, :only => [:edit, :update, :delete, :destroy, :show]

  def index
    @terminals = paginate :terminals, :order => 'updated_at DESC'
  end

  def new
    @terminal = Terminal.new
  end

  private

    def find_terminal
      @terminal = Terminal.find(params[:id])
    end
end
