require 'benchmark'
require_relative 'data_index'

def scanner(msg)
  puts msg
  return gets().to_s.delete("\n")
end

def main(*args)
  
  colecao = scanner("Qual a colecao sera utilizada?")

  #Cria o indice invertido
  puts "Tabela de indices criada com sucesso!\n" +
  "Tempo gasto para criar o Indice: #{Benchmark.realtime{@index = Data_index.new(colecao.to_s).init_hash}}"

  consulta = scanner("Digite a consulta a ser realizada:")
  
  puts "Search #{consulta} = #{@index[consulta]}"


  #testes
  # puts "Search \"HANDSOME\" #{@index["HANDSOME"]}\n\n"
  # puts "Search \"VICTORY\" #{@index["VICTORY"]}\n\n"
  # puts "Search \"MACHINE\" #{@index["MACHINE"]}\n\n"

end

main()
