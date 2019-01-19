#Nome: José Wesley de Souza Magalhães
#Matrícula: 2267

const n=100
using Distributions #pacote necessário para gerar aleatórios entre 0 e 1

function Quality(x)
    sum=0
    for i=1:2
        sum=sum+((x[i]^2)-10*(cos(2*pi*x[i])))
    end
    rastrigin=(10*2)+sum
    return rastrigin
end

function Tweak(x, b)
    if x<=-5.12 || x>=5.12
        return x
    else
        if b #boolean que decide se vamos perturbar pra direita ou esquerda
            x=x-rand(Uniform(0,0.1))
        else
            x=x+rand(Uniform(0,0.1))
        end
        return x
    end
end

function steepestAscentHillClimbing(S)
    j=1
    R=[0.0,0.0]
    W=[0.0,0.0]
    while (j<10)
        sCopy=copy(S)
        b=rand(Bool)
        R[1]=Tweak(sCopy[1],b)
        R[2]=Tweak(sCopy[2],b)
        for i=1:(n-1)
            b=rand(Bool)
            W[1]=Tweak(sCopy[1],b)
            W[2]=Tweak(sCopy[2],b)
            if Quality(W)<Quality(R)
                R=W
            end
        end
        if Quality(R)<Quality(S)
            S=R
        end
        j=j+1
    end
    return S
end

S=[rand(Uniform(-5.12,5.12)),rand(Uniform(-5.12,5.12))]
#S=[0.1,0.1]
println(S)
println(Quality(S))
solucao=steepestAscentHillClimbing(S)
println(solucao)
println(Quality(solucao))
