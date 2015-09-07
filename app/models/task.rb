class Task
	attr_accessor :size, :completed
	
	def initialize(options = {})
		@completed = options[:completed]
		@size = options[:size]
	end
	def complete?
		@completed
	end
	def mark_completed
		@completed = true
	end
end