<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Carrello</title>
<link href="css/carrelloCSS.css" rel="stylesheet" type="text/css">
</head>
	<?php
    session_start();
    require_once("connessione.php");
	$x=1;
    if(isset($_SESSION['email'])){
        foreach($db->query("SELECT * FROM utenti WHERE email='$_SESSION[email]'") as $row) {
            $utente=$row['nome'];
            $colore_sfondo=$row['colore_sfondo'];
            $colore_elementi=$row['colore_elementi'];
			$carrello=$row['codice_carrello'];
        }
	} else if(isset($_COOKIE['carrello_nf']))
		$carrello=$_COOKIE['carrello_nf'];
	else
		$x=0;
    ?>
<body onload="cambia_colori('<?php echo $colore_sfondo; ?>','<?php echo $colore_elementi; ?>')">
  <header id="elem_header">
    <img src="img/logo.png" id="logo" height="100px" alt="logo">
	<?php
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
    <div id="scritte"><strong>Carrello</strong></div>
    <table>
    	<?php
		$i=0;
		if($x!=0) {
			$costo_tot=0;
			foreach($db->query("SELECT * FROM carrello_prodotti WHERE codice_carrello='$carrello'") as $row) {
				$codice_prodotto=$row['codice_prodotto'];
				foreach($db->query("SELECT * FROM prodotti WHERE codice_prodotto='$codice_prodotto'") as $row2) {
					if($i%4==0)
						echo '<tr>';
					echo '<td id="elem_td_'.$i.'"><img src="'.$row2['immagine'].'" width="275px" height="275px" alt="immagine '.$codice_prodotto.'">
					<br><h2><strong>'.$row2['nome'].'</strong></h2>';
					$quantita_scelta=$row['quantita_scelta'];
					$prezzo=$row2['prezzo'];
					$costo_t_prod=$prezzo*$quantita_scelta;
					echo '<input type="hidden" id="codice_'.$i.'" value='.$codice_prodotto.'><input type="hidden" id="taglia_'.$i.'" value="'.$row['taglia_scelta'].'">
					<h3>Codice prodotto: '.$codice_prodotto.'<br>Colore: '.$row2['colore'].'
					<br>Costo: '.$costo_t_prod.' euro';
					$costo_tot+=$costo_t_prod;
					echo '<br>Taglia: '.$row['taglia_scelta'].'<br>Quantità: '.$quantita_scelta.'';
					echo '<br><br><a href=""><button class="bottone" id="rimuovi_'.$i.'" onmousedown=\'elimina_prodotto("'.$i.'");\'>Rimuovi prodotto</button></a></td></h3>';
					if(($i+1)%4==0)
						echo '</tr>';
					$i++;
				}
			}
		}
		echo '</table>';
		if($i==0)
			echo '<div id="scritte">Nessun prodotto nel carrello</div>';
		else {
			echo '<div id="scritte">Totale costo dei prodotti nel carretto: '.$costo_tot.' euro</div>';
			if(isset($_SESSION['email']))
				echo '<a href="acquista.php?tot='.$costo_tot.'"><button class="bottone2">Prosegui al pagamento</button></a>';
			else
				echo '<button class="bottone2" onclick=\'alert("Devi essere registrato per poter effettuare un acquisto");\'>Prosegui al pagamento</button>';
		}
		?>
	  <script>
	  function elimina_prodotto(id) {  //id è il numero della cella del prodotto che si vuole mettere nel carrello
      	var parent = document.getElementById('rimuovi_'+id).parentNode;
      	var path = "gestione_carrello.php?prod="+document.getElementById('codice_'+id).value+"&taglia="+document.getElementById('taglia_'+id).value+"&flag=1";
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
  	  </div>
  <footer id="elem_footer">
	  <a href="diritto_recesso.php">diritto recesso</a>
      <a href="privacy_cookie.php">privacy e cookie</a>
      <a href="informazioni_sfilate.php">Informazioni sfilate</a>
  </footer>
</body>
</html>
