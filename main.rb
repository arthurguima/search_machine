require 'benchmark'
require_relative 'class/data_index'
require_relative 'class/consulta'

def scanner(msg)
  puts msg
  return gets().to_s.delete("\n")
end

def main()
  
  colecao = scanner("Qual a colecao que sera utilizada?")
  consulta =  nil
  qtd_docs = 0

  #Cria o indice invertido
  puts  "Tabela de indices criada com sucesso!\nTempo gasto para criar o Indice: " +
        "#{Benchmark.realtime{ 
            index_values = Data_index.new(colecao.to_s);
            @index = index_values.init_hash;
            qtd_docs = index_values.get_total_docs }
        }\n"
  realiza_consulta(@index,qtd_docs)  
 end

def realiza_consulta(index,qtd_docs)
  buscador = Consulta.new(@index,qtd_docs)
  begin
    puts "Utilize 000 para sair do programa"
    consulta = scanner("\nDigite a consulta a ser realizada:")
    puts "Busca por \"#{consulta}\" retornou:\n"
    buscador.search(consulta)
  end while(consulta != "000")
end

main()
