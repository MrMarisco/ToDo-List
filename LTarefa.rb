require_relative 'tarefa'

class LTarefa 

    def initialize 
        @l=Array.new
    end

    def readfromsaved(filename)
        File.readlines(filename).each_with_index do |line,i|
            t=Tarefa.new
            line=line.chomp
            sec=line.index(",") - 1
            thi=line.index(".") - 1
            fort=line.index("^") -1
            t.task = line[0..sec]
            t.priority = line[sec+2..thi]
            t.time = line[thi+2..fort]
            t.status = line[fort+2..]
            @l.push(t)
        end
    end

    def complete (i)
        time=Time.new.to_a
        @l[i-1].status = "Completed            Time of completion: " + time[3].to_s + "/" + time[4].to_s + "/" + time[5].to_s  + "  " + time[2].to_s + ":" + time[1].to_s
    end

    def showTarefas
        if @l.empty? 
            puts "No tasks to show"
        else
            @l.each_with_index do |tarefa,i|
                puts "Tarefa número: #{i+1}\n\nTarefa: #{tarefa.task}                  Status: #{tarefa.status}\n\nPrioridade da Tarefa: #{tarefa.priority}              Added: #{tarefa.time}\n\n\n"
            end
        end
    end

    def salva(name)
        file=File.open(name,"w")
        @l.each do |tasks|
        file.puts(tasks.task + "," + tasks.priority.to_s + "." + tasks.time + "^" + tasks.status.to_s)
        end
        file.close
    end

    def size ()
        @l.size()
    end

    def addTarefa (t) 
        @l.push(t)
    end

    def editTarefa(i,t) 
        @l[i]=t
    end

    def remTarefa(i)
        @l.delete_at(i)   
    end
end
