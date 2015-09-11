require "rails_helper"

describe CreatesProject do 
	it "creates a project given a name" do 
		creator = CreatesProject.new(name: "Project Bob")
		creator.build
		expect(creator.project.name).to eq("Project Bob")
	end

	describe "task string parsing" do
		let(:creator) { CreatesProject.new(name: "Test", task_string: task_string) }
		let(:tasks) { creator.convert_string_to_tasks } 

		describe "with an empty string" do 
			let(:task_string) { "" }
			specify { expect(tasks.size).to eq(0) }
		end

		describe "with a single string" do 
			let(:task_string) { "about things" }
			let(:tasks) { creator.convert_string_to_tasks }
			specify { expect(tasks.size).to eq(1) }
			specify { expect(tasks.map(&:title)).to eq(["about things"]) }
			specify { expect(tasks.map(&:size)).to eq([1]) }
		end

		describe "with a single string with size" do 
			let(:task_string) { "about things:3" }
			let(:tasks) { creator.convert_string_to_tasks }
			specify { expect(tasks.size).to eq(1) }
			specify { expect(tasks.map(&:title)).to eq(["about things"]) }
			specify { expect(tasks.map(&:size)).to eq([3]) }
		end

		describe "handles multiple tasks" do 
			let(:task_string) { "about things:3\nanother things:2"}
			let(:tasks) { creator.convert_string_to_tasks }
			specify { expect(tasks.size).to eq(2)	}
			specify { expect(tasks.map(&:title)).to eq(["about things", "another things"]) }
			specify { expect(tasks.map(&:size)).to eq([3, 2]) }
		end
		
		describe "attaches tasks to the project" do
			let(:task_string) { "about things:3\nanother things:3" }
			it "saves the project and tasks" do 
				creator.create
				expect(creator.project.tasks.size).to eq(2)
				expect(creator.project).not_to be_a_new_record
			end
		end
	end
end
