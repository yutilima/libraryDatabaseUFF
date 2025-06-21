drop schema if exists biblio cascade;

create SCHEMA biblio;
CREATE TABLE biblio.Autor (
    pk SERIAL,
    nome TEXT NOT NULL,
    constraint pk_autor PRIMARY KEY(pk)
);
CREATE TABLE biblio.Genero (
    pk SERIAL,
    nome TEXT NOT NULL,
    constraint pk_genero PRIMARY KEY(pk)
);
CREATE TABLE biblio.Cliente (
    pk SERIAL,
    nome TEXT NOT NULL,
    constraint pk_cliente PRIMARY KEY(pk)
);
CREATE TABLE biblio.Livro(
    pk SERIAL,
    isbn TEXT not null,
    titulo TEXT NOT NULL,
    num_paginas INTEGER NOT NULL,
    pk_genero int,
    constraint pk_livro PRIMARY KEY(pk),
    constraint fk_genero FOREIGN KEY(pk_genero) REFERENCES biblio.Genero(pk)
);
create table biblio.LivroAutor(
    pk_livro int,
    pk_autor int,
    constraint pk_livro_autor PRIMARY KEY(pk_livro, pk_autor),
    constraint fk_livro FOREIGN KEY(pk_livro) REFERENCES biblio.Livro(pk),
    constraint fk_autor FOREIGN KEY(pk_autor) REFERENCES biblio.Autor(pk)
);
CREATE TABLE biblio.Biblioteca (
    pk SERIAL,
    cidade_estado TEXT NOT NULL,
    constraint pk_biblioteca PRIMARY KEY(pk)
);
CREATE TABLE biblio.CopiaLivro (
    pk SERIAL,
    pk_livro int,
    pk_biblioteca int,
    constraint pk_copia_livro PRIMARY KEY(pk),
    constraint fk_livro FOREIGN KEY(pk_livro) REFERENCES biblio.Livro(pk),
    constraint fk_biblioteca FOREIGN KEY(pk_biblioteca) REFERENCES biblio.Biblioteca(pk)
);
CREATE TABLE biblio.Emprestimo (
    pk SERIAL,
    pk_cliente INTEGER ,
    pk_copia_livro INTEGER,
    data_retirada DATE NOT NULL,
    data_entrega DATE,
    data_prevista DATE not null,
    constraint pk_emprestimo PRIMARY KEY(pk),
    constraint fk_cliente FOREIGN KEY(pk_cliente) REFERENCES biblio.Cliente(pk),
    constraint fk_copia_livro FOREIGN KEY(pk_copia_livro) REFERENCES biblio.CopiaLivro(pk)
);
CREATE TABLE biblio.AgendamentoMovimentacao (
    pk SERIAL,
    pk_origem int,
    pk_destino int,
    data_saida DATE,
    data_entrega DATE,
    data_prevista DATE,
    constraint pk_agendamento_movimentacao PRIMARY KEY(pk),
    constraint fk_origem FOREIGN KEY(pk_origem) REFERENCES biblio.Biblioteca(pk),
    constraint fk_destino FOREIGN KEY(pk_destino) REFERENCES biblio.Biblioteca(pk)
);
CREATE TABLE biblio.CopiaMovimentacao (
    pk_copia_livro int,
    pk_movimentacao int,
    constraint pk_copia_movimentacao PRIMARY KEY(pk_copia_livro, pk_movimentacao),
    constraint fk_copia_livro FOREIGN KEY(pk_copia_livro) REFERENCES biblio.CopiaLivro(pk),
    constraint fk_movimentacao FOREIGN KEY(pk_movimentacao) REFERENCES biblio.AgendamentoMovimentacao(pk)
);

------------------------ Inserindo valores de teste ------------------------
-- Inserir Autores
INSERT INTO biblio.Autor (nome) VALUES 
('J.K. Rowling'),
('George R.R. Martin'),
('J.R.R. Tolkien'),
('Agatha Christie');

