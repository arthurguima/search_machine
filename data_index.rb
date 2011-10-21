class Data_index
	attr_accessor :list, :hash_table
# Trabalha com a construção da tabela hash a partir dos arquivos criados pelo parser

	def initialize(file)
		if File.exist?(file)
      @list = File.open(file)
    end
    @hash_table = Hash.new
	end


   # Inicia o Hash a partir do arquivo de entrada file
   # Retorna o indice invertido; Tipo: Hash
   # hash[termo] = [qtd, hash[documento]]; hash[documento] = [qtd, posição1, posição2...
   def init_hash
      @list.each_line do |i|
        
        aux = i.split(' ') #

        if @hash_table.has_key?(aux.first) == false #Se o termo ainda não existe no indice
           
           # Adiciona o termo ao hash; Valor = novo Hash[docID] = [pos]
           @hash_table[aux.first] = [ Hash[aux[3].to_i ,] [aux[2].to_i] ] #[aux[1],[aux[2].to_i]] 
           
           @hash_table[aux.first].insert(0,1) # Inicia o contador do termo com 1
           @hash_table[aux.first][1][aux[3].insert(0,1) # Inicia o contador do termo do documento

        else # Quando já esta no indice
   
            # Verifica se o documento já está no hash do table
            @hash_table[aux.first][1].has_key?(aux[3] to_i) ? @hash_table[aux.first][1][aux[3].to_i].push(aux[1.to_i]) : @hash_table[aux.first][1][aux[2].to_i] = [aux[1].to_i]
            
            @hash_table[aux.first][0] = @hash_table[aux.first][0] + 1 # Aumenta o contador do termo na colecao
            @hash_table[aux.first][1][aux]                                                          # Aumenta o contaodo do termo no documento  
        end

      end
      
      @list.close()
      return @hash_table
   end
end
