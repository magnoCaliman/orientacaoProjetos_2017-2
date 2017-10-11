import numpy as np

#escolher pares de coordenadas finais, iniciais, e um ou mais entre os dois

x = np.array([-43.356438,-43.327115,-43.240164,-43.335049]) #eixo x
y = np.array([-22.861558,-22.933671,-22.908541,-23.005896]) #eixo y
#transforma os pontos em uma curva polinomial de grau 4, não precisa ser 4 mas achei o melhor resultado
z = np.polyfit(x,y,4) 

p = np.poly1d(z)

#ponto inicial x
i =-43.356438
listax = []
listay = []
lista = []

#iteração até o último ponto x e criação da matriz de coordenadas
while i <= -43.335049:
    stx = str(i)
    sty = str(round(p(i),7))
    lista.append(sty+','+stx)
    i+=0.000015
    
