class parser_receiver (file)
	attr_accessor :list, :hash_table
# Trabalha com a construção da tabela hash a partir dos arquivos criados pelo parser

	def initialize
		if File.exist?(file)
            @list = File.open(file)
        end
	end

    def init_hash
        hash_table = Hash.new

        @list.each_line do |i|
            aux = i.split(' ')
            hash_table[aux.delete_at(0)] = aux
        end     
                
        return hash_table
    end
        
    

end
