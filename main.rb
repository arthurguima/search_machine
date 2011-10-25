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
  qtd_docs = 0

  #Cria o indice invertido
  puts  "Tabela de indices criada com sucesso!\n" +
        "Tempo gasto para criar o Indice: "       +
        "#{Benchmark.realtime{
            aux = Data_index.new(colecao.to_s);
            @index = aux.init_hash;
            qtd_docs = aux.get_total_docs
            puts qtd_docs
          }
        }\n"

  consulta = scanner("Digite a consulta a ser realizada:")

  while(consulta != "000")
    puts "Busca por \"#{consulta}\" retornou:\n #{Consulta.new(@index,qtd_docs).search(consulta)}\n" 
    consulta = scanner("\nDigite a consulta a ser realizada:")
  end

end

main()
