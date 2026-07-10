<?php 

require '../php/config.php';

$id = (int) ($_GET['id'] ?? 0);
$stmt = $conexao->prepare('SELECT * FROM vw_card_album WHERE album_id = ?');
$stmt->bind_param("i", $id);
$stmt->execute();

$resultado = $stmt->get_result();
$album = $resultado->fetch_assoc();

$stmt->close();

$stmt = $conexao->prepare('SELECT * FROM vw_album_tracks WHERE album_id = ?');
$stmt->bind_param("i", $id);
$stmt->execute();

$tracks = $stmt->get_result();

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
                <img src="/watmm/<?= $album['capa_url'] ?>" alt="Capa do album <?= $album['nome_album'] ?>" class="details-img">
                <h1 class="details-name"><?= $album['nome_album'] ?></h1>
                <h1 class="details-release"><?= $album['data_lancamento_original'] ?></h1>
                <a href="./artista.php?id=<?= $album['artista_id'] ?>" class="details-artist"><?= $album['nome_artista'] ?></a>
            </div>
            <div class="details-content">
                <p class="details-description"><?= $album['descricao'] ?></p>
                <div class="tracks details-collection">
                    <h2 class="section-title">Tracklist</h2>
                    <div class="tracks collection-scroll">
                        <?php while($track = $tracks->fetch_assoc()) {
                            $duracao_segundos = $track['duracao_segundos'] % 60;
                            $duracao_minutos = ($track['duracao_segundos'] - $duracao_segundos) / 60;
                        ?>
                            <div class="track">
                                <span class="track-number"><?= $track['numero_faixa'] ?></span>
                                <span class="track-title"><?= $track['titulo'] ?></span>
                                <span class="track-duration"><?= $duracao_minutos?>m <?= str_pad($duracao_segundos, 2, "0", STR_PAD_LEFT) ?>s</span>
                            </div>
                        <?php }?>
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