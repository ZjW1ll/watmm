-- ============================================
-- ESTRUTURA
-- ============================================

CREATE DATABASE IF NOT EXISTS WATMM;
USE WATMM;

CREATE TABLE IF NOT EXISTS artistas (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    pais_origem VARCHAR(60),
    biografia TEXT,
    foto_url VARCHAR(255) DEFAULT NULL COMMENT 'URL ou caminho da foto do artista',
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS gravadoras (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    pais VARCHAR(60),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS generos (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS albuns (
    id INT NOT NULL AUTO_INCREMENT,
    nome_album VARCHAR(80) NOT NULL,
    artista_id INT NOT NULL,
    gravadora_id INT,
    genero_id INT,
    descricao VARCHAR(255),
    data_lancamento_original DATE,
    capa_url VARCHAR(255) DEFAULT NULL COMMENT 'URL ou caminho da capa do álbum',
    PRIMARY KEY (id),
    FOREIGN KEY (artista_id) REFERENCES artistas(id),
    FOREIGN KEY (gravadora_id) REFERENCES gravadoras(id),
    FOREIGN KEY (genero_id) REFERENCES generos(id)
);

CREATE TABLE IF NOT EXISTS faixas (
    id INT NOT NULL AUTO_INCREMENT,
    album_id INT NOT NULL,
    numero_faixa TINYINT UNSIGNED NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    duracao_segundos INT,
    lado ENUM('A', 'B', 'C', 'D') DEFAULT 'A',
    PRIMARY KEY (id),
    FOREIGN KEY (album_id) REFERENCES albuns(id)
);

-- ============================================
-- ÍNDICES FULLTEXT (para a pesquisa)
-- ============================================

ALTER TABLE artistas ADD FULLTEXT INDEX ft_artista (nome);
ALTER TABLE gravadoras ADD FULLTEXT INDEX ft_gravadora (nome);
ALTER TABLE albuns ADD FULLTEXT INDEX ft_album (nome_album);

-- ============================================
-- GÊNEROS
-- ============================================

INSERT INTO generos (nome) VALUES
('Pop'),
('R&B'),
('Hip Hop'),
('Gangsta Rap');

-- ============================================
-- ARTISTAS
-- ============================================

INSERT INTO artistas (nome, pais_origem, biografia) VALUES
('Michael Jackson', 'Estados Unidos', 'Conhecido como "Rei do Pop", um dos artistas mais influentes da história da música.'),
('2Pac', 'Estados Unidos', 'Rapper e ator, um dos nomes mais influentes do hip hop dos anos 90.'),
('Notorious B.I.G.', 'Estados Unidos', 'Rapper de Nova York, ícone do hip hop da costa leste dos EUA.'),
('N.W.A', 'Estados Unidos', 'Grupo de hip hop de Compton, pioneiro do gangsta rap.'),
('Daniel Caesar', 'Canadá', 'Cantor e compositor canadense de R&B contemporâneo.');

-- ============================================
-- GRAVADORAS
-- ============================================

INSERT INTO gravadoras (nome, pais) VALUES
('Epic Records', 'Estados Unidos'),
('Death Row Records', 'Estados Unidos'),
('Interscope Records', 'Estados Unidos'),
('Bad Boy Records', 'Estados Unidos'),
('Ruthless Records', 'Estados Unidos'),
('Golden Child Recordings', 'Canadá');

-- ============================================
-- ÁLBUNS (2 por artista)
-- ============================================

-- Michael Jackson
INSERT INTO albuns (nome_album, artista_id, gravadora_id, genero_id, descricao, data_lancamento_original) VALUES
('Thriller', 1, 1, 1, 'O álbum mais vendido da história, com hits como Billie Jean e Beat It.', '1982-11-30'),
('Bad', 1, 1, 1, 'Sétimo álbum de estúdio, sucessor de Thriller.', '1987-08-31');

-- 2Pac
INSERT INTO albuns (nome_album, artista_id, gravadora_id, genero_id, descricao, data_lancamento_original) VALUES
('All Eyez on Me', 2, 2, 4, 'Álbum duplo lançado pela Death Row Records, um dos marcos do gangsta rap.', '1996-02-13'),
('Me Against the World', 2, 3, 4, 'Álbum introspectivo lançado enquanto 2Pac estava preso.', '1995-03-14');

-- Notorious B.I.G.
INSERT INTO albuns (nome_album, artista_id, gravadora_id, genero_id, descricao, data_lancamento_original) VALUES
('Ready to Die', 3, 4, 3, 'Álbum de estreia, considerado um clássico do hip hop dos anos 90.', '1994-09-13'),
('Life After Death', 3, 4, 3, 'Álbum duplo lançado postumamente, 16 dias após sua morte.', '1997-03-25');

-- N.W.A
INSERT INTO albuns (nome_album, artista_id, gravadora_id, genero_id, descricao, data_lancamento_original) VALUES
('Straight Outta Compton', 4, 5, 4, 'Álbum de estreia do grupo, marco fundador do gangsta rap.', '1988-08-08'),
('Efil4zaggin', 4, 5, 4, 'Segundo álbum de estúdio, primeiro a chegar ao topo da Billboard 200.', '1991-05-28');

-- Daniel Caesar
INSERT INTO albuns (nome_album, artista_id, gravadora_id, genero_id, descricao, data_lancamento_original) VALUES
('Freudian', 5, 6, 2, 'Álbum de estreia, indicado ao Grammy de Melhor Álbum de R&B.', '2017-08-25'),
('CASE STUDY 01', 5, 6, 2, 'Segundo álbum de estúdio, com sonoridade mais experimental.', '2019-06-28');

UPDATE albuns SET capa_url = '/assets/albuns/thriller.jpg'
WHERE id = 1;

UPDATE albuns SET capa_url = '/assets/albuns/bad.jpg'
WHERE id = 2;

UPDATE albuns SET capa_url = '/assets/albuns/all_eyez_on_me.jpg'
WHERE id = 3;

UPDATE albuns SET capa_url = '/assets/albuns/me_against_the_world.jpg'
WHERE id = 4;

UPDATE albuns SET capa_url = '/assets/albuns/ready_to_die.jpg'
WHERE id = 5;

UPDATE albuns SET capa_url = '/assets/albuns/life_after_death.jpg'
WHERE id = 6;

UPDATE albuns SET capa_url = '/assets/albuns/straight_outta_compton.jpg'
WHERE id = 7;

UPDATE albuns SET capa_url = '/assets/albuns/efil4zaggin.jpg'
WHERE id = 8;

UPDATE albuns SET capa_url = '/assets/albuns/freudian.jpg'
WHERE id = 9;

UPDATE albuns SET capa_url = '/assets/albuns/case_study_01.jpg'
WHERE id = 10;

-- ============================================
-- FAIXAS
-- ============================================

-- Thriller (album_id = 1)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(1, 1, "Wanna Be Startin' Somethin'", 363, 'A'),
(1, 2, 'Baby Be Mine', 260, 'A'),
(1, 3, 'The Girl Is Mine', 220, 'A'),
(1, 4, 'Thriller', 357, 'A'),
(1, 5, 'Beat It', 258, 'B'),
(1, 6, 'Billie Jean', 294, 'B'),
(1, 7, 'Human Nature', 246, 'B'),
(1, 8, 'P.Y.T. (Pretty Young Thing)', 239, 'B'),
(1, 9, 'The Lady in My Life', 300, 'B');

-- Bad (album_id = 2)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(2, 1, 'Bad', 247, 'A'),
(2, 2, 'The Way You Make Me Feel', 297, 'A'),
(2, 3, 'Speed Demon', 250, 'A'),
(2, 4, 'Liberian Girl', 253, 'A'),
(2, 5, 'Just Good Friends', 246, 'A'),
(2, 6, 'Another Part of Me', 231, 'B'),
(2, 7, 'Man in the Mirror', 328, 'B'),
(2, 8, "I Just Can't Stop Loving You", 264, 'B'),
(2, 9, 'Dirty Diana', 287, 'B'),
(2, 10, 'Smooth Criminal', 257, 'B');

-- All Eyez on Me (album_id = 3)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(3, 1, 'Ambitionz Az a Ridah', 271, 'A'),
(3, 2, 'All Bout U', 293, 'A'),
(3, 3, 'Skandalouz', 273, 'B'),
(3, 4, 'Life Goes On', 297, 'B'),
(3, 5, 'Only God Can Judge Me', 297, 'C'),
(3, 6, "Tradin' War Stories", 373, 'C'),
(3, 7, 'California Love', 292, 'D'),
(3, 8, '2 of Amerikaz Most Wanted', 260, 'D');

-- Me Against the World (album_id = 4)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(4, 1, 'If I Die 2Nite', 273, 'A'),
(4, 2, 'Me Against the World', 296, 'A'),
(4, 3, 'So Many Tears', 297, 'A'),
(4, 4, 'Temptations', 280, 'A'),
(4, 5, 'Fuck the World', 273, 'B'),
(4, 6, 'Old School', 273, 'B'),
(4, 7, 'Heavy in the Game', 260, 'B'),
(4, 8, 'Lord Knows', 297, 'B'),
(4, 9, 'Dear Mama', 296, 'B');

-- Ready to Die (album_id = 5)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(5, 1, 'Things Done Changed', 265, 'A'),
(5, 2, 'Gimme the Loot', 315, 'A'),
(5, 3, 'Machine Gun Funk', 285, 'A'),
(5, 4, 'Warning', 275, 'A'),
(5, 5, 'Ready to Die', 254, 'B'),
(5, 6, 'One More Chance', 297, 'B'),
(5, 7, 'Juicy', 304, 'B'),
(5, 8, 'Big Poppa', 254, 'B'),
(5, 9, 'Suicidal Thoughts', 292, 'B');

-- Life After Death (album_id = 6)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(6, 1, "Somebody's Gotta Die", 289, 'A'),
(6, 2, 'Hypnotize', 244, 'A'),
(6, 3, 'Kick in the Door', 293, 'B'),
(6, 4, 'Mo Money Mo Problems', 264, 'B'),
(6, 5, 'I Got a Story to Tell', 258, 'C'),
(6, 6, 'Notorious Thugs', 341, 'C'),
(6, 7, "Sky's the Limit", 296, 'D'),
(6, 8, 'Going Back to Cali', 264, 'D');

-- Straight Outta Compton (album_id = 7)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(7, 1, 'Straight Outta Compton', 258, 'A'),
(7, 2, 'Fuck tha Police', 289, 'A'),
(7, 3, 'Gangsta Gangsta', 292, 'A'),
(7, 4, "If It Ain't Ruff", 249, 'A'),
(7, 5, 'Express Yourself', 274, 'B'),
(7, 6, "Compton's N the House", 250, 'B'),
(7, 7, 'Dopeman', 396, 'B'),
(7, 8, '8 Ball', 344, 'B');

-- Efil4zaggin (album_id = 8)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(8, 1, 'Efil4zaggin', 261, 'A'),
(8, 2, 'Real Niggaz', 249, 'A'),
(8, 3, "Alwayz into Somethin'", 300, 'A'),
(8, 4, '1-900-2-Compton', 249, 'B'),
(8, 5, 'Approach to Danger', 279, 'B'),
(8, 6, 'Automobile', 254, 'B'),
(8, 7, 'One Less Bitch', 289, 'B');

-- Freudian (album_id = 9)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(9, 1, 'Get You', 227, 'A'),
(9, 2, 'Best Part', 210, 'A'),
(9, 3, 'Blessed', 234, 'A'),
(9, 4, 'Take Me Away', 253, 'A'),
(9, 5, 'Hurt You', 249, 'B'),
(9, 6, 'Neu Roses (Transform)', 251, 'B'),
(9, 7, 'We Find Love', 292, 'B'),
(9, 8, 'Freudian', 214, 'B');

-- CASE STUDY 01 (album_id = 10)
INSERT INTO faixas (album_id, numero_faixa, titulo, duracao_segundos, lado) VALUES
(10, 1, 'Entitlement', 158, 'A'),
(10, 2, 'Cash App', 279, 'A'),
(10, 3, 'Frontal Lobe Muzik', 189, 'A'),
(10, 4, 'Love Again', 195, 'A'),
(10, 5, 'Xoxo', 234, 'B'),
(10, 6, 'Superposition', 264, 'B'),
(10, 7, 'Who Hurt You?', 231, 'B'),
(10, 8, 'Hangover', 214, 'B');

-- ============================================
-- VIEWS
-- ============================================

CREATE VIEW vw_card_album AS
SELECT
    albuns.id AS album_id,
    albuns.nome_album,
    albuns.descricao,
    albuns.data_lancamento_original,
    albuns.capa_url,
    artistas.nome AS nome_artista,
    COUNT(faixas.id) AS qtd_faixas,
    COALESCE(SUM(faixas.duracao_segundos), 0) AS duracao_total_segundos
FROM albuns
INNER JOIN artistas
    ON albuns.artista_id = artistas.id
LEFT JOIN faixas
    ON faixas.album_id = albuns.id
GROUP BY
    albuns.id,
    albuns.nome_album,
    albuns.descricao,
    albuns.data_lancamento_original,
    albuns.capa_url,
    artistas.nome;