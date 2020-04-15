def printpriority 
    puts "Insira a prioridade: 
    1 -> New Year Resolution
    2 -> Algoritmos
    3 -> Algoritmos after 2 years failing
    4 -> Apanhar a P*** no jantar de curso
    5 -> Emergência no CeSIUM\n"
end



def readfromsaved(name,pass,user)
    tasks=Array.new
    priorities=Array.new
    if File.exist?(name) 
        File.readlines(name).each_with_index do |line,i|
            priorities[i]=line[line.length()-2]
            tasks[i]=line.chomp.chop
        end
    else
        tasks=[pass,user]
        priorities=[0,0]
        puts "Ficheiro inexistente,a criar novo ficheiro de tarefas com o nome e password inseridos"
        salva(tasks,priorities,name)
    end    
    data=[tasks,priorities]
    return data
end


def viewfile (tasks,priorities)
    i=2
    number = tasks.size()
    if number<=2
        puts "No tasks to show"
    else 
        while i<number
        puts "Task Number #{i}: #{tasks[i]} \nTask Priority: #{priorities[i]}\n\n"
        i+=1
        end 
    end
end

def login 
    opcao=""
    name=String.new
    user=String.new
    pass=String.new
    puts "As passwords são relativas a cada ficheiro e não ao User logo podes escolher diferentes passwords para cada ficheiro de tarefas que tenhas\nLogin(1) ou Signup(0): "
    print "Opção: "
    opcao=gets.chomp
    while opcao!= "0" && opcao!= "1"
        print "Opção Inválida!! \n Login(1) ou Signup(0): "
        opcao=gets.chom
    end
    if opcao==1.to_s
        puts "Insira nome do seu ficheiro:  "
    else 
        puts "Insira o nome do ficheiro onde vão ser guardadas as suas tarefas: "
    end
    name=gets.chomp
    puts "Insira username: "
    user= gets.chomp
    puts "Insira password: "
    pass=gets.chomp
    credentials=[name,user,pass,opcao]
    return credentials
end

def salva(tasks,priorities,name)
    file=File.open(name,"w")
    tasks.each_with_index do |task,i|
    file.puts(task+priorities[i].to_s)
    end
    file.close
end

def menu
    puts "-----------------MENU-----------------

    Ver Tarefas--1
    Alterar Tarefas--2
    Adicionar Tarefa--3
    Remover Tarefa--4
    Mudar de User--5
    Sair--6\n
--------------------------------------"
    print "Opção: "
    opcao=gets.chomp
    return opcao
end

def checkpass(password,username,pass,user)
    escolha=""
    if pass == password && user == username
        puts "Login data correct! Accessing files beepboopbeepboop\n"
        puts "Welcome #{user}\n"
    else 
        puts("Login data incorrect!! Intel beats Motorolla\n")
        exit
    end
end

credentials=[]
data=[]

credentials=login()

name=credentials[0]
user=credentials[1]
pass=credentials[2]
opcao=credentials[3]

data=readfromsaved(name,pass,user)

tasks=data[0]
priorities=data[1]

checkpass(tasks[0],tasks[1],pass,user)

loop do
    opcao=menu()
    puts 
    escolha=""
    case opcao
    when "1" 
        viewfile(tasks,priorities)
    when "2"
        alt=""
        altp=""
        number=tasks.size()
        if number<=2
            puts "Empty File you cant change shiiit"
        else
            puts "Escolha a Tarefa a alterar entre 1 (primeira tarefa) e #{number-2}(última tarefa): "
            linha=gets.chomp.to_i
            while linha < 1 || linha >= number
                print "Tarefa Inválida! Insira uma opção válida: "
                linha=gets.chomp 
            end
            if linha <=(number-2) && linha>=1
                print "Insira o que colocar no seu lugar: "
                alt = gets.chomp 
                printpriority()
                altp = gets.chomp.to_i
                while altp>5 || altp<1 
                    print "Tu e os testes...Insere lá um valor a sério: "
                    altp=gets.chomp
                end
            end
            puts "Deseja Guardar a linha alterada? (Sim ou Não) "
            escolha=gets.chomp
            case escolha
            when "s","S","sim","Sim"
                tasks[linha]=alt
                priorities[linha]=altp
                salva(tasks,priorities,name)
                puts "A linha foi guardada"
            when "n","N","não","Não"
                puts "O conteúdo não será salvo"
            else puts "Opção Inválida, o conteúdo não será salvo"
            end
        end
    when "3"
        printpriority()
        prioridade=gets.chomp.to_i
        while prioridade<=0 || prioridade > 5
            puts "Sim isto é à prova de idiotas. Agora insere lá um valor a sério: "
            prioridade=gets.chomp.to_i
        end
        puts "Insira a tarefa: "
        tarefa=gets.chomp
        puts "Deseja guardar a tarefa?"
        escolha=gets.chomp
        case escolha 
        when "sim","s","Sim","S"
            k=tasks.size()
            tasks[k]=tarefa
            priorities[k]=prioridade
            salva(tasks,priorities,name)
        when "n","não","N","Não"
            "A tarefa não foi guardada"
        else
            puts "Escolha inválida!! A tarefa não será guardada"
        end
    when "4"
        viewfile(tasks,priorities)
        s=tasks.size()
        if s<=2 
            puts "So nothing to remove"
        else
            puts "\nQue tarefa deseja apagar/completar entre 1 e #{s-2}"
            k=gets.chomp.to_i
            while k <1 || k>=s
                print "Sempre a testar... C'mon gimme the plant: "
                k=gets.chomp.to_i
            end
            puts "Tem a certeza que deseja apagar/completar essa tarefa?"
            escolha=gets.chomp
            case escolha
            when "s","sim","S","Sim"
                while k<s
                    tasks[k]=tasks[k+1]
                    priorities[k]=priorities[k+1]
                    k+=1
                end
                tasks.pop
                salva(tasks,priorities,name)
            when "n","não","N","Não"
                puts "F. Now go and do it"
            else 
                puts "Escolha inválida, não será apagada!" 
            end
        end
            

    when "5"
        credentials=login()
        name=credentials[0]
        user=credentials[1]
        pass=credentials[2]
        opcao=credentials[3]
        data=readfromsaved(name,pass,user)
        tasks=data[0]
        priorities=data[1]
        checkpass(tasks[0],tasks[1],pass,user)
    when "6"
        puts("Goodbyyyyyyyee MoonMan")
        exit
    else     
        puts "Opção Inválida"
    end
end