require_relative 'Luser'
require_relative 'LTarefa'
require_relative 'user'
require_relative 'tarefa'

def menu
    puts "-----------------MENU-----------------

    Ver Tarefas--1
    Adicionar Tarefa--2
    Alterar Tarefas--3
    Completar Tarefa--4
    Remover Tarefa--5
    Mudar de User--6
    Sair--7\n
--------------------------------------"
    print "Opção: "
    opcao=gets.chomp
    return opcao
end

def printpriority 
    puts "Insira a prioridade: 
    1 -> New Year Resolution
    2 -> Algoritmos
    3 -> Algoritmos after 2 years failing
    4 -> Apanhar a P*** no jantar de curso
    5 -> Emergência no CeSIUM\n"
end


lu = Luser.new

lu.getusers("users")

u = User.new

u=lu.login()

lu.salvausers("users")

lt=LTarefa.new

lt.readfromsaved(u.filename)

loop do
    opcao=menu()
    puts 
    escolha=""
    case opcao
    when "1" 
        lt.showTarefas()
    when "3"
        alt=""
        altp=""
        number=lt.size()
        if number<=0
            puts "Empty File you cant change anything"
        else
            puts "Escolha a Tarefa a alterar entre 1 (primeira tarefa) e #{number}(última tarefa): "
            linha=gets.chomp.to_i
            while linha < 1 || linha > number
                print "Tarefa Inválida! Insira uma opção válida: "
                linha=gets.chomp.to_i 
            end
            if linha <=number && linha>=1
                t=Tarefa.new
                print "Insira o que colocar no seu lugar: "
                t.task = gets.chomp 
                printpriority()
                altp = gets.chomp.to_i
                while altp>5 || altp<1 
                    print "Tu e os testes...Insere lá um valor a sério: "
                    altp=gets.chomp
                end
                t.priority=altp
            end
            puts "Deseja Guardar a linha alterada? (Sim ou Não) "
            escolha=gets.chomp
            case escolha
            when "s","S","sim","Sim"
                lt.editTarefa(linha-1,t)
                lt.salva(u.filename)
                puts "A linha foi guardada"
            when "n","N","não","Não"
                puts "O conteúdo não será salvo"
            else puts "Opção Inválida, o conteúdo não será salvo"
            end
        end
    when "2"
        printpriority()
        t=Tarefa.new
        prioridade=gets.chomp.to_i
        while prioridade<=0 || prioridade > 5
            puts "Sim isto é à prova de idiotas. Agora insere lá um valor a sério: "
            prioridade=gets.chomp.to_i
        end
        t.priority=prioridade
        puts "Insira a tarefa: "
        t.task=gets.chomp
        puts "Deseja guardar a tarefa?"
        escolha=gets.chomp
        case escolha 
        when "sim","s","Sim","S"
            lt.addTarefa(t)
            lt.salva(u.filename)
        when "n","não","N","Não"
            "A tarefa não foi guardada"
        else
            puts "Escolha inválida!! A tarefa não será guardada"
        end
    when "4"
        lt.showTarefas()
        s=lt.size()
        if s<=0
            puts "so nothing to complete"
        else
            puts "Indique a Tarefa a completar de 1 a #{s}"
            opcao=gets.chomp.to_i
            lt.complete(opcao)
            lt.salva(u.filename)
        end
    when "5"
        lt.showTarefas()
        s=lt.size()
        if s<=0
            puts "So nothing to remove"
        else
            puts "\nQue tarefa deseja apagar entre 1 e #{s}"
            k=gets.chomp.to_i
            while k <1 || k>s
                print "Sempre a testar... C'mon gimme the plant: "
                k=gets.chomp.to_i
            end
            puts "Tem a certeza que deseja apagar esta tarefa?"
            escolha=gets.chomp
            case escolha
            when "s","sim","S","Sim"
                lt.remTarefa(k-1)
                lt.salva(u.filename)
            when "n","não","N","Não"
                puts "F. Now go and do it"
            else 
                puts "Escolha inválida, não será apagada!" 
            end
        end
    when "6"
        lu.getusers("users")
        u=lu.login()
        lu.salvausers("users")
        lt=LTarefa.new
        lt.readfromsaved(u.filename)
    when "7"
        puts("Goodbyyyyyyyee MoonMan")
        exit
    else     
        puts "Opção Inválida"
    end
end
