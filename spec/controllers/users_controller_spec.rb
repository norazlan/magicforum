require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:all) do
    @user = User.create(email: "test@azlan.co", username: "testing", password: "testing")
    @unauthorized_user = User.create(email: "unauthorized@azlan.co", username: "great", password: "testing2")
  end

  describe "render new" do
    it "should render new" do
      get :new
      expect(subject).to render_template(:new)
      expect(assigns[:user]).to be_present
    end
  end

  describe "create user" do
    it "should create new user" do

      params = { user: { email: "user@gmail.com", username: "thor", password: "password" } }
      post :create, params: params

      user = User.find_by(email: "user@gmail.com")
      expect(User.count).to eql(3)
      expect(user.email).to eql("user@gmail.com")
      expect(user.username).to eql("thor")
      expect(flash[:success]).to eql("Your account has been created")
    end
  end

  describe "edit user" do

    it "should redirect if not logged in" do

      params = { id: @user.id }
      get :edit, params: params

      expect(subject).to redirect_to(root_path)
      expect(flash[:danger]).to eql("Something wrong were happen")
    end

    it "should redirect if user unauthorized" do

      params = { id: @user.id }
      get :edit, params: params, session: { id: @unauthorized_user.id }

      expect(subject).to redirect_to(root_path)
      expect(flash[:danger]).to eql("<your-flash-message>")
    end

    it "should render edit" do

      params = { id: @user.id }
      get :edit, params: params, session: { id: @user.id }

      current_user = subject.send(:current_user)
      expect(subject).to render_template(:edit)
      expect(current_user).to be_present
    end
  end

end