-- Inserir Gêneros
INSERT INTO biblio.Genero (nome) VALUES 
('Fantasia'),
('Mistério'),
('Aventura'),
('Ficção Científica');

-- Inserir Clientes
INSERT INTO biblio.Cliente (nome) VALUES 
('Ana Silva'),
('Bruno Costa'),
('Carlos Souza');

-- Inserir Bibliotecas
INSERT INTO biblio.Biblioteca (cidade_estado) VALUES 
('São Paulo - SP'),
('Rio de Janeiro - RJ'),
('Curitiba - PR');

-- Inserir Livros
INSERT INTO biblio.Livro (isbn, titulo, num_paginas, pk_genero) VALUES 
('9780747532743', 'Harry Potter e a Pedra Filosofal', 223, 1),
('9780553103540', 'A Guerra dos Tronos', 694, 1),
('9780261103573', 'O Senhor dos Anéis', 1178, 3),
('9780007119356', 'Assassinato no Expresso do Oriente', 256, 2);

-- Inserir LivroAutor
INSERT INTO biblio.LivroAutor (pk_livro, pk_autor) VALUES 
(1, 1), -- Harry Potter -> Rowling
(2, 2), -- Guerra dos Tronos -> Martin
(3, 3), -- Senhor dos Anéis -> Tolkien
(4, 4); -- Expresso Oriente -> Christie

-- Inserir Cópias de Livros nas Bibliotecas
INSERT INTO biblio.CopiaLivro (pk_livro, pk_biblioteca) VALUES 
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(1, 2),
(2, 3);

-- Inserir Empréstimos
INSERT INTO biblio.Emprestimo (pk_cliente, pk_copia_livro, data_retirada, data_prevista, data_entrega) VALUES 
(1, 1, '2025-05-01', '2025-05-15', '2025-05-10'),
(2, 2, '2025-05-03', '2025-05-17', NULL),
(3, 3, '2025-04-25', '2025-05-09', '2025-05-08');

-- Inserir Agendamento de Movimentações
INSERT INTO biblio.AgendamentoMovimentacao (pk_origem, pk_destino, data_saida, data_prevista, data_entrega) VALUES 
(1, 2, '2025-05-01', '2025-05-03', '2025-05-02'),
(3, 1, '2025-05-05', '2025-05-08', NULL);

-- Inserir Cópias nas Movimentações
INSERT INTO biblio.CopiaMovimentacao (pk_copia_livro, pk_movimentacao) VALUES 
(5, 1), -- Cópia do livro 1 de SP para RJ
(6, 2); -- Cópia do livro 2 de Curitiba para SP
-- Mais Autores
INSERT INTO biblio.Autor (nome) VALUES 
('Clarice Lispector'),
('Machado de Assis'),
('Cecília Meireles'),
('Monteiro Lobato'),
('Paulo Coelho');

-- Mais Gêneros
INSERT INTO biblio.Genero (nome) VALUES 
('Drama'),
('Romance'),
('Infantil'),
('História'),
('Biografia');

-- Mais Clientes
INSERT INTO biblio.Cliente (nome) VALUES 
('Eduarda Martins'),
('Fernanda Lima'),
('Gustavo Andrade'),
('Helena Rocha'),
('Igor Vasconcelos');

-- Mais Bibliotecas
INSERT INTO biblio.Biblioteca (cidade_estado) VALUES 
('Belo Horizonte - MG'),
('Porto Alegre - RS');

-- Mais Livros
INSERT INTO biblio.Livro (isbn, titulo, num_paginas, pk_genero) VALUES 
('9788535914849', 'O Alquimista', 208, 6),
('9788595081512', 'Dom Casmurro', 256, 7),
('9788535902778', 'A Hora da Estrela', 87, 6),
('9788516075651', 'Reinações de Narizinho', 240, 8),
('9788525058524', 'Memórias de um Sargento de Milícias', 192, 7);

