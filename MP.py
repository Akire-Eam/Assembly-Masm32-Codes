def cria_posicao(col, lin):
    """
    cria_posicao: str x str -> posicao
    Esta funcao recebe duas cadeias de carateres correspondentes a
    coluna e a linha de uma posicao e devolve a posicao correspondente.
    """
    col_para_num = {
        'a': 1,
        'b': 2,
        'c': 3
    }
    if type(col) == type(lin) == str:
        if col in col_para_num and lin in ('1','2','3'):
            return [col_para_num[col] + 3*(int(lin)-1)]
    raise ValueError('cria_posicao: argumentos invalidos')


def cria_copia_posicao(pos):
    """
    cria_copia_posicao: posicao -> posicao
    Esta funcao recebe uma posicao e devolve uma copia nova
    da posicao.
    """
    return [pos[0]]


def obter_pos_c(pos):
    """
    obter_pos_c: posicao -> str
    Esta funcao devolve a componente coluna da posicao.
    """     
    if pos[0] in (1, 4, 7):
        return 'a'
    elif pos[0] in (2, 5, 8):
        return 'b'
    elif pos[0] in (3, 6, 9):
        return 'c'


def obter_pos_l(pos):
    """
    obter_pos_l: posicao -> str
    Esta funcao devolve a componente linha da posicao.
    """     
    if pos[0] in (1, 2, 3):
        return '1'
    elif pos[0] in (4, 5, 6):
        return '2'
    elif pos[0] in (7, 8, 9):
        return '3'


def eh_posicao(pos):
    """
    eh_posicao: universal -> booleano
    Esta funcao devolve True caso o seu argumento seja um TAD 
    posicao e False caso contrario.
    """
    return type(pos) == list and type(pos[0]) == int and 0 < pos[0] < 10


def posicoes_iguais(pos1, pos2):
    """
    posicoes_iguais: posicao x posicao -> booleano
    Esta funcao devolve True apenas se pos1 e pos2 sao posicoes
    e sao iguais.
    """
    return eh_posicao(pos1) and eh_posicao(pos2) and pos1 == pos2


def posicao_para_str(pos):
    """
    posicao_para_str: posicao -> str
    Esta funcao devolve a cadeia de caracteres 'cl' que representa o 
    seu argumento, sendo os valores c e l as componentes coluna e linha 
    de pos.
    """
    return obter_pos_c(pos) + obter_pos_l(pos)


def obter_posicoes_adjacentes(pos):
    """
    obter_posicoes_adjacentes: posicao -> tuplo de posicoes
    Esta funcao devolve um tuplo com as posicoes adjacantes a posicao
    de acordo com a ordem de leitura do tabuleiro.
    """
    adj_aux = {
        'a1': ('b1', 'a2', 'b2'),
        'b1': ('a1', 'c1', 'b2'),
        'c1': ('b1', 'b2', 'c2'),
        'a2': ('a1', 'b2', 'a3'),
        'b2': ('a1', 'b1', 'c1', 'a2', 'c2', 'a3', 'b3', 'c3'),
        'c2': ('c1', 'b2', 'c3'),
        'a3': ('a2', 'b2', 'b3'),
        'b3': ('b2', 'a3', 'c3'),
        'c3': ('b2', 'c2', 'b3')
    }
    pos_adj = ()
    for e in adj_aux[posicao_para_str(pos)]:
        pos_adj += cria_posicao(e[0], e[1]),
    return pos_adj


#TAD peca
def cria_peca(jog):
    """
    cria_peca: string -> peca
    Esta funcao recebe uma cadeia de carateres correspondente ao identificador
    de um dos jogadores ('X' ou 'O') ou a uma peca livre (' ') e devolve a
    peca correspondente.
    """
    peca_aux = {
        'X': 1,
        'O': -1,
        ' ': 0
    }
    if type(jog) == str and jog in peca_aux:
        return [peca_aux[jog]]
    raise ValueError('cria_peca: argumento invalido')


def cria_copia_peca(peca):
    """
    cria_copia_peca: peca -> peca
    Esta funcao recebe uma peca e devolve uma copia nova da peca.
    """
    return peca.copy()


def eh_peca(peca):
    """
    eh_peca: universal -> booleano
    Esta funcao devolve True caso o seu argumento seja um TAD peca e False caso
    contrario.
    """
    return type(peca) == list and len(peca) == 1 and \
           type(peca[0]) == int and peca[0] in (-1, 0, 1)


