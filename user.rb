class User 
    
    attr_accessor :pass,:filename,:username

    def initialize (pass="",filename="",username="")
        @pass=pass
        @filename=filename
        @username=username
    end
    

end