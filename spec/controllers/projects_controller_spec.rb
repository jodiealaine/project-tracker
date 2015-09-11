require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
	describe "POST create" do 
		it "creates a project" do 
			post :create, project: {name: "Bob", tasks: "About something:3"}
			expect(response).to redirect_to(projects_path)
			expect(assigns(:action).project.name).to eq("Bob")
		end
	end
end
