require_relative 'user'

class Luser 

    def initialize() 
        @l=Array.new
    end

    def adduser(u) 
        @l.push(u)
    end

    def salvausers(filename) 
        f=File.open(filename,"w")
        @l.each do |user|
            f.puts(user.filename.to_s + "." + user.username.to_s + "," + user.pass.to_s)
        end
        f.close
    end

    def getusers(filename)
        File.readlines(filename).each_with_index do |line,i|
            user=User.new
            line=line.chomp
            sec=line.index(".").to_i - 1
            thi=line.index(",").to_i - 1
            user.filename = line[0..sec]
            user.username = line[sec+2..thi]
            user.pass = line[thi+2..]
            @l.push(user)
        end
    end

    def login
        puts "As passwords são relativas a cada ficheiro e não ao User logo podes escolher diferentes passwords para cada ficheiro de tarefas que tenhas\nLogin(1) ou Signup(0): "
        print "Opção: "
        opcao=gets.chomp.to_i
        while opcao!= 0 && opcao!= 1
            print "Opção Inválida!! \n Login(1) ou Signup(0): "
            opcao=gets.chomp.to_i
        end
        t=true
        u=User.new
        while t || !checkcredentials?(u) 
            t=false
            puts "Insira nome do seu ficheiro:  "
            u.filename = gets.chomp
            puts "Insira username: "
            u.username = gets.chomp
            puts "Insira password: "
            u.pass = gets.chomp
            if opcao==0
                t=checkcredentials?(u)
                if t
                    puts "User existente try again"
                    exit
                else 
                    adduser(u)
                    salvausers("users")
                    f=File.open(u.filename,"w")
                    f.close
                end
            end
            if !checkcredentials?(u) 
                puts "Credenciais Inválidas"
                puts ("Deseja tentar de novo?(1->SIM 0->NÃO\n")
                print ("Opção: ")
                op=gets.chomp.to_i
                if op==0
                    puts ("Bye")
                    exit
                end
            end
        end
        puts "Welcome #{u.username}"
        return u
    end

    private 

    def checkcredentials?(u) 
        @l.each do |user|
            if user.filename==u.filename && user.username==u.username && user.pass==u.pass
                return true
            end
        end
        return false
    end
end