class Consulta

  def initialize (index, qtd_docs)
    @qtd_docs = qtd_docs
    @index = index
  end

  def search (consulta)
     @consulta = consulta.split(' ')
     return sentence_search(@consulta).each{ |doc| p doc } if @consulta[0].start_with?("\"")
     return logical_search(@consulta).each{ |doc| p doc} if @consulta[0].start_with?('#')
     return cosin_search(@consulta)[0,10].each{ |out| p "Doc: #{out[1]} Score: #{out[0]}"}
  end


    private
    def cosin_search(consulta)
        total_documents = @qtd_docs
        score = Hash.new
        resultado = Array.new
        
        #Calcula Score = somatório de tf-idf para cada termo na consulta
        consulta.each do |term|
          get_docs(term).each do |doc| 
            # tf -idf
            # tf = Hash[termo][1]Hash[doc][0] -> frequencia do termo no documento
            # idf = total de documentos/total de documentos que contem o termo
           if @index.has_key?(term)
             tf_minus_idf = @index[term][1][doc][0] 
             #puts tf_minus_idf
             tf_minus_idf = tf_minus_idf[0].to_i * (total_documents/@index[term][1].size.to_f).round(10)
             #puts total_documents/@index[term][1].size.to_f
             #puts tf_minus_idf              

            if score.has_key?(doc)
              score[doc] = score[doc] + tf_minus_idf
            else
              score[doc] = tf_minus_idf
            end
           end
          end
        end

        score = score.to_a #transforma em um array
        score.each{ |x| x.reverse!} #inverte cada array individual para usar o sort
        score = score.sort!.reverse!.to_a #.each{ |a,b| resultado.push(b) }
        
        return score #resultado

    end

    
    #Faz a subconsulta idependente do número de termos
    def simple_logical_search(consulta, oper, sub_result)
      result = Array.new
      term = ""
      term = consulta.pop
      begin
        if (result.size == 0) #quando não recuperou os documentos de nenhum termo
          result = get_docs(normalize(term)) #O resultado são os documentos do primeiro termo
        else
          result = get_logical_docs(result, normalize(term), oper)
        end  
        term = consulta.pop
      end while (term != nil)

      if sub_result.size != 0 #Quando já existe o resultado de uma sub-consulta
       return (result & sub_result) if oper == '#and'  
       return (result | sub_result)
      else
       return result if oper == '#and'  
       return result 
      end 
    end

    #faz a consulta lógica
    def logical_search(consulta)
        sub_consulta = Array.new
        sub_result = Array.new #acumula os resultados intermediários das operações
        termo = ""

       #puts consulta
          termo = consulta.pop
        begin
           normalize(termo)
           if (termo != "#and" && termo != "#or")
              sub_consulta.push(termo) #empilha os termos até encontrar a operação
           else
             #puts sub_consulta 
             sub_result = simple_logical_search(sub_consulta, termo, sub_result) #realiza a operação sobre os termos
           end  
          termo = consulta.pop
        end while termo != nil
        return sub_result
    end

    #Faz a operação 'and' ou 'or' sobre 2 vetores
    def get_logical_docs(term1, term2, oper)
      return (term1 & get_docs(term2)) if oper == '#and'  
      return (term1 | get_docs(term2))
    end

    def get_docs(consulta)
      docs = Array.new
      @index[consulta][1].each_key{ |x| docs.push(x)} if @index.has_key?(consulta)
      return docs
    end

    def normalize (string)
        return string.delete('(').delete(')').delete(',').delete(';')
    end

end
