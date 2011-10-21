require 'benchmark'
require_relative 'data_index'

def recebe_consulta()

  puts "Digite a consulta a ser realizada:"
  entrada = gets()
  #puts entrada
end


def main(*args)
  
  # Termina execucao se nao receber os argumentos corretos.
  puts "O numero de argumentos esta incorreto. (esperado 1 passado(s)#{ARGV})"  unless (ARGV.length == 1)
  #Cria o indice invertido
  puts "Tempo gasto para criar o Indice: #{Benchmark.realtime{@index = Data_index.new(ARGV[0]).init_hash}}"
  puts "Tabela de indices criada com sucesso!"

  consulta = recebe_consulta();

  #testes
  # puts "Search \"HANDSOME\" #{@index["HANDSOME"]}\n\n"
  # puts "Search \"VICTORY\" #{@index["VICTORY"]}\n\n"
  # puts "Search \"MACHINE\" #{@index["MACHINE"]}\n\n"

end

main()