def pecas_iguais(peca1, peca2):
    """
    pecas_iguais: peca x peca -> booleano
    Esta funcao devolve True apensa se peca1 e peca2 sao pecas e sao iguais.
    """
    return eh_peca(peca1) and eh_peca(peca2) and peca1 == peca2


def peca_para_str(peca):
    """
    peca_para_str: peca -> string
    Esta funcao devolve a cadeia de caracteres que representa o jogador dono da
    peca.
    """
    peca_str_aux = {
        1: '[X]',
        -1: '[O]',
        0: '[ ]' 
    }
    return peca_str_aux[peca[0]]


def peca_para_inteiro(peca):
    """
    peca_para_inteiro: peca -> Z
    Esta funcao devolve um inteiro (-1, 1, ou 0), dependendo se a peca e do
    jogador 'X', 'O' ou livre, respetivamente.
    """
    peca_inteiro_aux = {
        '[X]': 1,
        '[O]': -1,
        '[ ]': 0
    }
    return peca_inteiro_aux[peca_para_str(peca)]


#TAD tabuleiro
def cria_tabuleiro():
    """
    cria_tabuleiro: {} -> tabuleiro
    Esta funcao devolve um tabuleiro de jogo do moinho 3x3 sem posicoes ocupadas
    por pecas de jogador.
    """
    p_livre = cria_peca(' ')
    return  [[p_livre, p_livre, p_livre], [p_livre, p_livre, p_livre], \
        [p_livre, p_livre, p_livre]] 


def cria_copia_tabuleiro(tab):
    """
    cria_copia_tabuleiro: tabuleiro -> tabuleiro
    Esta funcao recebe um tabuleiro e devolve uma copia nova do tabuleiro.
    """
    copia_tab = cria_tabuleiro()
    for i in range(3):
        for i2 in range(3):
            if not pecas_iguais(tab[i][i2], copia_tab[i][i2]):
                copia_tab[i][i2] = cria_copia_peca(tab[i][i2])
    return copia_tab
 

def obter_peca(tab, pos):
    """
    obter_peca: tabuleiro x posicao -> peca
    Esta funcao devolve a peca na posicao pos do tabuleiro. Se a posicao nao
    estiver ocupada, devolve uma posicao livre.
    """
    return tab[int(obter_pos_l(pos))-1][coluna_para_num(obter_pos_c(pos))-1]


def obter_vetor(tab, vet):
    """
    obter_vetor: tabuleiro x string -> tuplo de pecas
    Esta funcao devolve todas as pecas da linha ou coluna especificada pelo 
    seu argumento.
    """
    if vet in ('1', '2', '3'):
        return tuple(tab[int(vet)-1])
    else:
        coluna_num = coluna_para_num(vet) - 1
        return (tab[0][coluna_num], tab[1][coluna_num], tab[2][coluna_num])


def coloca_peca(tab, peca, pos):
    """
    coloca_peca: tabuleiro x peca x posicao -> tabuleiro
    Esta funcao modifica destrutivamente o tabuleiro tab colocando a peca peca
    na posicao pos, e devolve o proprio tabuleiro.
    """
    tab[int(obter_pos_l(pos))-1][coluna_para_num(obter_pos_c(pos))-1] = peca
    return tab


def remove_peca(tab, pos):
    """
    remove_peca: tabuleiro x posicao -> tabuleiro
    Esta funcao modifica destrutivamente o tabuleiro tab removendo a peca da
    posicao pos, e devolve o proprio tabuleiro.
    """
    coloca_peca(tab, cria_peca(' '), pos)
    return tab


def move_peca(tab, pos1, pos2):
    """
    move_peca: tabuleiro x posicao x posicao -> tabuleiro
    Esta funcao modifica destrutivamente o tabuleiro tab movendo a peca que se
    encontra na posicao pos1 para a posicao pos2, e devolve o proprio tabuleiro.
    """
    peca_movida = obter_peca(tab, pos1)
    remove_peca(tab, pos1)
    coloca_peca(tab, peca_movida, pos2)
    return tab


def eh_tabuleiro(tab):
    """
    eh_tabuleiro: universal -> booleano
    Esta funcao devolve True caso o seu argumento seja um TAD tabuleiro e False
    caso contrario.
    """
    count_jog1 = count_jog2 = count_vencedor = 0
    if type(tab) != list or len(tab) != 3:
        return False
    for e in tab:
        if type(e) != list or len(e) != 3:
            return False
        for e2 in e:
            if pecas_iguais(e2, cria_peca('O')):
                count_jog1 += 1
            elif pecas_iguais(e2, cria_peca('X')):
                count_jog2 += 1
            elif not pecas_iguais(e2, cria_peca(' ')):
                return False
    if count_jog1 > 3 or count_jog2 > 3:
        return False
    if abs(count_jog1 - count_jog2) > 1:
        return False
    for e in ('abc123'):
        if pecas_iguais(obter_vetor(tab, e)[0], obter_vetor(tab, e)[1]) \
           and pecas_iguais(obter_vetor(tab, e)[2], obter_vetor(tab, e)[1])\
           and not pecas_iguais(obter_vetor(tab, e)[0], cria_peca(' ')): 
            count_vencedor += 1
    return count_vencedor < 2

                
