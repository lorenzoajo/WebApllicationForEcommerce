<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Profilo</title>
<link href="css/profiloCSS.css" rel="stylesheet" type="text/css">
</head>
	<?php
	session_start();
	require_once("connessione.php");
	foreach($db->query("SELECT * FROM utenti WHERE email='$_SESSION[email]'") as $row) {
		$utente=$row['nome'];
		$email=$row['email'];
		$colore_sfondo=$row['colore_sfondo'];
		$colore_elementi=$row['colore_elementi'];
		$linea_preferita=$row['linea_preferita'];
		$capo_preferito=$row['capo_preferito'];
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
    <div id="scritte"><strong>Profilo utente</strong><br><br>
    	<?php
		foreach($db->query("SELECT * FROM utenti WHERE email='$email'") as $row) {
			echo 'Nome: '.$row['nome'].'<br>Cognome: '.$row['cognome'].'<br>';
			echo 'Data di nascita: '.$row['data_di_nascita'].'<br>Indirizzo: '.$row['indirizzo'].'<br>';
			echo 'Città: '.$row['citta'].'<br>Nazione: '.$row['nazione'].'<br>';
			echo 'Email(username): '.$email.'<br>';
			echo '<form id="form_modifica" action="gestione_accedi-modifica.php" method="post">Linea di abbigliamento preferita: ';
			echo '<select id="linea_pref" name="linea_pref" onchange=\'carica_abbigliamento(this.value);\'"><option>'.$linea_preferita.'</option>';
        	foreach($db->query("SELECT categoria FROM linee") as $row)
            	echo '<option>'.$row['categoria'].'</option>';
        	echo '</select><br>Capo d\'abbigliamento preferito: <select id="capo_pref" name="capo_pref" onchange="ableElement()"><option>'.$capo_preferito.'</option></select>';
        	echo '<br>Scegli il colore dello sfondo: <input name="colore_sfondo" type="color" value="'.$colore_sfondo.'" onchange="ableElement()" />';
        	echo '<br>Scegli il colore degli elementi nella pagina: <input name="colore_elementi" type="color" value="'.$colore_elementi.'" onchange="ableElement()" />';
			echo '<input type="hidden" name="email" value="'.$email.'">';
			echo '<br><br><input id="modifica" type="submit" name="submit_modifica" value="Salva modifiche" class="bottone" hidden="true" /></form>';
		}
		?>
        <h2>-----------------------------------------------</h2>
        <form id="form_modifica" action="gestione_accedi-modifica.php" method="post"><strong>Cambia password</strong><br><br>
        <input type="hidden" name="email" value="<?php echo $email ?>">
        Inserisci una nuova password:
        <input name="password" type="password" size="30" maxlength="50" />
        <br>Conferma password:
        <input name="password_conf" type="password" size="30" maxlength="50" />
        <br><br><input id="cambia_password" type="submit" name="submit_password" value="Salva nuova password" class="bottone"/>
        </form>
        <h2>-----------------------------------------------</h2>
        Per visualizzare l'elenco dei prodotti già acquistati premi <a href="elenco_ordini.php">qui.<a>
  	</div>
  </div>
  <script>
  function ableElement() {
	document.getElementById('modifica').hidden=false;
  }

  function carica_abbigliamento(type) {
	document.getElementById('capo_pref').innerHTML = '<option>Scegli..</option>';
	if(type=="donna") {
		<?php
		foreach($db->query("SELECT DISTINCT nome FROM prodotti WHERE categoria='donna'") as $row)
			echo "document.getElementById('capo_pref').innerHTML += '<option>".$row['nome']."</option>';";
		?>;
	} else if(type=="sport") {
		<?php
		foreach($db->query("SELECT DISTINCT nome FROM prodotti WHERE categoria='sport'") as $row)
			echo "document.getElementById('capo_pref').innerHTML += '<option>".$row['nome']."</option>';";
		?>;
	} else if(type=="uomo") {
		<?php
		foreach($db->query("SELECT DISTINCT nome FROM prodotti WHERE categoria='uomo'") as $row)
			echo "document.getElementById('capo_pref').innerHTML += '<option>".$row['nome']."</option>';";
		?>;
	}
	ableElement();
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
  <footer id="elem_footer">
	  <a href="diritto_recesso.php">diritto recesso</a>
      <a href="privacy_cookie.php">privacy e cookie</a>
      <a href="informazioni_sfilate.php">Informazioni sfilate</a>
  </footer>
</body>
</html>
