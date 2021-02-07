# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    # test
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      redirect_to new_task_path, alert: '値が不正ですよ'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      redirect_to edit_task_path, alert: '値が不正ですよ'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_url
  end

  private

    def task_params
      params.require(:task).permit(:title)
    end
end
