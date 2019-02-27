<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>New Fashion - Accedi</title>
<link href="css/accediCSS.css" rel="stylesheet" type="text/css">
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
	  require("connessione.php");
      foreach($db->query("SELECT * FROM linee") as $row)
        echo '<a href="'.$row['categoria'].'.php">'.$row['categoria'].'</a>';
      ?>
      <a href="sfilate.php">Sfilate</a>
  </div>
  <div id="container">
  	<div id="scritte"><strong>Accedi</strong></div>
  	<form id="form_accedi" action="gestione_accedi-modifica.php" method="post">
  		<h3>Inserisci la tua email:</h3>
  		<input name="email" type="text" size="40" maxlength="200" />
  		<h3>Inserisci la password:</h3>
  		<input name="password" type="password" size="40" maxlength="200" />
        <br><br><input type="submit" name="submit_accedi" value="Avanti" class="bottone"/>
    </form>
  </div>
  <footer>

      <a href="diritto_recesso.php">diritto recesso</a>
      <a href="privacy_cookie.php">privacy e cookie</a>
      <a href="informazioni_sfilate.php">Informazioni sfilate</a>
  </footer>
</body>
</html>
