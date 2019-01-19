#Nome: José Wesley de Souza Magalhães
#Matrícula: 2267

const n=10 #poucas iterações para a busca local permanecer na mesma bacia
using Distributions
file=open("/home/jw/Documentos/Ciência da Computação/7º Período/Meta-Heurísticas/Trabalho Prático/resultados_ILS_rastrigin.csv", "a")

function Limita_Valores(x)
    if x>5.12
        x=5.12
    elseif x<-5.12
        x=-5.12
    else
        x=x
    end
end

function Ajustar(x,b)
    if b #boolean que decide se vamos perturbar pra direita ou esquerda
        x=x-rand(Uniform(0,0.25))
    else
        x=x+rand(Uniform(0,0.25))
    end
    return x
end

function Qualidade(x)
    Limita_Valores(x[1])
    Limita_Valores(x[2])
    sum=0
    for i=1:2
        sum=sum+((x[i]^2)-10*(cos(2*pi*x[i])))
    end
    rastrigin=(10*2)+sum
    return rastrigin
end

function Busca_Local(S) #hill-climbing para busca local
    sCopy=S
    R=[0.0,0.0]
    for i=1:(n)
        b=rand(Bool)
        R[1]=Ajustar(sCopy[1],b)
        R[2]=Ajustar(sCopy[2],b)
        if Qualidade(R)<Qualidade(S)
            S[1]=R[1]
            S[2]=R[2]
            return S
        end
    end
    return S
end

function Perturbação(x,b)
    if b #boolean que decide se vamos perturbar pra direita ou esquerda
        x=x-rand(Uniform(0,2))
    else
        x=x+rand(Uniform(0,2))
    end
    return x
end

function Critério_de_Aceitação(x,y)
    if Qualidade(x)<Qualidade(y)
        return x
    else
        return y
    end
end

function ILS()
    file=open("/home/jw/Documentos/Ciência da Computação/7º Período/Meta-Heurísticas/Trabalho Prático/resultados_ILS_rastrigin.csv", "a")
    for i=1:30
        s0=[rand(Uniform(-5.12,5.12)),rand(Uniform(-5.12,5.12))]
        s1=[6.0,6.0]
        s2=[6.0,6.0]
        s3=[6.0,6.0]
        print("Solucao inicial ")
        print(s0)
        print("\n")
        print("Valor da solucao inicial ")
        print(Qualidade(s0))
        print("\n")
        writecsv(file,Qualidade(s0))
        s1=Busca_Local(s0)
        print("Valor de S1 ")
        println(Qualidade(s1))
        j=0
        while (j<100)
            b=rand(Bool)
            s2[1]=Perturbação(s1[1],b)
            s2[2]=Perturbação(s1[2],b)
            s3=Busca_Local(s2)
            s1=Critério_de_Aceitação(s1,s3)
            j=j+1
        end
        print("Solucao final ")
        print(s1)
        print("\n")
        print("Valor da solucao final ")
        print(Qualidade(s1))
        print("\n")
        writecsv(file,Qualidade(s1))
        writecsv(file,"\n")
    end
    close(file)
end

ILS()
