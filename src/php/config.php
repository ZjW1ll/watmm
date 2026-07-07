<?php

$servidor = "localhost";
$usuario = "root";
$senha = "root";
$banco = "WATMM";

$conexao = new mysqli($servidor, $usuario, $senha, $banco);

if($conexao->connect_error) {
    die("Erro de conexão: " . $conexao->connect_error);
}

?>