-- LivroAutor extra
INSERT INTO biblio.LivroAutor (pk_livro, pk_autor) VALUES 
(5, 5), -- O Alquimista -> Paulo Coelho
(6, 6), -- Dom Casmurro -> Machado de Assis
(7, 1), -- A Hora da Estrela -> Clarice Lispector
(8, 8), -- Reinações -> Monteiro Lobato
(9, 6); -- Memórias de um Sargento -> Machado de Assis

-- Cópias adicionais
INSERT INTO biblio.CopiaLivro (pk_livro, pk_biblioteca) VALUES 
(5, 4),
(6, 5),
(7, 5),
(8, 4),
(9, 2);

-- Movimentações adicionais
INSERT INTO biblio.AgendamentoMovimentacao (pk_origem, pk_destino, data_saida, data_prevista, data_entrega, entregue) VALUES 
(2, 5, '2025-05-01', '2025-05-03', '2025-05-02', TRUE),
(4, 3, '2025-05-06', '2025-05-08', NULL, FALSE);
-- Mais livros adicionados com diferentes gêneros
INSERT INTO biblio.Livro (isbn, titulo, num_paginas, pk_genero) VALUES 
('9780143127741', '1984', 328, 4),  -- Ficção Científica
('9780061122415', 'O Sol é para Todos', 336, 5),  -- Biografia
('9788520922592', 'Quincas Borba', 220, 7), -- Romance
('9788580442314', 'Os Miseráveis', 1463, 6), -- Drama
('9788574067309', 'O Pequeno Príncipe', 96, 9); -- Infantil

-- Associando autores aos novos livros
INSERT INTO biblio.Autor (nome) VALUES 
('George Orwell'),
('Harper Lee'),
('Victor Hugo');

-- Observar o último autor inserido já existente: Machado de Assis = (id: 6, usado em Quincas Borba)
-- Supondo que os novos IDs sejam consecutivos
INSERT INTO biblio.LivroAutor (pk_livro, pk_autor) VALUES 
(10, 10), -- 1984 -> Orwell
(11, 11), -- O Sol é para Todos -> Harper Lee
(12, 6),  -- Quincas Borba -> Machado
(13, 12), -- Os Miseráveis -> Victor Hugo
(14, 8);  -- O Pequeno Príncipe -> Saint-Exupéry (associado como autor fictício 8)

-- Adicionando bibliotecas em outras cidades
INSERT INTO biblio.Biblioteca (cidade_estado) VALUES 
('Fortaleza - CE'),
('Manaus - AM');

-- Inserindo cópias dos livros recém-adicionados em diferentes bibliotecas
INSERT INTO biblio.CopiaLivro (pk_livro, pk_biblioteca) VALUES 
(10, 6), -- 1984 em Porto Alegre
(11, 4), -- O Sol é para Todos em BH
(12, 1), -- Quincas Borba em SP
(13, 2), -- Os Miseráveis em Fortaleza
(14, 1); -- O Pequeno Príncipe em Manaus

-- Clientes adicionais
INSERT INTO biblio.Cliente (nome) VALUES 
('Joana Prado'),
('Luiz Felipe'),
('Mariana Ribeiro'),
('Nicolas Torres'),
('Patrícia Almeida');

-- Empréstimos de livros recém-adicionados
INSERT INTO biblio.Emprestimo (pk_cliente, pk_copia_livro, data_retirada, data_prevista, data_entrega) VALUES 
(4, 7, '2025-05-10', '2025-05-24', NULL), -- Carlos empresta 1984
(5, 8, '2025-05-12', '2025-05-26', '2025-05-22'), -- Eduarda empresta O Sol é para Todos
(6, 9, '2025-05-08', '2025-05-22', NULL), -- Fernanda empresta Quincas Borba
(7, 10, '2025-05-15', '2025-05-29', NULL), -- Gustavo empresta Os Miseráveis
(8, 11, '2025-05-14', '2025-05-28', NULL); -- Helena empresta O Pequeno Príncipe

