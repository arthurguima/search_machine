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

  consulta = scanner("Digite a consulta a ser realizada:")

  while(consulta != "000")
    puts "Busca por \"#{consulta}\" retornou:\n #{Consulta.new(@index).search(consulta)}\n" 
    consulta = scanner("\nDigite a consulta a ser realizada:")
  end

end

main()
