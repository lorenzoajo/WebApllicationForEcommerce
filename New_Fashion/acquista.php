<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Acquista</title>
<link href="css/acqCSS.css" rel="stylesheet" type="text/css">
</head>
	<?php
	session_start();
	require_once("connessione.php");
	foreach($db->query("SELECT * FROM utenti WHERE email='$_SESSION[email]'") as $row) {
		$utente=$row['nome'];
		$cognome_utente=$row['cognome'];
		$carrello=$row['codice_carrello'];
		$indirizzo=$row['indirizzo'];
		$citta=$row['citta'];
		$nazione=$row['nazione'];
		$colore_sfondo=$row['colore_sfondo'];
		$colore_elementi=$row['colore_elementi'];
	}
    ?>
<body onload="cambia_colori('<?php echo $colore_sfondo; ?>','<?php echo $colore_elementi; ?>')">
  <header id="elem_header">
    <img src="img/logo.png" id="logo" height="100px" alt="logo">
	<a href="esci.php">Esci</a>
    <a href="profilo.php">Benvenuto <?php echo $utente ?></a>
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
    <div id="scritte"><strong>Procedura di acquisto</strong><br><br>
    	<?php
		$totale=$_GET['tot'];
		do {
			$codice_ordine=rand(100,999999);
			$exist=$db->prepare("SELECT * FROM ordini WHERE codice_ordine='$codice_ordine'");
			$exist->execute();
			$count=$exist->rowCount();
		} while($count>0);
		do {
			$codice_spedizione=rand(100,999999);
			$exist=$db->prepare("SELECT * FROM ordini WHERE codice_spedizione='$codice_spedizione'");
			$exist->execute();
			$count=$exist->rowCount();
		} while($count>0);
		?>
    	<form id="form_acquisto" action="gestione_acquisto.php" method="post">
  		Codice ordine n. <?php echo $codice_ordine ?><br>
        Nome itestatario fattura: <?php echo $utente . ' ' . $cognome_utente ?><br><br>
        Elenco prodotti:<br>
        <?php
		foreach($db->query("SELECT * FROM carrello_prodotti WHERE codice_carrello='$carrello'")as $row) {
			$prodotto=$row['codice_prodotto'];
			$quantita_s=$row['quantita_scelta'];
			foreach($db->query("SELECT * FROM prodotti WHERE codice_prodotto='$prodotto'")as $row2) {
				$prezzo=$row2['prezzo'];
				$costo_t_prod=$prezzo*$quantita_s;
				echo '-->('.$quantita_s.')  '.$row2['nome'].' '.$row2['colore'].' ('.$row2['categoria'].'), costo '.$costo_t_prod.' euro<br>';
			}
		}
		if($totale<30) {
        	echo 'Costo spedizione: 2,50 euro<br>';
			$totale=$totale+2.50;
		}
		else
        	echo 'Costo spedizione: 0 euro<br>';
		?>
        Costo totale: <?php echo $totale ?> euro<br><br>
        Metodo di pagamento:
        <select id="pagamento" name="pagamento" id="pagamento">
        <option>Carta di credito</option>
        <option>Contrassegno</option>
        <option>Paypal</option>
        </select><br><br>
        Luogo di consegna:<br>
		<input name="consegna" type="text" size="40" maxlength="200" /><br>
        Codice spedizione n.
		<?php
		echo $codice_spedizione .'<br>
        <input type="hidden" name="ordine" value='.$codice_ordine.'><input type="hidden" name="spedizione" value='.$codice_spedizione.'>
        <input type="hidden" name="tot" value='.$totale.'>';
		?>
        <br><br><input type="submit" name="submit_acquisto" value="Conferma" class="bottone"/>
    </form>
  	</div>
  </div>
  <script>
  function cambia_colori(colore_sfondo, colore_elementi) {
        document.getElementById('container').style.backgroundColor = colore_sfondo;
        document.getElementById('elem_header').style.backgroundColor = colore_elementi;
        document.getElementById('elem_footer').style.backgroundColor = colore_elementi;
        var i;
        for(i=0; i<100; i++)
            document.getElementById('elem_td_' + i).style.backgroundColor = colore_elementi;
  }
  </script>
  <footer id="elem_footer">

    <a href="informazioni_ordini.php">Informazioni ordini</a>
    <a href="informazioni_spedizioni.php">Informazioni spedizioni</a>
    <a href="informazioni_sfilate.php">Informazioni sfilate</a>
  </footer>
</body>
</html>