def eh_posicao_livre(tab, pos):
    """
    eh_posicao_livre: tabuleiro x posicao -> booleano
    Esta funcao devolve True apenas no caso da posicao p do tabuleiro 
    corresponder a uma posicao livre.
    """
    return pecas_iguais(obter_peca(tab, pos), cria_peca(' ')) 


def tabuleiros_iguais(tab1, tab2):
    """
    tabuleiros_iguais: tabuleiro x tabuleiro -> booleano
    Esta funcao devolve True apenas se tab1 e tab2 sao tabuleiros e sao iguais.
    """
    if not (eh_tabuleiro(tab1) and eh_tabuleiro(tab2)):
        return False
    for i in range(3):
        for i2 in range(3):
            if not pecas_iguais(tab1[i][i2], tab2[i][i2]):
                return False
    return True


def tabuleiro_para_str(tab):
    """
    tabuleiro_para_str: tabuleiro -> string
    Esta funcao devolve a cadeia de caracteres que representa o tabuleiro.
    """
    count = 0
    string = '   a   b   c\n1 '
    for e in tab:
        for e2 in e:
            if pecas_iguais(e2, cria_peca('X')):
                string += '[X]-'
            elif pecas_iguais(e2, cria_peca('O')):
                string += '[O]-'
            elif pecas_iguais(e2, cria_peca(' ')):
                string += '[ ]-'
        string = string[:len(string) - 1]
        if count == 0:
            string += '\n   | \\ | / |\n2 '
            count += 1
        elif count == 1:
            string += '\n   | / | \\ |\n3 '
            count += 1
    return string


def tuplo_para_tabuleiro(tup):
    """
    tuplo_para_tabuleiro: tuplo -> tabuleiro
    Esta funcao devolve o tabuleiro que e representado pelo tuplo tup com 3 
    tuplos, cada um deles contendo 3 valores inteiros iguais a 1, -1 ou 0.
    """
    tuplo_p_tab_aux = {
        -1: 'O',
        0: ' ',
        1: 'X'
    }
    tab = cria_tabuleiro()
    for i in range(3):
        for i2 in range(3):
            tab[i][i2] = cria_peca(tuplo_p_tab_aux[tup[i][i2]])
    return tab


def obter_ganhador(tab):
    """
    obter_ganhador: tabuleiro -> peca
    Esta funcao devolve uma peca do jogador que tenha as suas 3 pecas em linha 
    na vertical ou na  horizontal no tabuleiro. Se nao existir nenhum ganhador,
    devolve uma peca livre.
    """
    for e in ('abc123'):
        if pecas_iguais(obter_vetor(tab, e)[0], obter_vetor(tab, e)[1]) and \
           pecas_iguais(obter_vetor(tab, e)[1], obter_vetor(tab, e)[2]) and not\
           pecas_iguais(obter_vetor(tab, e)[0], cria_peca(' ')):
           return obter_vetor(tab, e)[0]
    return cria_peca(' ')


def obter_posicoes_livres(tab):
    """
    obter_posicoes_livres: tabuleiro -> tuplo de posicoes
    Esta funcao devolve um tuplo com as posicoes nao ocupadas pelas pecas de 
    qualquer um dos dois jogadores na ordem de leitura do tabuleiro.
    """
    return obter_posicoes_jogador(tab, cria_peca(' '))


def obter_posicoes_jogador(tab, peca):
    """
    obter_posicoes_jogador: tabuleiro x peca -> tuplo de posicoes
    Esta funcao devolve um tuplo com as posicoes ocupadas pelas pecas peca de um
    dos dois jogadores na ordem de leitura do tabuleiro.
    """
    pos_jog = ()
    obter_pos_jog_aux = {
        0: 'a',
        1: 'b',
        2: 'c'
    }
    for e in ('123'):
        for i in range(3):
            if pecas_iguais(obter_vetor(tab, e)[i], peca):
                pos_jog += (cria_posicao(obter_pos_jog_aux[i], e),)
    return pos_jog


