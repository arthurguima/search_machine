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
          return get_docs(@consulta[0]) #cosin_search(@consulta)
        end
      end
  end


    private
    def manage_search(consulta)
    end

    def logical_search(consulta)
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
