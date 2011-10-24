require 'benchmark'
require_relative 'data_index'
require_relative 'consulta'

def scanner(msg)
  puts msg
  return gets().to_s.delete("\n")
end

def main()
  
  colecao = scanner("Qual a colecao sera utilizada?")
  consulta =  nil

  #Cria o indice invertido
  puts  "Tabela de indices criada com sucesso!\n" +
        "Tempo gasto para criar o Indice: "       +
        "#{Benchmark.realtime{@index = Data_index.new(colecao.to_s).init_hash}}\n"

  while(consulta != "000") 
    consulta = scanner("Digite a consulta a ser realizada:")
    puts "Search #{consulta} = #{@index[consulta]}\n"
  end

end

main()
