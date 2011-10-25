class Consulta

  def initialize (index, qtd_docs)
    @qtd_docs = qtd_docs
    @index = index
  end

  def search (consulta)
     @consulta = consulta.split(' ')
    
     #
     #
     #
     if @consulta[0].start_with?("\"")
       return sentence_search(@consulta)
     else
       if @consulta[0].start_with?('#')
          return simple_logical_search(@consulta)
       else
          return cosin_search(@consulta)
        end
      end
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
             tf_minus_idf = tf_minus_idf[0].to_i * total_documents/@index[term][1].size.to_f

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
        score.sort!.reverse!.each{ |a,b| resultado.push(b) }
        
        return resultado

    end

    

    def simple_logical_search(consulta)
        if consulta[0].start_with?("#or")
           get_logical_docs( normalize(consulta[1]), normalize(consulta[2]), '||')
        else
           if consulta[0].start_with?("#and")
              get_logical_docs( normalize(consulta[1]), normalize(consulta[2]), '&&')
           end
        end
    end

    def get_logical_docs(term1, term2, oper)
      if oper == '&&'  
        return (get_docs(term1) & get_docs(term2))
      else
        return (get_docs(term1) | get_docs(term2))
      end
    end

    def get_docs(consulta)
      docs = Array.new
      if @index.has_key?(consulta)
      @index[consulta][1].each_key{ |x| docs.push(x)} 
      else
        docs.push("Nao foram encontrados resultados compativeis")
      end
      return docs
    end

    def normalize (string)
        return string.delete('(').delete(')').delete(',').delete(';')
    end

end
