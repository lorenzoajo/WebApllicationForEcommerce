<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Home</title>
<link href="css/homeCSS.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/default.css" type="text/css" media="screen" />


<script type="text/javascript">

function carica_carrello(id) {  //id è il numero della cella del prodotto che si vuole mettere nel carrello
	var parent = document.getElementById('bottone_'+id).parentNode;
    var path = "gestione_carrello.php?prod="+document.getElementById('codice_'+id).value+"&taglia="+document.getElementById('taglia_'+id).value+"&quant="+document.getElementById('quantita_'+id).value+"&flag=0";
    parent.setAttribute("href", path);
}

function cambia_colori(colore_sfondo, colore_elementi) {
	document.getElementById('container').style.backgroundColor = colore_sfondo;
	document.getElementById('elem_header').style.backgroundColor = colore_elementi;
	document.getElementById('elem_footer').style.backgroundColor = colore_elementi;
	var i;
	for(i=0; i<100; i++)
		document.getElementById('elem_td_' + i).style.backgroundColor = colore_elementi;
}
</script>
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,400italic,700' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Oswald:400,300' rel='stylesheet' type='text/css'>

</head>
	<?php
	session_start();
	require_once("connessione.php");
	if(isset($_SESSION['email'])) {
		foreach($db->query("SELECT * FROM utenti WHERE email='$_SESSION[email]'") as $row) {
			$utente=$row['nome'];
			$colore_sfondo=$row['colore_sfondo'];
			$colore_elementi=$row['colore_elementi'];
			$linea_preferita=$row['linea_preferita'];
			$capo_preferito=$row['capo_preferito'];
		}
	}
    ?>
<body onload="cambia_colori('<?php echo $colore_sfondo; ?>','<?php echo $colore_elementi; ?>')">
  <header id="elem_header">
    <img src="img/logo.png" id="logo" height="100px" alt="logo">
	<?php
    if(isset($_SESSION['email'])) {
        echo '<a href="esci.php">Esci</a>';
        echo '<a href="profilo.php">Benvenuto '.$utente.'</a>';
    } else {
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

    <?php
	if(isset($_SESSION['email'])) {
    	echo '<div id="categoria"><strong>Prodotti che ti potrebbero piacere</strong></div>';
    	echo '<table>';
		$i=0;
		foreach($db->query("SELECT * FROM prodotti WHERE categoria='$linea_preferita' AND nome='$capo_preferito' ORDER BY codice_prodotto DESC LIMIT 16") as $row) {
			if($i%4==0)
				echo '<tr>';
			$codice_prodotto=$row['codice_prodotto'];
			echo '<td id="elem_td_'.$i.'"><img src="'.$row['immagine'].'" width="275px" height="275px" alt="immagine '.$codice_prodotto.'">
			<br><h2><strong>'.$row['nome'].'</strong></h2><input type="hidden" id="codice_'.$i.'" name="codice" value="'.$codice_prodotto.'">
			<h3>Colore: '.$row['colore'].'
			<br>Costo: '.$row['prezzo'].' euro';
			echo '<br>Taglia: <select name="taglia" id="taglia_'.$i.'">';
			foreach($db->query("SELECT * FROM dettagli WHERE codice_prodotto='$codice_prodotto'") as $row2) {
				echo '<option>'.$row2['taglia'].'</option>';
			}
			echo '</select><br>Quantità: <input name="quantita" id="quantita_'.$i.'" type="text" value="1" size="1" maxlength="3" />';
			echo '<br><br><a href=""><button class="bottone" id="bottone_'.$i.'" onmousedown=\'carica_carrello("'.$i.'");\'">Aggiungi al carrello</button></a></td></h3>';
			if(($i+1)%4==0)
				echo '</tr>';
			$i++;
		}
	} else {
		echo '<div id="categoria"><strong>Di tendenza!</strong></div>';
    	echo '<table>';
		$i=0;
		foreach($db->query("SELECT * FROM prodotti ORDER BY codice_prodotto DESC LIMIT 16") as $row) {
			if($i%4==0)
				echo '<tr>';
			$codice_prodotto=$row['codice_prodotto'];
			echo '<td id="elem_td_'.$i.'"><img src="'.$row['immagine'].'" width="275px" height="275px" alt="immagine '.$codice_prodotto.'">
			<br><h2><strong>'.$row['nome'].'</strong></h2><input type="hidden" id="codice_'.$i.'" name="codice" value="'.$codice_prodotto.'">
			<h3>Colore: '.$row['colore'].'
			<br>Costo: '.$row['prezzo'].' euro';
			echo '<br>Taglia: <select name="taglia" id="taglia_'.$i.'">';
			foreach($db->query("SELECT * FROM dettagli WHERE codice_prodotto='$codice_prodotto'") as $row2) {
				echo '<option>'.$row2['taglia'].'</option>';
			}
			echo '</select><br>Quantità: <input name="quantita" id="quantita_'.$i.'" type="text" value="1" size="1" maxlength="3" />';
			echo '<br><br><a href=""><button class="bottone" id="bottone_'.$i.'" onmousedown=\'carica_carrello("'.$i.'");\'">Aggiungi al carrello</button></a></td></h3>';
			if(($i+1)%4==0)
				echo '</tr>';
			$i++;
		}
	}
	?>
	</table>
  </div>
  <footer id="elem_footer">
      <a href="diritto_recesso.php">diritto recesso</a>
      <a href="privacy_cookie.php">privacy e cookie</a>
      <a href="informazioni_sfilate.php">Informazioni sfilate</a>
  </footer>
</body>
</html>
