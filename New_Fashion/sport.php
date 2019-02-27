<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Linea sport</title>
<link href="css/sportCSS.css" rel="stylesheet" type="text/css">
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
  	  <div id="box_link">

        <div id="link_0" class="link"><a href="prodotto.php?cat=sport&val=pile donna" style="font-size: 29.5px;"><b>Pile donna</b></a></div>
        <div id="link_1" class="link"><a href="prodotto.php?cat=sport&val=pile uomo"><b>Pile uomo</b></a></div>
        <div id="link_2" class="link"><a href="prodotto.php?cat=sport&val=pantaloni"><b>Pantaloni</b></a></div>
        <div id="link_3" class="link"><a href="prodotto.php?cat=sport&val=berretti"><b>Berretti</b></a></div>
        <div id="link_4" class="link"><a href="prodotto.php?cat=sport&val=guanti"><b>Guanti</b></a></div>
        <div id="link_5" class="link"><a href="prodotto.php?cat=sport&val=t-shirt donna" style="font-size: 22.8px;"><b>T-shirt donna</b></a></div>
        <div id="link_6" class="link"><a href="prodotto.php?cat=sport&val=t-shirt uomo" style="font-size: 25px;"><b>T-shirt uomo</b></a></div>
        <div id="link_7" class="link"><a href="prodotto.php?cat=sport&val=scaldacollo" style="font-size: 27.5px;"><b>Scaldacollo</b></a></div>
        <div id="link_8" class="link"><a href="prodotto.php?cat=sport&val=giacche"><b>Giacche</b></a></div>
        <div id="link_9" class="link"><a href="prodotto.php?cat=sport&val=scarpe"><b>Scarpe</b></a></div>
      </div>
      <div id="categoria"><strong>Tutti i prodotti: abbigliamento sport</strong></div>
	  <table>
			<?php
			require("connessione.php");
            $i=0;
            foreach($db->query("SELECT * FROM prodotti WHERE categoria='sport' ORDER BY codice_prodotto DESC") as $row) {
                if($i%4==0)
                    echo '<tr>';
				$codice_prodotto=$row['codice_prodotto'];
				echo '<td id="elem_td_'.$i.'"><img src="'.$row['immagine'].'" width="275px" height="275px" alt="immagine '.$codice_prodotto.'">
				<br><h2><strong>'.$row['nome'].'</strong></h2><input type="hidden" id="codice_'.$i.'" value="'.$codice_prodotto.'">
				<h3>Colore: '.$row['colore'].'
				<br>Costo: '.$row['prezzo'].' euro';
				echo '<br>Taglia: <select name="taglia" id="taglia_'.$i.'">';
				foreach($db->query("SELECT * FROM dettagli WHERE codice_prodotto='$codice_prodotto'") as $row2) {
					echo '<option>'.$row2['taglia'].'</option>';
				}
				echo '</select><br>Quantità: <input name="quantita" id="quantita_'.$i.'" type="text" value="1" size="1" maxlength="3" />';
				echo '<br><br><a href=""><button class="bottone" id="bottone_'.$i.'" onmousedown=\'carica_carrello("'.$i.'");\'>Aggiungi al carrello</button></a></td></h3>';
				if(($i+1)%4==0)
					echo '</tr>';
				$i++;
            }
            ?>
	  </table>
	  <script>
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
		for(i=0; i<10; i++)
			document.getElementById('link_' + i).style.backgroundColor = colore_elementi;
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
