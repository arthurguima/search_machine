class Parser_receiver
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
            # indice -> [quantidade, [posição,documento], [posição, documento], ...]
           if @hash_table.has_key?(aux.first) == false 
              @hash_table[aux.first] = [[aux[1].to_i,aux[2].to_i]]
              @hash_table[aux.first].insert(0,1)
              #testes
                #puts "Entrada na tabela #{aux.first} => #{@hash_table[aux.first]}\n"
                #sleep 0.9
           else
              #testes
                #puts "entrou no else #{aux.first} ja inserido 1 vez"
              @hash_table[aux.first].push([aux[1].to_i, aux[2].to_i])
              @hash_table[aux.first][0] = @hash_table[aux.first][0] + 1
              
              #teste
              #puts "Tabela mudou para => #{@hash_table[aux.first]}\n"

           end     
        end
        return @hash_table
    end
end

def main
  a = Time.now
  hash_table = Parser_receiver.new("entrada.txt").init_hash
  
  #testes
    puts "Tabela de indices criada com sucesso!"
    puts "Search \"HANDSOME\" #{hash_table["HANDSOME"]}"
    puts "Search \"VICTORY\" #{hash_table["VICTORY"]}"
    puts "Search \"MACHINE\" #{hash_table["MACHINE"]}"
  b =  Time.now
  puts  "Tempo = #{b - a} segundos."  
end

main()
