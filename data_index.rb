class Data_index
	attr_accessor :list, :hash_table
# Trabalha com a construção da tabela hash a partir dos arquivos criados pelo parser

	def initialize(file)
		if File.exist?(file)
      @list = File.open(file)
    end
    @hash_table = Hash.new
	end

    def init_hash
        @list.each_line do |i|
            aux = i.split(' ')
            # hash[termo] = [qtd, hash[documento]]; hash[documento] = [posição1, posição2...]
           if @hash_table.has_key?(aux.first) == false 
              @hash_table[aux.first] = [ Hash[aux[2].to_i , [aux[1].to_i]]]
              @hash_table[aux.first].insert(0,1)
           else
              @hash_table[aux.first][1].has_key?(aux[2].to_i) ? @hash_table[aux.first][1][aux[2].to_i].push(aux[1.to_i]) : @hash_table[aux.first][1][aux[2].to_i] = [aux[1].to_i]
              @hash_table[aux.first][0] = @hash_table[aux.first][0] + 1
           end     
        end
        return @hash_table
    end
end
