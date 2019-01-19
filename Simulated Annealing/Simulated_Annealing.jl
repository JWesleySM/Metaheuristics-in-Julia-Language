#Nome: José Wesley de Souza Magalhães
#Matrícula: 2267

const alpha=0.8
using Distributions
file=open("/home/jw/Documentos/Ciência da Computação/7º Período/Meta-Heurísticas/Trabalho Prático/resultados_SA.csv", "a")

function Perturba(x)
    if rand(Bool) #boolean que decide se vamos perturbar pra direita ou esquerda
        x=x-rand(Uniform(0,0.3))
    else
        x=x+rand(Uniform(0,0.3))
    end
    x<8 ? x=8 : x=x #limitando os valores no intervalo proposto
    x>10 ? x=10 : x=x
    return x
end

function f(i)
    return i[1]*(sin(4*i[1]))+((1.1*i[2])*sin(2*i[2]))
end

function Criterio_de_Metropolis(i, j, ck)
    t1=f(i)-f(j)
    t2=t1/ck
    return e^(t2)
end

function CALCULA_CONTROLE(ck)
    next_ck=ck*alpha
    return next_ck
end

function INICIALIZA(i0, ck, L0)
    k=0
    i=i0
    j=[0.0,0.0]
    while k<10000 
        for l=1:L0
            j[1]=Perturba(i[1])
            j[2]=Perturba(i[2])
            if f(j)<=f(i)
                i[1]=j[1]
                i[2]=j[2]
            elseif Criterio_de_Metropolis(i,j,ck)>rand(Uniform(0,1))
                i[1]=j[1]
                i[2]=j[2]
            end
        end
        ck=CALCULA_CONTROLE(ck)
        k=k+1
    end
    print("Solucao final ")
    println(i)
    print("Valor final ")
    println(f(i))
    writecsv(file,f(i))
    writecsv(file,"\n")
end

function Executa_Algoritmo()
    for z=1:30
            S0=[rand(Uniform(8,10)),rand(Uniform(8,10))]
            print("Solucao inicial  ")
            println(S0)
            print("Valor inicial ")
            println(f(S0))
            writecsv(file,f(S0))
            INICIALIZA(S0, 0.5 ,300)
            print("\n\n")
        end
        close(file)
end

Executa_Algoritmo()
