# Trabalha com a construção da tabela hash a partir dos arquivos criados pelo parser
class Data_index
	attr_accessor :list, :hash_table, :qtd_docs

	def initialize(file) 
    if File.exist?(file)
      @list = File.open(file)	
      puts "Encontrado arquivo #{file}"
      @hash_table = Hash.new
    else
      puts "Arquivo #{file} nao foi encontrado"
      exit
    end
	end

  def get_total_docs
    return @qtd_docs.size
  end

   # Inicia o Hash a partir do arquivo de entrada file
   # Retorna o indice invertido; Tipo: Hash
   # hash[termo] = [qtd, hash[documento]]; hash[documento] = [qtd, [p,pos],[p,pos], ...]
   def init_hash

      termo = 0
      parte = 1
      pos = 2
      docid = 3

       @qtd_docs = Hash.new()

      @list.each_line do |i|
        
       out_parser = i.split(' ') #

        @qtd_docs[docid] = 0
                
       unless @hash_table.has_key?(out_parser[termo]) #Se o termo ainda não existe no indice
            
         # Adiciona o termo ao hash; Valor = novo Hash[docID] = [[pos,parte] ...]
         # Hash[termo] = (Hash[docId] = [[ p,pos]])
         @hash_table[out_parser[termo]] = [ Hash[ out_parser[docid].to_i, [ [out_parser[pos].to_i, out_parser[parte].to_s]] ] ]
           
         @hash_table[out_parser[termo] ].insert(0,1) # Inicia o contador do termo
         @hash_table[out_parser[termo]][1][out_parser[docid].to_i].insert(0,[1]) # Inicia o contador do termo do documento 


       else # Quando já esta no indice
   
         # Verifica se o documento já está no hash
           if @hash_table[out_parser[termo]][1].has_key?(out_parser[docid].to_i) 
              # Se o documento existe Adiciona o vetor [p,pos] no hash
              @hash_table[out_parser[termo]][1][out_parser[docid].to_i].push([out_parser[pos].to_i, out_parser[parte].to_s])
              # Aumenta o contador do termo no documento                    
              @hash_table[out_parser[termo]][1][out_parser[docid].to_i][0][0] = 
                @hash_table[out_parser[termo]][1][out_parser[docid].to_i][0][0] +1 
           else       
                 # Caso contrário cria o novo documento com o vetor [p,pos]
                 @hash_table[out_parser[termo]][1][out_parser[docid].to_i] = [ [out_parser[pos].to_i, out_parser[parte].to_s] ]
                 # Cria o contador do termo no documento  
                 @hash_table[out_parser[termo]][1][out_parser[docid].to_i].insert(0,[1]) 
           end
         # Aumenta o contador do termo na colecao
           @hash_table[out_parser[termo]][0] = @hash_table[out_parser[termo]][0] + 1 
        end

      end
      
      @list.close()
      return @hash_table
   end
end