-- Movimentações das novas cópias
INSERT INTO biblio.AgendamentoMovimentacao (pk_origem, pk_destino, data_saida, data_prevista, data_entrega, entregue) VALUES 
(6, 3, '2025-05-10', '2025-05-12', '2025-05-12', TRUE),
(7, 1, '2025-05-14', '2025-05-16', NULL, FALSE);

    -- Relacionando cópias com movimentações
INSERT INTO biblio.CopiaMovimentacao (pk_copia_livro, pk_movimentacao) VALUES 
(10, 3), -- 1984 (PA → Curitiba)
(11, 4); -- O Sol é para Todos (Fortaleza → SP)

INSERT INTO biblio.Emprestimo (pk_cliente, pk_copia_livro, data_retirada, data_prevista, data_entrega) VALUES
(1, 1, '2025-05-04', '2025-05-18', NULL),
(2, 2, '2025-05-06', '2025-05-20', NULL),
(3, 3, '2025-05-08', '2025-05-22', '2025-05-21'),
(4, 4, '2025-05-10', '2025-05-24', NULL),
(5, 5, '2025-05-11', '2025-05-25', '2025-05-20'),
(6, 6, '2025-05-12', '2025-05-26', NULL),
(7, 7, '2025-05-13', '2025-05-27', NULL),
(8, 8, '2025-05-14', '2025-05-28', NULL),
(9, 9, '2025-05-15', '2025-05-29', NULL),
(10, 10, '2025-05-16', '2025-05-30', NULL),
(11, 11, '2025-05-17', '2025-05-31', NULL),
(12, 12, '2025-05-18', '2025-06-01', NULL),
(13, 13, '2025-05-19', '2025-06-02', NULL),
(1, 2, '2025-05-05', '2025-05-19', '2025-05-18'),
(2, 3, '2025-05-06', '2025-05-20', NULL),
(3, 4, '2025-05-07', '2025-05-21', '2025-05-17'),
(4, 5, '2025-05-08', '2025-05-22', NULL),
(5, 6, '2025-05-09', '2025-05-23', NULL),
(6, 7, '2025-05-10', '2025-05-24', NULL),
(7, 8, '2025-05-11', '2025-05-25', NULL),
(8, 9, '2025-05-12', '2025-05-26', NULL),
(9, 10, '2025-05-13', '2025-05-27', NULL),
(10, 11, '2025-05-14', '2025-05-28', NULL),
(11, 12, '2025-05-15', '2025-05-29', NULL),
(12, 13, '2025-05-16', '2025-05-30', NULL),
(13, 1, '2025-05-17', '2025-05-31', NULL),
(1, 3, '2025-05-04', '2025-05-18', '2025-05-14'),
(2, 4, '2025-05-05', '2025-05-19', '2025-05-18'),
(3, 5, '2025-05-06', '2025-05-20', NULL),
(4, 6, '2025-05-07', '2025-05-21', NULL),
(5, 7, '2025-05-08', '2025-05-22', NULL),
(6, 8, '2025-05-09', '2025-05-23', NULL),
(7, 9, '2025-05-10', '2025-05-24', NULL),
(8, 10, '2025-05-11', '2025-05-25', NULL),
(9, 11, '2025-05-12', '2025-05-26', NULL),
(10, 12, '2025-05-13', '2025-05-27', NULL),
(11, 13, '2025-05-14', '2025-05-28', NULL),
(12, 1, '2025-05-15', '2025-05-29', NULL),
(13, 2, '2025-05-16', '2025-05-30', NULL),
(1, 4, '2025-05-03', '2025-05-17', '2025-05-10'),
(2, 5, '2025-05-04', '2025-05-18', NULL),
(3, 6, '2025-05-05', '2025-05-19', NULL),
(4, 7, '2025-05-06', '2025-05-20', NULL),
(5, 8, '2025-05-07', '2025-05-21', NULL),
(6, 9, '2025-05-08', '2025-05-22', NULL),
(7, 10, '2025-05-09', '2025-05-23', NULL),
(8, 11, '2025-05-10', '2025-05-24', NULL),
(9, 12, '2025-05-11', '2025-05-25', NULL),
(10, 13, '2025-05-12', '2025-05-26', NULL);


