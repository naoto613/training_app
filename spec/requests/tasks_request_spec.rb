# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'GET' do
    before do
      create(:task, title: 'テストです')
      create(:task, title: 'ありがたい')
      create(:task, title: '勉強中です')
    end

    it 'renders a successful response' do
      get tasks_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('テストです')
      expect(response.body).to include('ありがたい')
      expect(response.body).to include('勉強中です')
    end
  end

  describe 'CREATE' do
    it 'renders a successful response' do
      get new_task_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('新規タスク')
    end
  end

  describe 'EDIT' do
    let(:task1) { create(:task, title: 'テストです') }

    it 'renders a successful response' do
      get edit_task_path(task1)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('タスク編集')
    end
  end

  describe 'POST' do
    # POSTの実行
    def post_tasks_path
      post tasks_url, params: { task: { title: 'テストです' } }
    end

    it 'successful redirect' do
      post_tasks_path
      expect(response).to redirect_to tasks_url
    end

    it 'register a tasks table' do
      expect do
        post_tasks_path
      end.to change(Task, :count).by(1)
    end

    it 'not successful redirect' do
      post tasks_url, params: { task: { title: '' } }
      expect(response).to redirect_to new_task_path
    end
  end

  describe 'PATCH' do
    let(:task1) { create(:task, title: 'テストです') }

    def patch_task_path
      patch task_path(task1), params: { task: { title: 'テストだよ' } }
    end

    it 'successful redirect' do
      patch_task_path
      expect(response).to redirect_to tasks_url
    end

    it 'update a tasks table' do
      patch_task_path
      task2 = Task.find_by(id: task1.id)
      expect(task2.title).to eq('テストだよ')
    end

    it 'not successful redirect' do
      patch task_path(task1), params: { task: { title: '' } }
      expect(response).to redirect_to edit_task_path(task1)
    end
  end

  describe 'DELETE' do
    let(:task1) { create(:task, title: 'テストです') }

    it 'successful redirect' do
      delete task_path(task1)
      expect(response).to redirect_to tasks_url
    end
  end
end
