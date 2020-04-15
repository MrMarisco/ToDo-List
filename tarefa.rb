class Tarefa
    attr_accessor :task,:priority,:status,:time
    
    def initialize(task="Generic Title",priority=1,status="Pending") 
        @task=task
        @status=status
        @priority=priority
        t=Time.new.to_a
        @time="#{t[3]}/#{t[4]}/#{t[5]} #{t[2]}:#{t[1]}"
    end
end