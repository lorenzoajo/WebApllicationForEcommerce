<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Informazioni sfilate</title>
<link href="css/inf_sfilCSS.css" rel="stylesheet" type="text/css">
<script>
function cambia_colori(colore_sfondo, colore_elementi) {
	document.getElementById('container').style.backgroundColor = colore_sfondo;
	document.getElementById('elem_header').style.backgroundColor = colore_elementi;
	document.getElementById('elem_footer').style.backgroundColor = colore_elementi;
}
</script>
</head>
	<?php
	session_start();
	require_once("connessione.php");
	if(isset($_SESSION['email'])){
		foreach($db->query("SELECT * FROM utenti WHERE email='$_SESSION[email]'") as $row) {
			$utente=$row['nome'];
			$colore_sfondo=$row['colore_sfondo'];
			$colore_elementi=$row['colore_elementi'];
		}
	}
    ?>
<body onload="cambia_colori('<?php echo $colore_sfondo; ?>','<?php echo $colore_elementi; ?>')">
  <header id="elem_header">
   	<img src="img/logo.png" id="logo" height="100px" alt="logo">
	<?php
    require_once("connessione.php");
    if(isset($_SESSION['email'])){
        echo '<a href="esci.php">Esci</a>';
        echo '<a href="profilo.php">Benvenuto '.$utente.'</a>';
    }
    else {
        echo '<a href="registrazione.php">Registrati</a>';
        echo '<a href="accedi.php">Accedi</a>';
    }
    ?>
  	<a href="carrello.php">Carrello</a>
  </header>
  <div id="nav">
      <a href="home.php">Home</a>
      <?php
      foreach($db->query("SELECT * FROM linee") as $row)
        echo '<a href="'.$row['categoria'].'.php">'.$row['categoria'].'</a>';
      ?>
      <a href="sfilate.php">Sfilate</a>
  </div>
  <div id="container">
    <p><strong>Informazioni sfilate</strong><br><br>
    Le nostre sfilate sono eventi unici dove potrai vedere le nostre collezioni in anteprima!<br>
    L'ingresso è gratuito e non necessita di prenotazione, posti fino ad esaurimento.<br>
	Le sfilate sono specifiche per una linea, controlla <a href="sfilate.php">qui</a> la prossima <br>
    </p>
  </div>
  <footer id="elem_footer">
	  <a href="diritto_recesso.php">diritto recesso</a>
      <a href="privacy_cookie.php">privacy e cookie</a>
      <a href="informazioni_sfilate.php">Informazioni sfilate</a>
  </footer>
</body>
</html>
