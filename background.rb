module background.rb

    def readfromsaved(name,pass)
        tasks=Array.new
        priorities=Array.new
        if File.exist?(name) 
            File.readlines(name).each_with_index do |line,i|
                priorities[i]=line[line.length()-2]
                tasks[i]=line.chomp.chop
            end
        else
            tasks[0]=pass
            puts "Ficheiro inexistente,a criar novo ficheiro de tarefas com o nome e password inseridos"
        end    
            return [tasks,priorities];
    end

    def viewfile (tasks,priorities)
        i=1
        number = tasks.size()
        if number<=1 
            puts "No tasks to show"
        else 
            while i<number
            puts "Task Number #{i}: #{tasks[i]} \nTask Priority: #{priorities[i]}\n\n"
            i+=1
            end 
        end
    end

    def login 
        opcao=String.new
        name=String.new
        user=String.new
        pass=String.new
        puts "Login(1) ou Signup(0): "
        puts "As passwords são relativas a cada ficheiro e não ao User logo podes escolher diferentes passwords para cada ficheiro de tarefas que tenhas"
        loop do 
            print "Opção: "
            opcao=gets.chomp
            if opcao==1.to_s
                puts "Insira nome do seu ficheiro:  "
                name = gets.chomp
                puts "Insira username: "
                user = gets.chomp
                puts "Insira a sua password: "
                pass = gets.chomp
            elsif opcao==0.to_s
                puts "Insira o nome do ficheiro onde vão ser guardadas as suas tarefas: "
                name=gets.chomp
                puts "Insira username: "
                user= gets.chomp
                puts "Insira password: "
                pass=gets.chomp
            else
                puts "Opção Inválida"
                puts "Login(1) ou Signup(0): "
            end
                break if opcao==0.to_s || opcao==1.to_s
        end
        return [name,user,pass,opcao]
    end

    def salva(tasks,priorities,name)
        file=File.open(name,"w")
        tasks.each_with_index do |task,i|
        file.puts(task+priorities[i].to_s)
        end
        file.close
    end


    def menu
        puts "\n-----------------MENU-----------------\n"
        puts "Ver Tarefas--1"
        puts "Alterar Tarefas--2"
        puts "Adicionar Tarefa--3"
        puts "Remover Tarefa--4"
        puts "Mudar de User--5"
        puts "Sair--6"
        print "Opção: "
        opcao=gets.chomp
        return opcao
    end

    def checkpass(tasks,pass,user)
        escolha=String.new
        if pass == tasks[0]
            puts "Login data correct! Accessing files beepboopbeepboop\n"
            puts "Welcome #{user}\n"
        else 
            puts("Login data incorrect!! Intel beats Motorolla\n")
            exit
        end
    end