------------------------ Questão nº1 ------------------------
-- Faça a previsão da entrega de um livro de acordo com o 
-- histórico de tempo de leitura (empréstimo e entrega do 
-- livro) de uma pessoa usando regressão, a função deve ter o 
-- seguinte formato:
-- 
--   prever_entrega(nome_usuário, num_páginas, grau_polinômio) 
-- 
-- O retorno da função deve ser um inteiro representando o 
-- número de dias da previsão.

drop function if exists biblio.escalonamento;
CREATE OR REPLACE FUNCTION biblio.escalonamento(
    A int[],
    y double precision[]
) RETURNS double precision[] AS $$
DECLARE
    n int := array_length(y,1);
    v int;
    k INTEGER;
    factor DOUBLE PRECISION;
    x DOUBLE PRECISION[];
    A_ext double precision[];
    linha double precision[];
BEGIN

    -- Cria matriz estendida [A | y]
    v := 0;
    for i in 1..n loop
        for j in 1..n loop
                A_ext := array_append(A_ext, A[(i-1)*n+j]);
            if j = n then
                A_ext := array_append(A_ext, y[i]);
            end if;
        end loop;
    end loop;

    -- Escalonamento (eliminação de Gauss)
    FOR i IN 1..n LOOP

        IF a_ext[(i-1)*(n+1)+i] = 0 THEN
            RAISE EXCEPTION 'Pivô zero encontrado na linha %, impossível continuar sem pivotamento', i;
        END IF;

        -- Zerar elementos abaixo do pivô
        FOR j IN i+1..n LOOP
            factor := a_ext[(j-1)*(n+1)+i] / a_ext[(i-1)*(n+1)+i];
            FOR k IN i..n+1 LOOP
                a_ext[(j-1)*(n+1)+k] := a_ext[(j-1)*(n+1)+k] - factor * a_ext[(i-1)*(n+1)+k];
            END LOOP;
        END LOOP;
    END LOOP;

    -- Substituição regressiva
    x := array_fill(0.0, ARRAY[n]);
    FOR i IN REVERSE n..1 LOOP
        x[i] := a_ext[(i)*(n+1)];
        FOR j IN i+1..n LOOP
            x[i] := x[i] - a_ext[(i-1)*(n+1)+j] * x[j];
        END LOOP;
        x[i] := x[i] / a_ext[(i-1)*(n+1)+i];
    END LOOP;

    RETURN x;
END;
$$ LANGUAGE plpgsql;



drop function if exists biblio.prever_entrega;
create or replace function biblio.prever_entrega(nome_usuario text, num_paginas int, grau_polinomio int) returns double precision as $$
declare
    mat int[];
    v double precision[];
    y double precision[];
    x double precision[];
    aux double precision;
    res double precision;
    n int default 0;
    reg record;
