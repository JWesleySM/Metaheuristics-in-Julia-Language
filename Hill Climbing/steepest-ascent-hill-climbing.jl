#Nome: José Wesley de Souza Magalhães
#Matrícula: 2267

const n=50
using Distributions #pacote necessário para gerar aleatórios entre 0 e 1

function Quality(x)
    return x^2
end

function Tweak(x)
    if rand(Bool) #boolean que decide se vamos perturbar pra direita ou esquerda
        x=x-rand(Uniform(0,0.5))
    else
        x=x+rand(Uniform(0,0.5))
    end
    x<=-10 ? x=ceil(x): x=x #limitando os valores da solução no intervalo proposto
    x>=10 ? x=floor(x): x=x
    return x
end

function steepestAscentHillClimbing(S)
    j=1
    while (j<30)
        sCopy=copy(S)
        R=Tweak(sCopy)
        for i=1:(n-1)
            W=Tweak(sCopy)
            if Quality(W)>Quality(R)
                R=W
            end
        end
        if Quality(R)>Quality(S)
            S=R
        end
        j=j+1
    end
    return S
end

S = rand(Uniform(-10,10))
println(S)
solucao=steepestAscentHillClimbing(S)
println(solucao)
