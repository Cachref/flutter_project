<?php
# Définition des paramètres de connexion
$servername = "127.0.0.1"; //adresse du serveur de la Base de données
$username = "root"; //utilisateur de la Base de données
$password = "root"; //mot de passe de l’utilisateur
$base = "flutterapp1"; //nom de la base de données
# Création de l’objet connexion
try {
    $connexion = new PDO("mysql:host=$servername;dbname=$base", $username, $password);
} catch (Exception $e) {
    echo $e->getMessage();
}
?>