begin
    -- Percorre todos os livros lidos pelo cliente e adiciona em um vetor
    for reg in 
        select (emp.data_entrega - emp.data_retirada + 1) / liv.num_paginas::double precision as peso
        from biblio.Cliente as cli 
            join biblio.Emprestimo as emp on cli.pk = emp.pk_cliente
            join biblio.Livro as liv on emp.pk_copia_livro = liv.pk
        where emp.data_entrega is not null and cli.nome = nome_usuario
        order by emp.data_retirada desc loop

            v := array_append(v, reg.peso);
            n := n + 1;

            -- Sai do loop quando atinge o número de pontos necessários
            exit when n = grau_polinomio;
    end loop;

    -- Se a quantidade de elementos for menor do que o necessário pelo polinômio passado dá erro
    if n < grau_polinomio then
        raise exception 'Grau do polinômio grande demais para base de dados';
    end if;

    -- Monta o vetor y
    for i in 1..grau_polinomio loop
        aux := 0;
        for j in 1..grau_polinomio loop
            aux := aux + v[j] * power(j, i-1);
        end loop;
        y := array_append(y, aux);
    end loop;

    -- Monta a matriz A
    for i in 1..grau_polinomio loop
        for j in 1..grau_polinomio loop
            aux := 0;
            for k in 1..grau_polinomio loop
                aux := aux + power(k, i+j-2);
            end loop;
            mat := array_append(mat, aux);
        end loop;
    end loop;

    -- Executa o escalonamento
    x := biblio.escalonamento(mat, y);

    -- Retorna o resultado
    res := 0;
    for i in 1..grau_polinomio loop
        res := res + power(n+1, i-1) * x[i];
    end loop;
    res := res * num_paginas;

    if res < 0 then 
        return 0;
    else 
        return res;
    end if;
end
$$ language plpgsql;

select biblio.prever_entrega('Ana Silva', 100, 3);

-- Questao 2

CREATE OR REPLACE FUNCTION biblio.livros_maiores_janelas_ocupacao(
    percentual NUMERIC  -- ex: 0.8 para 80%
)
RETURNS TABLE (
    title TEXT,
    janela INT,
    total_copias INT,
    emprestadas INT
) AS $$
DECLARE
    rec_livro RECORD;
    rec_evento RECORD;
    v_emprestadas INT := 0;
    v_total INT;
    v_titulo TEXT;
    v_pk_livro INT;
    v_data_anterior DATE;
    v_data_atual DATE;
    v_delta INT;
    v_janela INT;
    v_copias_utilizadas INT;
    v_maior_janela INT;
    v_menor_copias INT;
BEGIN
    -- Loop sobre todos os livros com suas contagens de cópias
    FOR rec_livro IN
        SELECT 
            l.pk AS pk_livro,
            l.titulo,
            COUNT(DISTINCT cl.pk) AS total
        FROM biblio.Livro l
        JOIN biblio.CopiaLivro cl ON cl.pk_livro = l.pk
        GROUP BY l.pk, l.titulo
    LOOP
        v_pk_livro := rec_livro.pk_livro;
        v_titulo := rec_livro.titulo;
        v_total := rec_livro.total;

        v_emprestadas := 0;
        v_maior_janela := 0;
        v_menor_copias := NULL;
        v_data_anterior := NULL;

        -- Percorrer os eventos ordenados (retiradas e devoluções)
        FOR rec_evento IN
            SELECT * FROM (
                SELECT 
                    e.data_retirada AS data_evento,
                    1 AS delta
                FROM biblio.CopiaLivro cl
                JOIN biblio.Emprestimo e ON e.pk_copia_livro = cl.pk
                WHERE cl.pk_livro = v_pk_livro

                UNION ALL

                SELECT 
                    COALESCE(e.data_entrega, CURRENT_DATE + 1) AS data_evento,
                    -1 AS delta
                FROM biblio.CopiaLivro cl
                JOIN biblio.Emprestimo e ON e.pk_copia_livro = cl.pk
                WHERE cl.pk_livro = v_pk_livro
            ) AS eventos
            ORDER BY data_evento, delta DESC
        LOOP
            v_data_atual := rec_evento.data_evento;
            v_delta := rec_evento.delta;

            -- Avalia a janela anterior
            IF v_data_anterior IS NOT NULL THEN
                v_janela := v_data_atual - v_data_anterior;
                IF v_emprestadas >= CEIL(v_total * percentual) THEN
                    IF v_janela > v_maior_janela THEN
                        v_maior_janela := v_janela;
                        v_menor_copias := v_emprestadas;
                    ELSIF v_janela = v_maior_janela AND v_emprestadas < v_menor_copias THEN
                        v_menor_copias := v_emprestadas;
                    END IF;
                END IF;
            END IF;

            -- Atualiza o contador de cópias emprestadas
            v_emprestadas := v_emprestadas + v_delta;
            v_data_anterior := v_data_atual;
        END LOOP;

        -- Retorna o resultado para o livro atual
        title := v_titulo;
        janela := COALESCE(v_maior_janela, 0);
        total_copias := v_total;
        emprestadas := COALESCE(v_menor_copias, 0);
        RETURN NEXT;
    END LOOP;

    RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * 
