membros = 10
tarefas = 17
equipe = [0]*membros
y=1
b=0
while(tarefas!=0):	
    for x in range(tarefas, 0, -1):
        equipe[b]= y
        b+=1
        if b == membros and tarefas!=0:
            y+=1
        tarefas-=1
        if b == membros:
            b=0
b=0
for m in equipe:
    b+=1
    print("Membro", b ,"Com", m, "tarefas")