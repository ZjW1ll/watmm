<?php 

require '../php/config.php';

$id = (int) ($_GET['id'] ?? 0);
$stmt = $conexao->prepare('SELECT * FROM artistas WHERE id = ?');
$stmt->bind_param("i", $id);
$stmt->execute();

$resultado = $stmt->get_result();
$artista = $resultado->fetch_assoc();

$stmt->close();

$stmt = $conexao->prepare('SELECT * FROM vw_card_album WHERE artista_id = ?');
$stmt->bind_param("i", $id);
$stmt->execute();

$albuns = $stmt->get_result();

$stmt->close();
?>

<!DOCTYPE html>
<html lang="pr-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="/watmm/assets/icon/icon.webp" type="image/x-icon">

    <title>WATMM</title>
    <link rel="stylesheet" href="../styles/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="./index.php" class="navbar-logo"><img src="/watmm/assets/icon/icon.webp" alt="Icone Loja Disco" style="filter: invert();"></a>
            <div class="navbar-search">
                <input
                    type="text"
                    placeholder="Pesquisar álbum..."
                    class="search"
                >
            </div>
        </nav>
    </header>

    <main>
        <section class="container details">
            <div class="details-sidebar">
                <img src="/watmm/<?= $artista['foto_url'] ?>" alt="<?= $artista['nome'] ?>" class="artist details-img">
                <h1 class="details-name"><?= $artista['nome'] ?></h1>
                <h1 class="details-origin"><?= $artista['pais_origem'] ?></h1>
                <div class="details-lifetime">
                    <span class="lifetime-item">
                        <?= $artista['data_nascimento'] ?> 
                        <i class="fa-solid fa-star lifetime-icon"></i>
                    </span>
                    <span class="lifetime-item">
                        <?php if(!empty($artista['data_falecimento'])) { ?>
                            <?= $artista['data_falecimento'] ?> 
                            <i class="fa-solid fa-cross lifetime-icon"></i>
                        <?php } ?>
                    </span>
                </div>
            </div>
            <div class="details-content">
                <p class="details-description"><?= $artista['biografia'] ?></p>
                <div class="albuns details-collection">
                    <h2 class="section-title">Albuns</h2>
                    <div class="albuns collection-scroll">
                <?php 
                    while($album = $albuns->fetch_assoc()) {
                        $duracao_segundos = $album['duracao_total_segundos'] % 60;
                        $duracao_minutos = ($album['duracao_total_segundos'] - $duracao_segundos) / 60;
                ?>
                    <a class="card" href="album.php?id=<?= $album['album_id'] ?>">
                        <img src="/watmm/<?= $album['capa_url'] ?>" alt="Capa do album <?= $album['nome_album'] ?>" class="card-img">
                        <h1 class="card-name"><?= $album['nome_album'] ?></h1>
                        <div class="card-infos-wrapper">
                            <div class="card-infos">
                                <span class="artist"><?= $album['nome_artista']?></span>
                                <span class="release"><?= date('Y', strtotime($album['data_lancamento_original'])) ?></span>
                            </div>
                            <div class="card-infos">
                                <span class="tracks"><?= $album['qtd_faixas'] ?> Tracks</span>
                                <span class="duration"><?= $duracao_minutos  ?>m <?= $duracao_segundos ?>s</span>
                            </div>
                        </div>
                    </a>
            
                <?php } ?>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer class="footer">
        <p>© 2026 WATMM — We Are The Music Makers.</p>
        <p>Desenvolvido por <a href="https://github.com/ZjW1ll"><strong>Willian Zimmermann Junior</strong></a>.</p>
        <p>Todos os direitos das capas, artistas e obras pertencem aos seus respectivos proprietários.</p>
    </footer>
</body>
</html>