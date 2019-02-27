<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Elenco ordini</title>
<link href="css/el_ordCSS.css" rel="stylesheet" type="text/css">
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
	foreach($db->query("SELECT * FROM utenti WHERE email='$_SESSION[email]'") as $row) {
		$utente=$row['nome'];
		$email=$row['email'];
		$colore_sfondo=$row['colore_sfondo'];
		$colore_elementi=$row['colore_elementi'];
	}
    ?>
<body onload="cambia_colori('<?php echo $colore_sfondo; ?>','<?php echo $colore_elementi; ?>')">
  <header id="elem_header">
    <img src="img/logo.png" id="logo" height="100px" alt="logo">
	<a href="esci.php">Esci</a>
    <a href="profilo.php">Benvenuto <?php echo $utente ?> </a>
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
    <div id="scritte"><strong>Elenco ordini</strong><br><br>
    <?php
	$i=0;
    foreach($db->query("SELECT * FROM ordini WHERE email='$email'") as $row) {
		$i++;
		$codice_ordine=$row['codice_ordine'];
		echo 'Ordine n. '.$codice_ordine.':<br>';
		echo 'Hai pagato '.$row['prezzo_totale'].' con '.$row['metodo_di_pagamento'].'.<br>';
		echo 'Hai acquistato i prodotti con codice:<br>';
		foreach($db->query("SELECT * FROM ordini_prodotti WHERE codice_ordine='$codice_ordine'") as $row2)
			echo '-->('.$row2['quantita'].')  prodotto con codice '.$row2['codice_prodotto'].'<br>';
		echo '<br><br>';
	}
	if($i==0)
			echo 'Nessun ordine presente';
    ?>
    </div>
  </div>
  <footer id="elem_footer">
	  <a href="diritto_recesso.php">diritto recesso</a>
      <a href="privacy_cookie.php">privacy e cookie</a>
      <a href="informazioni_sfilate.php">Informazioni sfilate</a>
  </footer>
</body>
</html>