#Funcoes adicionais
def obter_movimento_manual(tab, peca):
    """
    obter_movimento_manual: tabuleiro x peca -> tuplo de posicoes
    Esta funcao recebe um tabuleiro e uma peca, e devolve um tuplo que 
    representa uma posicao ou um movimento introduzido manualmente pelo jogador.
    """
    col = ('a', 'b', 'c')
    lin = ('1', '2', '3')
    if len(obter_posicoes_jogador(tab, peca)) < 3:
        pos = input('Turno do jogador. Escolha uma posicao: ')
        if len(pos) == 2 and pos[0] in col and pos[1] in lin:
            if eh_posicao_livre(tab, cria_posicao(pos[0], pos[1])):
                return (cria_posicao(pos[0], pos[1]),)
        raise ValueError('obter_movimento_manual: escolha invalida')
    pos = input('Turno do jogador. Escolha um movimento: ')
    if len(pos) == 4 and pos[0] in col and pos[1] in lin \
       and pos[2] in col and pos[3] in lin:
        pos1 = cria_posicao(pos[0], pos[1])
        pos2 = cria_posicao(pos[2], pos[3])
        if pecas_iguais(obter_peca(tab, pos1), peca)\
           and eh_posicao_livre(tab, pos2) and eh_posicao_adjacente(pos1, pos2):
            return (pos1, pos2)
        mov_poss = 0
        for e in obter_posicoes_jogador(tab, peca):
            for e2 in obter_posicoes_adjacentes(e):
                if eh_posicao_livre(tab, e2):
                    mov_poss += 1
        if mov_poss == 0 and posicoes_iguais(pos1, pos2):
            return (pos1, pos2)
    raise ValueError('obter_movimento_manual: escolha invalida')


def obter_movimento_auto(tab, peca, nivel):
    """
    obter_movimento_auto: tabuleiro x peca x string -> tuplo de posicoes
    Esta funcao recebe um tabuleiro, uma peca e uma string representando o nivel
    de dificuldade do jogo, e devolve um tuplo que representa uma posicao ou um 
    movimento escolhido automaticamente.
    """
    pos_jog = obter_posicoes_jogador(tab, peca)
    res_minimax = 0
    if len(pos_jog) < 3:
        conj_pos = [
                vitoria(tab, peca),
                bloqueio(tab, peca),
                centro(tab),
                canto_vazio(tab),
                lateral_vazia(tab)
            ]
        for e in conj_pos:
            if eh_posicao(e):
                return (e,)
    elif nivel == 'facil':
        for e in pos_jog:
            for e2 in obter_posicoes_adjacentes(e):
                if eh_posicao_livre(tab, e2):
                    return (e, e2)
        return (pos_jog[0], pos_jog[0])
    elif nivel == 'normal':
        res_minimax = minimax(tab, peca, 1, ())
    elif nivel == 'dificil':
        res_minimax = minimax(tab, peca, 5, ())
    if res_minimax != 0:
        if len(res_minimax[1]) > 1:
            return res_minimax[1][0], res_minimax[1][1]
        return (pos_jog[0], pos_jog[0])


def moinho(peca, nivel):
    """
    moinho: string x string -> string
    Esta funcao permite jogar um jogo completo do jogo do moinho contra o
    computador. 
    """
    if (peca == '[X]' or peca == '[O]') and \
       (nivel == 'facil' or nivel == 'normal' or nivel == 'dificil'):
        peca = cria_peca(peca[1])
        p_contraria = peca_contraria(peca)
        print('Bem-vindo ao JOGO DO MOINHO. Nivel de dificuldade '+ nivel +'.')
        tab = cria_tabuleiro()
        jog_atual = 1
        print(tabuleiro_para_str(tab))
        while pecas_iguais(obter_ganhador(tab), cria_peca(' ')):
            if jog_atual == peca_para_inteiro(peca):
                mov = obter_movimento_manual(tab, peca)
                if len(obter_posicoes_jogador(tab, peca)) < 3:
                    tab = coloca_peca(tab, peca, mov[0])
                else: tab = move_peca(tab, mov[0], mov[1])
            else:
                print('Turno do computador (' + nivel + '):')
                mov_auto = obter_movimento_auto(tab, p_contraria, nivel)
                if len(obter_posicoes_jogador(tab, p_contraria)) < 3:
                    tab = coloca_peca(tab, p_contraria, mov_auto[0])
                else: tab = move_peca(tab, mov_auto[0], mov_auto[1])
            print(tabuleiro_para_str(tab))
            jog_atual = -jog_atual
        return peca_para_str(obter_ganhador(tab))
    raise ValueError('moinho: argumentos invalidos')