FROM biblio.livros_maiores_janelas_ocupacao(0.8)
ORDER BY 
    janela DESC, 
    emprestadas DESC;


------------------------ Questão nº3 ------------------------
-- Faça uma função que estime a chance de um livro ser devolvido 
-- com atraso, considerando o histórico do usuário, o tipo de 
-- livro (gênero) e o número de páginas. A função deve utilizar 
-- classificação binária (por exemplo, regressão logística) e 
-- ter o seguinte formato:
-- 
--     probabilidade_atraso(nome_usuário, gênero, num_páginas)
-- 
-- A saída deve ser um valor entre 0 e 1 representando a chance 
-- estimada de atraso.

CREATE OR REPLACE FUNCTION biblio.probabilidade_devolucao(
    biblioteca_id INTEGER
)
RETURNS SETOF RECORD 
LANGUAGE plpgsql 
AS $$
DECLARE
    generos TEXT;
    query TEXT;
BEGIN
    SELECT STRING_AGG(
        'COALESCE(MAX(CASE WHEN genero_id = ' || pk || ' THEN probabilidade END), 0.5) AS "' || nome || '"',
        ', '
    )
    INTO generos
    FROM biblio.Genero;

    query := '
    WITH dados_emprestimos AS (
        SELECT 
            c.pk AS usuario_id,
            l.pk_genero AS genero_id,
            g.nome AS genero_nome,
            CASE WHEN e.data_entrega <= e.data_prevista THEN 1 ELSE 0 END AS devolucao_pontual
        FROM 
            biblio.Emprestimo e
            JOIN biblio.Cliente c ON e.pk_cliente = c.pk
            JOIN biblio.CopiaLivro cl ON e.pk_copia_livro = cl.pk
            JOIN biblio.Livro l ON cl.pk_livro = l.pk
            JOIN biblio.Genero g ON l.pk_genero = g.pk
        WHERE 
            cl.pk_biblioteca = ' || biblioteca_id || '
            AND e.data_entrega IS NOT NULL
    ),
    estatisticas AS (
        SELECT 
            usuario_id,
            genero_id,
            genero_nome,
            (SUM(devolucao_pontual) + 1)::NUMERIC / 
            (COUNT(*) + 2) AS probabilidade
        FROM 
            dados_emprestimos
        GROUP BY 
            usuario_id, genero_id, genero_nome
    ),
    todos_usuarios AS (
        SELECT DISTINCT c.pk AS id, c.nome
        FROM biblio.Cliente c
        JOIN biblio.Emprestimo e ON c.pk = e.pk_cliente
        JOIN biblio.CopiaLivro cl ON e.pk_copia_livro = cl.pk
        WHERE cl.pk_biblioteca = ' || biblioteca_id || '
    )
    SELECT 
        u.id AS usuario_id,
        u.nome AS usuario_nome, ' || generos || '
    FROM 
        todos_usuarios u
        LEFT JOIN estatisticas e ON u.id = e.usuario_id
    GROUP BY 
        u.id, u.nome
    ORDER BY 
        u.nome';

    RETURN QUERY EXECUTE query;
END;
$$;

SELECT * FROM biblio.probabilidade_devolucao(3) 
AS (
    usuario_id INTEGER,
    usuario_nome TEXT,
    Fantasia NUMERIC,
    Mistério NUMERIC,
    Aventura NUMERIC,
    "Ficção Científica" NUMERIC,
    Drama NUMERIC,
    Romance NUMERIC,
    Infantil NUMERIC,
    História NUMERIC,
    Biografia NUMERIC
);

