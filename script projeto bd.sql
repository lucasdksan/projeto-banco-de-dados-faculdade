/* Criação do banco de dados(BD) LIFOO e alguns testes*/
SHOW DATABASES;
CREATE DATABASE LIFOO;
USE LIFOO;
SHOW TABLES;

/*  =========================================== CRIAÇÃO DAS TABELAS =========================================== */

CREATE TABLE IF NOT EXISTS USUARIO(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL, /* varchar é uma string de 50 caracteres */
    nome VARCHAR(50) NOT NULL,
    senha VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS ALIMENTO(
    ID_alimento INT PRIMARY KEY AUTO_INCREMENT,
    nome_alimento VARCHAR(50) NOT NULL,
    nutrientes VARCHAR(50),
    calorias VARCHAR(50),
    gluten CHAR NOT NULL CHECK(gluten = 'S' OR gluten = 'N') /* S de sim e N de não */
);

CREATE TABLE IF NOT EXISTS RECEITA(
    ID_receita INT PRIMARY KEY AUTO_INCREMENT,
    nome_receita VARCHAR(50) NOT NULL,
    modo_preparo VARCHAR(700) NOT NULL
    /*imagem_receita ,    TIPO DE DADO DE IMAGEM?*/
);

CREATE TABLE IF NOT EXISTS REUTILIZACAO(
    ID_reutiliza INT,
    ID_alim INT,
    nome_reutilizacao VARCHAR(50) NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    FOREIGN KEY (ID_alim) REFERENCES ALIMENTO(ID_alimento), /* Chave estrangeira */
    PRIMARY KEY(ID_reutiliza, ID_alim) /* Chave composta */
);

CREATE TABLE IF NOT EXISTS PESQUISA_REC(
    ID_user_rec INT,
    ID_rec INT,
    FOREIGN KEY (ID_user_rec) REFERENCES USUARIO(ID),
    FOREIGN KEY (ID_rec) REFERENCES RECEITA(ID_receita),
    PRIMARY KEY(ID_user_rec, ID_rec)
);

CREATE TABLE IF NOT EXISTS PESQUISA_REU(
    ID_user_reu INT,
    ID_reu INT,
    FOREIGN KEY (ID_user_reu) REFERENCES USUARIO(ID),
    FOREIGN KEY (ID_reu) REFERENCES REUTILIZACAO(ID_reutiliza),
    PRIMARY KEY(ID_user_reu, ID_reu)
);

CREATE TABLE IF NOT EXISTS ATUA_EM(
    ID_al INT,
    ID_rec_atua INT,
    FOREIGN KEY (ID_al) REFERENCES ALIMENTO(ID_alimento),
    FOREIGN KEY (ID_rec_atua) REFERENCES RECEITA(ID_receita),
    PRIMARY KEY (ID_al, ID_rec_atua)
);

CREATE TABLE IF NOT EXISTS RECEITA_INGREDIENTE(
    R_ID INT,
    ingrediente VARCHAR(50),
    FOREIGN KEY (R_ID) REFERENCES RECEITA(ID_receita),
    PRIMARY KEY(R_ID, ingrediente)
);

/*  ======================================================================================== */


/*  =========================================== INSERÇÃO DOS DADOS =========================================== */


/*  ======================== Inserção de usuários ======================== */
INSERT INTO USUARIO(ID, email, nome, senha)
VALUES(1, 'luciadasilva@gmail.com', 'Lucia da Silva', 'ilovejesus123');

INSERT INTO USUARIO(ID, email, nome, senha)
VALUES(2, 'marcelogourmet@gmail.com', 'Marcelo Cristian', 'bmkc3312');

INSERT INTO USUARIO(ID, email, nome, senha)
VALUES(3, 'joaninha123@gmail.com', 'Joana Pereira', 'zkxfs49a6');

/*  ======================== Inserção de alimentos ======================== */
INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(1, 'Pão francês', 'Proteina e Gordura', '265 calorias a cada 100g', 'S');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(2, 'Banana', 'Carboidrato e Proteina', '89 calorias a cada 100g', 'N');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(3, 'Laranja', 'Carboidrato e Proteina', '47 calorias a cada 100g', 'N');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(4, 'Arroz', 'Carboidrato e Proteina', '130 calorias a cada 100g', 'N');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(5, 'Milho', 'Carboidrato e Proteina', '370 calorias a cada 100g', 'N');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(6, 'Hambúrguer', 'Gordura e Carboidrato', '295 calorias a cada 100g', 'S');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(7, 'Salsicha', 'Gordura e Proteina', '346 calorias a cada 100g', 'S');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(8, 'Ovo', 'Gordura e Proteina', '155 calorias a cada 100g', 'N');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(9, 'Cuscuz', 'Carboidrato e Proteina', '112 calorias a cada 100g', 'S');

INSERT INTO ALIMENTO(ID_alimento, nome_alimento, nutrientes, calorias, gluten)
VALUES(10, 'Leite', 'Gordura e Carboidrato', '60 kilocalorias a cada 100g', 'N');


/*  ======================== Inserção de receitas ======================== */
INSERT INTO RECEITA(ID_receita, nome_receita, modo_preparo)
VALUES(1, 'Brigadeiro de casca de banana',
    '
    Bata todos os ingredientes no liquidificador. Leve a mistura ao fogo baixo 
    para ferver, mexendo sempre até começar a soltar do fundo. Desligue e deixe 
    esfriar. Depois, você pode enrolar e passar no granulado ou servir em copinhos.
    *A receita é quase a mesma do brigadeiro comum. Mas o acréscimo da casca de 
    banana adiciona nutrientes ao doce, como o potássio (concentrado em maior 
    proporção na casca do que na polpa da fruta).');
/*
UPDATE RECEITA
    SET modo_preparo = '
    Bata todos os ingredientes no liquidificador. Leve a mistura ao fogo baixo 
    para ferver, mexendo sempre até começar a soltar do fundo. Desligue e deixe 
    esfriar. Depois, você pode enrolar e passar no granulado ou servir em copinhos.
    *A receita é quase a mesma do brigadeiro comum. Mas o acréscimo da casca de 
    banana adiciona nutrientes ao doce, como o potássio (concentrado em maior 
    proporção na casca do que na polpa da fruta).'
    WHERE ID_receita=1;
*/
    
INSERT INTO RECEITA(ID_receita, nome_receita, modo_preparo)
VALUES(2, 'Doce de casca de laranja',
    '
    Corte as cascas em tirinhas de meio centímetro e deixe de molho, trocando a água
    a cada duas horas, até perderem o amargo. Derreta o açúcar no fogo e acrescente
    as cascas já enxutas. Quando começar a engrossar a calda, acrescente o farelo 
    de trigo. Mexa até açucarar. Deixe esfriar e guarde em latas.');

INSERT INTO RECEITA(ID_receita, nome_receita, modo_preparo)
VALUES(3, 'Bruschetta',
    '
    Em um recipiente, junte os tomates e o alho ao azeite, misturando bem. 
    Adicione o manjericão, o orégano e o sal e mexa novamente. 
    Regue as fatias de pão com azeite a gosto, coloque a mistura de tomate e o queijo
    e leve-as ao forno até dourarem. Finalize com folhinhas de manjericão.');

INSERT INTO RECEITA(ID_receita, nome_receita, modo_preparo)
VALUES(4, 'Petisquinho de bagaço de milho verde',
    '
    Em um recipiente misture o bagaço de milho, com a farinha de trigo, o ovo, 
    a cebola ralada, o sal e o fermento. Faça uma massa. Coloque uns dois dedos 
    de óleo em uma panela pequena. Aqueça o óleo e frite colheradas. Não deixe o óleo 
    muito quente para que o bolinho doure por fora, mas que também cozinhe por dentro. 
    O melhor é fazer bolinhos pequenos fica mais gostoso e crocante (eu usei uma colher 
    de sobremesa para fazer os bolinhos). Assim que os bolinhas dourar, retire do óleo 
    e coloque sobre papel absorvente para tirar o excesso de óleo. Sirva quente.');

INSERT INTO RECEITA(ID_receita, nome_receita, modo_preparo)
VALUES(5, 'Hambúrguer a Parmegiana',
    '
    Aqueça o molho de tomate com a água por cerca de 5 minutos, junte o orégano e 
    retire do fogo. Espalhe o azeite em um refratário e coloque os hambúrgueres por cima.
    Leve ao forno quente por cerca de 10 minutos.
    Vire-os e deixe por mais 5 minutos.
    Espalhe o molho sobre os hambúrgeres, cubra com as fatias de mussarela e o queijo ralado.
    Leve ao forno por mais 15 minutos, ou até gratinar.');

INSERT INTO RECEITA(ID_receita, nome_receita, modo_preparo)
VALUES(6, 'Strogonoff de Salsicha',
    '
    1. Coloque em uma panela as 2 colheres (sopa) de margarina, refogue com a cebola, pimentão,
     sal, a salsinha e a pimenta.

    2. Coloque a salsicha e o molho de tomate.

    3. Ferva por 10 a 15 minutos.

    4. Tire do fogo, acrescente os ovos um a um e coloque o creme de leite.

    5. Mexa bem, fora do fogo e sirva com arroz branco e batata palha.');


/*  ======================== Inserção de reutilização ======================== */
INSERT INTO REUTILIZACAO(ID_reutiliza, ID_alim, nome_reutilizacao, descricao)
VALUES(1, 8, 'Limpe potes e panos', 
    '
    Alguns pedaços de cascas de ovo trituradas com sabão ajudam na limpeza de
    utensílios domésticos. Elas quebram as partículas do alimento e ajudam a remover a gordura.');

INSERT INTO REUTILIZACAO(ID_reutiliza, ID_alim, nome_reutilizacao, descricao)
VALUES(2, 8, 'Fertilize o solo', 
    '
    Rica em cálcio, magnésio e potássio, a casca de ovo
    pode evitar a podridão apical (problema comum em tomates e outros vegetais de frutificação). 
    Para isso, coloque as cascas para secar na sombra e depois faça uma farinha para fertilizar 
    a terra. É importante não secá-las ao sol, pois, assim, perdem nitrogênio. Também não guarde-as 
    para secar posteriormente – a decomposição das partes orgânicas provoca mau cheiro e atrai 
    animais indesejados, como moscas.');

INSERT INTO REUTILIZACAO(ID_reutiliza, ID_alim, nome_reutilizacao, descricao)
VALUES(3, 3, 'Limpador Multiuso', 
    '
    Misture em um recipiente, algumas cascas de laranja com uma quantidade de vinagre branco 
    suficiente para cobri-las. Deixe a mistura descansar na geladeira por quatro semanas e 
    agite-a pelo menos duas vezes por semana. Transfira o conteúdo para um frasco de spray e 
    use para limpar superfícies, pisos e janelas.');

INSERT INTO REUTILIZACAO(ID_reutiliza, ID_alim, nome_reutilizacao, descricao)
VALUES(4, 3, 'Esponja', 
    '
    Cascas de laranja podem virar uma esponja natural. Funciona tão bem como uma esponja 
    comum e ainda deixa que cheiro agradável e levemente cítrico. Nesse caso, a casca não 
    deve estar seca.');

/*  ======================== Inserção de ingredientes das receitas ======================== */

/*  ======================== Ingredientes da receita 1 ======================== */
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(1, '- Cascas de 2 bananas, bem lavadas e picadas');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(1, '- 1 lata de leite condensado');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(1, '- 4 colheres (sopa) de chocolate em pó');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(1, '- 1 colher (sopa) de margarina ou manteiga');

/*  ======================== Ingredientes da receita 2 ======================== */
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(2, '- Cascas de 2 laranjas');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(2, '- 2 colheres (sopa) de açúcar');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(2, '- 2 colheres (sopa) de farelo de trigo torrado');

/*  ======================== Ingredientes da receita 3 ======================== */
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(3, '- Fatias de pão italiano, francês ou baguete');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(3, '- 2 tomates bem maduros cortados em cubinhos');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(3, '- 1/2 xicara de azeite');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(3, '- 1 dente de alho picado');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(3, '- 1 colher de sopa de orégano');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(3, '- Folhas de manjericão');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(3, '- Sal a gosto');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(3, '- Fatias de mussarela de búfala');

/*  ======================== Ingredientes da receita 4 ======================== */
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(4, '- 1 xícara (de chá) de bagaço de milho verde');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(4, '- 1 colher (de sopa) de farinha de trigo');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(4, '- 1 ovo');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(4, '- 1 colher (de chá) de cebola ralada');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(4, '- 1/2 colher (de café) de sal');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(4, '- 1 colher (de chá) de fermento em pó (o de bolo)');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(4, '- Óleo para fritar');

/*  ======================== Ingredientes da receita 5 ======================== */
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(5, '- 1 lata de molho de tomate temperado em pedaços');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(5, '- 1 colher (chá) de orégano');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(5, '- 1 colher (sopa) de azeite');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(5, '- 6 hambúrgueres');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(5, '- 6 fatias de mussarela');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(5, '- 3 colheres de queijo ralado');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(5, '- 1/2 colher de sal');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(5, '- 1/2 xícara (chá) de água');

/*  ======================== Ingredientes da receita 6 ======================== */
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- 1 lata de molho de tomate');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- 8 salsichas');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- 1 pimentão verde');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- 4 ovos');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- 1 lata de creme de leite');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- 2 colheres de sopa de margarina');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- 1 cebola');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- Salsinha a gosto');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- Sal a gosto');
INSERT INTO RECEITA_INGREDIENTE(R_ID, ingrediente)
VALUES(6, '- Pimenta-do-Reino Preta a gosto');
 

/*  ======================================================================================== */


/* 

SELECT ID_receita, nome_receita FROM RECEITA;

*/