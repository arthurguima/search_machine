require 'benchmark'
require_relative 'data_index'

def main(*args)
  
  # Termina execucao se nao receber os argumentos corretos.
  puts "O numero de argumentos esta incorreto. (esperado 1 passado(s)#{ARGV})"  unless (ARGV.length == 1)
  #Cria o indice invertido
  puts "Tempo gasto para criar o Indice: #{Benchmark.realtime{index = Data_index.new(ARGV[0]).init_hash}}"
  puts "Tabela de indices criada com sucesso!"

  #testes
  #  puts "Search \"HANDSOME\" #{hash_table["HANDSOME"]}"
  #  puts "Search \"VICTORY\" #{hash_table["VICTORY"]}"
  #  puts "Search \"MACHINE\" #{hash_table["MACHINE"]}"

end

main()
