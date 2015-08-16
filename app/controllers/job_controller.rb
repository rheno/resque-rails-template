class JobController < ApplicationController
  def index
	Resque.enqueue(Task, params[:task])
  end
end
