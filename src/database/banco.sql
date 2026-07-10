-- ============================================
-- ESTRUTURA
-- ============================================

CREATE DATABASE IF NOT EXISTS WATMM;
USE WATMM;

CREATE TABLE IF NOT EXISTS artistas (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    pais_origem VARCHAR(60),
    data_nascimento DATE NULL,
    data_falecimento DATE NULL,
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
    descricao TEXT,
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

INSERT INTO artistas (nome, pais_origem, data_nascimento, data_falecimento, biografia, foto_url) VALUES

('Michael Jackson', 'Estados Unidos', 
'1958-08-29', '2009-06-25',
'Michael Jackson foi um cantor, compositor, dançarino e performer norte-americano conhecido mundialmente como o Rei do Pop. Sua carreira começou ainda na infância com o grupo Jackson 5, mas foi em carreira solo que redefiniu a música pop através de álbuns históricos, videoclipes revolucionários e apresentações icônicas. Sua influência artística atravessa gerações, tornando-o um dos artistas mais importantes e premiados da história da música.',
'/assets/artistas/michael_jackson.jpg'),

('2Pac', 'Estados Unidos', 
'1971-06-16', '1996-09-13',
'Tupac Amaru Shakur, conhecido como 2Pac, foi um rapper, compositor e ator norte-americano considerado uma das maiores figuras da história do hip hop. Suas letras abordavam desigualdade social, violência, racismo, política e conflitos pessoais, equilibrando crítica social e vulnerabilidade. Mesmo após sua morte em 1996, permanece como uma das maiores referências culturais da música.',
'/assets/artistas/tupac.jpg'),

('Notorious B.I.G.', 'Estados Unidos', 
'1972-05-21', '1997-03-09',
'Christopher Wallace, conhecido artisticamente como The Notorious B.I.G. ou Biggie Smalls, foi um rapper norte-americano cuja habilidade narrativa e técnica lírica transformaram o hip hop da costa leste. Seus álbuns Ready to Die e Life After Death são considerados clássicos absolutos do gênero e consolidaram seu legado como um dos maiores MCs de todos os tempos.',
'/assets/artistas/notorius_big.jpg'),

('N.W.A', 'Estados Unidos', 
NULL, NULL,
'O N.W.A foi um grupo pioneiro do gangsta rap formado em Compton, Califórnia. Composto por artistas como Dr. Dre, Ice Cube, Eazy-E, MC Ren e DJ Yella, revolucionou o hip hop ao retratar de forma direta a realidade das periferias americanas. Sua influência musical e cultural permanece presente em diversas gerações de artistas.',
'/assets/artistas/nwa.jpg'),

('Daniel Caesar', 'Canadá', 
'1995-04-05', NULL,
'Daniel Caesar é um cantor, compositor e produtor canadense reconhecido por unir R&B, soul, gospel e jazz em uma sonoridade intimista. Sua música explora temas como amor, espiritualidade e crescimento pessoal, destacando-se pelos vocais marcantes e pela produção refinada. É considerado um dos principais nomes do R&B contemporâneo.',
'/assets/artistas/daniel_caesar.jpg');

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
-- ÁLBUNS
-- ============================================

INSERT INTO albuns
(nome_album, artista_id, gravadora_id, genero_id, descricao, data_lancamento_original, capa_url)
VALUES

-- Michael Jackson

('Thriller',1,1,1,
'Lançado em 1982, Thriller consolidou Michael Jackson como o maior artista pop de sua geração e tornou-se o álbum mais vendido da história da música. Produzido por Quincy Jones, combina pop, rock, R&B e funk em uma sequência de faixas que redefiniu os padrões da indústria musical. Com sucessos como Billie Jean, Beat It e Thriller, o álbum marcou uma revolução tanto sonora quanto visual, influenciando artistas e produtores por décadas.',
'1982-11-30',
'/assets/albuns/thriller.jpg'),

('Bad',1,1,1,
'Bad, lançado em 1987, representa a continuidade do sucesso de Thriller, mas com uma identidade própria e mais agressiva. Michael Jackson explorou uma sonoridade moderna que mistura pop, funk, rock e R&B, estabelecendo recordes ao colocar cinco singles consecutivos no topo da Billboard Hot 100. O álbum reafirmou sua posição como um dos maiores artistas da história.',
'1987-08-31',
'/assets/albuns/bad.jpg'),

-- 2Pac

('All Eyez on Me',2,2,4,
'All Eyez on Me é o quarto álbum de estúdio de 2Pac e o primeiro álbum duplo da história do hip hop lançado por um artista solo. Lançado em 1996, após sua saída da prisão, apresenta uma combinação de faixas introspectivas e hinos da costa oeste. É considerado uma das obras mais influentes do rap, refletindo tanto o carisma quanto os conflitos vividos por Tupac Shakur.',
'1996-02-13',
'/assets/albuns/all_eyez_on_me.jpg'),

('Me Against the World',2,3,4,
'Me Against the World, lançado em 1995, é frequentemente considerado o trabalho mais pessoal de 2Pac. O álbum apresenta reflexões sobre desigualdade, violência, fama e mortalidade, equilibrando vulnerabilidade e crítica social. Tornou-se um marco do hip hop pela profundidade de suas letras e pela autenticidade emocional.',
'1995-03-14',
'/assets/albuns/me_against_the_world.jpg'),

-- Notorius B.I.G

('Ready to Die',3,4,3,
'Ready to Die marcou a estreia de The Notorious B.I.G. em 1994 e tornou-se um dos álbuns mais importantes da história do hip hop. Narrando a realidade das ruas do Brooklyn, combina storytelling detalhado, produção refinada e um fluxo marcante. Faixas como Juicy e Big Poppa transformaram Biggie em um dos maiores nomes do rap.',
'1994-09-13',
'/assets/albuns/ready_to_die.jpg'),

('Life After Death',3,4,3,
'Life After Death foi lançado em 1997 poucas semanas após a morte de The Notorious B.I.G. O álbum duplo apresenta um equilíbrio entre faixas introspectivas e sucessos comerciais, consolidando o legado do rapper. É considerado um dos melhores álbuns de rap de todos os tempos e um símbolo da era de ouro do hip hop.',
'1997-03-25',
'/assets/albuns/life_after_death.jpg'),

-- N.W.A

('Straight Outta Compton',4,5,4,
'Straight Outta Compton apresentou o N.W.A ao mundo em 1988 e redefiniu o gangsta rap. Com letras diretas e provocativas, denunciava violência policial, desigualdade racial e a realidade das periferias de Los Angeles. Sua influência ultrapassou a música, tornando-se um marco cultural e político.',
'1988-08-08',
'/assets/albuns/straight_outta_compton.jpg'),

('Efil4zaggin',4,5,4,
'Efil4zaggin, lançado em 1991, deu continuidade ao impacto do N.W.A com uma abordagem ainda mais agressiva. O álbum alcançou o topo da Billboard e consolidou o grupo como uma das maiores forças do hip hop. Suas letras e produção reforçaram a identidade do gangsta rap durante os anos 90.',
'1991-05-28',
'/assets/albuns/efil4zaggin.jpg'),

-- Daniel Caesar

('Freudian',5,6,2,
'Freudian, lançado em 2017, é o álbum de estreia de Daniel Caesar e uma das obras mais elogiadas do R&B contemporâneo. Misturando soul, gospel e influências do jazz, aborda temas como amor, espiritualidade e vulnerabilidade. A produção minimalista e os vocais marcantes fizeram do álbum um clássico moderno do gênero.',
'2017-08-25',
'/assets/albuns/freudian.jpg'),

('CASE STUDY 01',5,6,2,
'CASE STUDY 01, lançado em 2019, amplia a proposta artística de Daniel Caesar ao explorar relacionamentos, fama e amadurecimento pessoal. Com participações especiais e uma produção sofisticada, o álbum combina R&B contemporâneo, soul e elementos experimentais, consolidando sua identidade musical.',
'2019-06-28',
'/assets/albuns/case_study_01.jpg');

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
    artistas.id AS artista_id,
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

CREATE VIEW vw_album_tracks AS
SELECT
    albuns.id AS album_id,
    artistas.id AS artista_id,
    albuns.nome_album,
    artistas.nome AS nome_artista,
    
    faixas.id AS faixa_id,
    faixas.numero_faixa,
    faixas.titulo, 
    faixas.duracao_segundos
FROM albuns
INNER JOIN artistas
    ON albuns.artista_id = artistas.id
INNER JOIN faixas
    ON faixas.album_id = albuns.id;