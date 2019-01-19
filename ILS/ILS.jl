#Nome: José Wesley de Souza Magalhães
#Matrícula: 2267

const n=10 #poucas iterações para a busca local permanecer na mesma bacia
using Distributions


function Ajustar(x)
    if rand(Bool) #boolean que decide se vamos perturbar pra direita ou esquerda
        x=x-rand(Uniform(0,0.25))
    else
        x=x+rand(Uniform(0,0.25))
    end
    x<=-10 ? x=ceil(x): x=x #limitando os valores da solução no intervalo proposto
    x>=10 ? x=floor(x): x=x
    return x
end

function Qualidade(x)
    if x>10.0 || x<-10.0
      return 0
    else
      return x^2
   end
end

function Busca_Local(s0) #hill-climbing para busca local
    sCopy=s0
    for i=1:(n-1)
        R = Ajustar(sCopy)
        if Qualidade(R)>Qualidade(s0)
            s0=R
        end
    end
    return s0
end

function Perturbação(x)
    if rand(Bool) #boolean que decide se vamos perturbar pra direita ou esquerda
        x=x-rand(Uniform(0,2))
    else
        x=x+rand(Uniform(0,2))
    end
    x<=-10 ? x=ceil(x): x=x #limitando os valores da solução no intervalo proposto
    x>=10 ? x=floor(x): x=x
    return x
end

function Critério_de_Aceitação(s,s2)
    if Qualidade(s2)>Qualidade(s)
        return s2
    else
        return s
    end
end

function ILS()
    file=open("/home/jw/Documentos/Ciência da Computação/7º Período/Meta-Heurísticas/Trabalho Prático/resultados_ILS.csv", "a")
    for i=1:30
        s0=rand(Uniform(-10,10))
        print("Solucao inicial ")
        print(s0)
        print("\n")
        writecsv(file,s0)
        s1=Busca_Local(s0)
        j=0
        while (j<10)
            s2=Perturbação(s1)
            s3=Busca_Local(s2)
            s1=Critério_de_Aceitação(s1,s3)
            j=j+1
        end
        print("Solucao final ")
        print(s1)
        print("\n")
        writecsv(file,s1)
        writecsv(file,"\n")
    end
    close(file)
end

ILS()