# funcoes auxiliares extra
def vitoria(tab, peca):
    """
    vitoria: tabuleiro x peca -> posicao
    Esta funcao recebe um tabuleiro e uma peca identificando um jogador. 
    Caso uma vitoria seja possivel, devolve a posicao que garante a vitoria.
    """
    for pos in obter_posicoes_livres(tab):
        novo_tab = coloca_peca(cria_copia_tabuleiro(tab), peca, pos)
        if pecas_iguais(obter_ganhador(novo_tab), peca):
            return pos


def bloqueio(tab, peca):
    """
    bloqueio: tabuleiro x peca -> posicao
    Esta funcao recebe um tabuleiro e uma peca identificando um jogador e caso 
    uma vitoria do adversario seja iminente, devolve a posicao que bloqueia a 
    vitoria.
    """
    return vitoria(tab, peca_contraria(peca))


def centro(tab):
    """
    centro: tabuleiro -> posicao
    Esta funcao recebe um tabuleiro e caso a posicao central esteja vazia 
    devolve a mesma.
    """
    if eh_posicao_livre(tab, cria_posicao('b', '2')):
        return cria_posicao('b', '2')


def canto_vazio(tab):
    """
    canto_vazio: tabuleiro -> posicao
    Esta funcao recebe um tabuleiro e caso um dos cantos esteja vazio devolve 
    o mesmo.
    """
    cantos = [cria_posicao('a', '1'), cria_posicao('c', '1'), \
             cria_posicao('a', '3'), cria_posicao('c', '3')]
    for e in cantos:
        if eh_posicao_livre(tab, e):
            return e


def lateral_vazia(tab):
    """
    canto_vazio: tabuleiro -> posicao
    Esta funcao recebe um tabuleiro e caso uma das laterais esteja vazia 
    devolve a mesma.
    """
    laterais = [cria_posicao('b', '1'), cria_posicao('a', '2'), \
             cria_posicao('c', '2'), cria_posicao('b', '3')]
    for e in laterais:
        if eh_posicao_livre(tab, e):
            return e


def minimax(tab, peca, prof, seq_mov):
    """
    minimax: tabuleiro, peca, profundidade, seq. movimentos -> tuplo de valores
    Esta funcao explora todos os movimentos legais do jogador que utiliza a peca
    peca ate uma profundidade definida e devolve o movimento que mais favoreca 
    este jogador.
    """
    if not pecas_iguais(obter_ganhador(tab), cria_peca(' ')) or prof == 0:
        return (peca_para_inteiro(obter_ganhador(tab)), seq_mov)
    else:
        melhor_res = peca_para_inteiro(peca_contraria(peca))
        melhor_seq_mov = ()
        for pos in obter_posicoes_jogador(tab, peca):
            for pos_adj in obter_posicoes_adjacentes(pos):
                if eh_posicao_livre(tab, pos_adj):
                    novo_t = move_peca(cria_copia_tabuleiro(tab), pos, pos_adj)
                    novo_res, nova_seq_mov = minimax(novo_t, \
                    peca_contraria(peca), prof-1, seq_mov + (pos, pos_adj))
                    if melhor_seq_mov == () or \
                       (pecas_iguais(peca, cria_peca('X')) and 
                       novo_res > melhor_res) or \
                       (pecas_iguais(peca, cria_peca('O')) and 
                       novo_res < melhor_res):
                        melhor_res, melhor_seq_mov = novo_res, nova_seq_mov
        return melhor_res, melhor_seq_mov


def peca_contraria(peca):
    """
    peca_contraria: peca -> peca
    Esta funcao recebe a peca de um jogador e devolve a peca do jogador oposto.
    """
    peca_contraria = {
        '[X]': 'O',
        '[O]': 'X'
    }
    return cria_peca(peca_contraria[peca_para_str(peca)])


def coluna_para_num(col):
    """
    coluna_para_num: string -> inteiro
    Esta funcao recebe uma string que representa uma das tres colunas do 
    tabuleiro e devolve o numero da coluna, contando da esquerda para a direita.
    """
    col_num = {
        'a': 1,
        'b': 2,
        'c': 3
    }
    return col_num[col]


def eh_posicao_adjacente(pos1, pos2):
    """
    eh_posicao_adjacente: posicao x posicao -> booleano
    Esta funcao recebe duas posicoes e devolve True se forem posicoes adjacentes
    e False caso contrario.
    """
    for e in obter_posicoes_adjacentes(pos1):
        if posicoes_iguais(pos2, e):
            return True
    return False