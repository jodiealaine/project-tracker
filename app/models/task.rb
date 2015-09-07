class Task
	def initialize
		@completed = false
	end

	def complete?
		@completed
	end
	def mark_completed
		@completed = true
	end
end