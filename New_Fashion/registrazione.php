<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Registrazione</title>
<link href="css/registrazioneCSS.css" rel="stylesheet" type="text/css">
</head>
<body>
  <header>
    <img src="img/logo.png" id="logo" height="100px" alt="logo">
    <a href="registrazione.php">Registrati</a>
    <a href="accedi.php">Accedi</a>
    <a href="carrello.php">Carrello</a>
  </header>
  <div id="nav">
      <a href="home.php">Home</a>
      <?php
	  require_once("connessione.php");
      foreach($db->query("SELECT * FROM linee") as $row)
        echo '<a href="'.$row['categoria'].'.php">'.$row['categoria'].'</a>';
      ?>
      <a href="sfilate.php">Sfilate</a>
  </div>
  <div id="container">
	<div id="scritte"><strong>Registrazione</strong></div>
    <form id="form_registrazione" action="gestione_registrazione.php" method="post">
        <h3>Nome: *</h3>
        <input name="nome" type="text" size="40" maxlength="50" />
        <h3>Cognome: *</h3>
        <input name="cognome" type="text" size="40" maxlength="50" />
        <h3>Data di nascita:</h3>
        <input name="data" type="date"/>
        <h3>Indirizzo: *</h3>
        <input name="indirizzo" type="text" size="40" maxlength="50" />
        <h3>Città: *</h3>
        <input name="citta" type="text" size="40" maxlength="50" />
        <h3>Nazione: *</h3>
        <input name="nazione" type="text" size="40" maxlength="50" />
        <h3>Email: *</h3>
        <input name="email" type="email" size="40" maxlength="50" />
        <h3>Password: *</h3>
        <input name="password" type="password" size="40" maxlength="50" />
        <h3>Conferma password: *</h3>
        <input name="password_conf" type="password" size="40" maxlength="50" />
        <h3>Linea di abbigliamento preferita: *</h3>
        <?php
        echo '<select id="linea_pref" name="linea_pref" onclick="carica_abbigliamento(this.value)"><option>Scegli..</option>';
        foreach($db->query("SELECT categoria FROM linee") as $row)
            echo '<option value="'.$row['categoria'].'">'.$row['categoria'].'</option>';
        echo '</select>';
        ?>

        <h3>Capo d'abbigliamento preferito: *</h3>
        <select id="capo_pref" name="capo_pref"><option>Scegli..</option></select><br>

        <h3>Scegli il colore dello sfondo:</h3>
        <input name="colore_sfondo" type="color" value="#FFFFFF" />
        <h3>Scegli il colore degli elementi nella pagina:</h3>
        <input name="colore_elementi" type="color" value="#6D8FF9" />
        <p>I campi con * sono obbligatori</p>
        <br><br><input type="submit" name="submit_registrazione" value="Avanti" class="bottone"/>
    </form>
	<script>
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
	}
    </script>
  </div>
  <footer>
      <a href="diritto_recesso.php">diritto recesso</a>
      <a href="privacy_cookie.php">privacy e cookie</a>
      <a href="informazioni_sfilate.php">Informazioni sfilate</a>
  </footer>
</body>
</html>
