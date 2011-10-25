class Consulta

  def initialize (index)
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
          return logical_search(@consulta)
       else
          return cosin_search(@consulta)
        end
      end
  end


    private
    def cosin_search(consulta)
        total_documents = @index.size
        score = Hash.new

        #Calcula Score = somatório de tf-idf para cada termo na consulta
        consulta.each do |term|
          get_docs(x).each do |doc| 
            # tf -idf
            # tf = Hash[termo][1]Hash[doc][0] -> frequencia do termo no documento
            # idf = total de documentos/total de documentos que contem o termo
            tf_minus_idf = (@index[1][term][1][doc][0] - total_documents/@index[1][term][1].size)

            if score.has_key?(doc)
              score[doc] = score[doc] + tf_minus_idf
            else
              score.push(doc,tf_minus_idf) 
            end
          end
        end
        
        return score.to_a

    end

    

    def simple_logical_search(consulta)
        if consulta[0].start_with?("#or")
           get_logical_docs( normalize(consulta[1]), normalize(consulta[2]), '&&')
        else
           if consulta[0].start_with?("#and")
              get_logical_docs( normalize(consulta[1]), normalize(consulta[2]), '||')
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
