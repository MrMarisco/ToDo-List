require_relative 'Luser'
require_relative 'LTarefa'
require_relative 'user'
require_relative 'tarefa'

def salva(l,name)
    file=File.open(name,"w")
    l do |tasks|
    file.puts(tasks.task+tasks.priority.to_s)
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

lu = Luser.new

lu.getusers("users")

u = User.new

lu.login()

lt = Ltarefa(u.filename)
