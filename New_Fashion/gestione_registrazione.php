<?php
session_start();
require("connessione.php");

$nome=$_POST['nome'];
$cognome=$_POST['cognome'];
$data_di_nascita=$_POST['data'];
$indirizzo=$_POST['indirizzo'];
$citta=$_POST['citta'];
$nazione=$_POST['nazione'];
$email=$_POST['email'];
$password=$_POST['password'];
$password_conferma=$_POST['password_conf'];
$linea_preferita=$_POST['linea_pref'];
$capo_preferito=$_POST['capo_pref'];
$colore_sfondo=$_POST['colore_sfondo'];
$colore_elementi=$_POST['colore_elementi'];

$errore = $invalErr = "";

if(empty($nome)||empty($cognome)||empty($indirizzo)||empty($citta)||empty($nazione)||empty($email)||empty($password)||empty($password_conferma)) {
	$errore = 'Tutti i campi con * sono obbligatori!';
	echo "<script>window.alert('$errore')
	window.location.href='registrazione.php';</script>";
} else {
	if (!preg_match("/^[a-zA-Z ]*$/", $nome))
		$invalErr .= "nome / ";

	if (!preg_match("/^[a-zA-Z ]*$/", $cognome))
		$invalErr .= "cognome / ";

	if (!preg_match("/^[a-zA-Z0-9\.\- ]*$/", $indirizzo))
		$invalErr .= "indirizzo / ";

	if (!preg_match("/^[a-zA-Z-(-) ]*$/", $citta))
		$invalErr .= "città / ";

	if (!preg_match("/^[a-zA-Z ]*$/", $nazione))
		$invalErr .= "nazione / ";

	/*function email_exist($email) {
		if (!filter_var($email, FILTER_VALIDATE_EMAIL)) return false;
		elseif (!checkdnsrr(array_pop(explode('@',$email)),'MX')) return false;
		else return true;
	}

	// verifica esistenza indirizzo e-mail
	if (!email_exist('esempio@dominio-inesistente.com')) echo 'Email inesistente';
	else echo 'Email valida';*/

	filter_var($email, FILTER_VALIDATE_EMAIL);
	$exist=$db->prepare("SELECT email FROM utenti WHERE email='$email'");
	$exist->execute();
	$count=$exist->rowCount();
	if($count>0)
		$invalErr .= "email di utente già registrato / ";

	if($password != $password_conferma)
		$invalErr .= "le password non corrispondono / ";

	if (strcmp($linea_preferita, "Scegli..") == 0)
		$invalErr .= "linea d\'abbigliamento / ";

	if(strcmp($capo_preferito, "Scegli..") == 0)
		$invalErr .= "capo d\'abbigliamento";

	if(!empty($invalErr)) {
		echo "<script>window.alert('Attenzione, campi non validi: $invalErr')
		window.location.href='registrazione.php';</script>";
	} else {
		do { //definisco un codice valido per il carrello dell'utente appena registrato
			$carrello_utente=rand(100,9999);
			$exist=$db->prepare("SELECT * FROM carrello WHERE codice_carrello='$carrello_utente'");
			$exist->execute();
			$count=$exist->rowCount();
		} while($count>0);

		$query_ins=$db->prepare("INSERT INTO carrello (codice_carrello) VALUES ('$carrello_utente')"); //inserisco il codice nella tabella carrello
		$query_ins->execute();

		$query=$db->prepare("INSERT INTO utenti (nome, cognome, data_di_nascita, indirizzo, citta, nazione, email, password, linea_preferita, capo_preferito, colore_sfondo, colore_elementi, codice_carrello) VALUES ('$nome','$cognome','$data_di_nascita','$indirizzo','$citta','$nazione','$email','$password','$linea_preferita','$capo_preferito','$colore_sfondo','$colore_elementi','$carrello_utente')"); //inserisco i dati di registrazione della tabella utenti
		$query->execute();

		$_SESSION['email']=$email; //inizio sessione
		if(isset($_COOKIE['carrello_nf'])) { //se erano presenti prodotti nel carrello senza aver eseguito l'accesso allora..
			$carrello=$_COOKIE['carrello_nf'];
			$query2=$db->prepare("UPDATE carrello_prodotti SET codice_carrello='$carrello_utente' WHERE codice_carrello='$carrello'"); //aggiorno il codice del carrello con quello dell'utente appena registrato
			$query2->execute();
			$query3=$db->prepare("DELETE FROM carrello WHERE codice_carrello='$carrello'"); //elimino il vecchio codice del carrello dell'utente senza accesso
			$query3->execute();
			setcookie('carrello_fn', null, time()-3600); //annullo il cookie
		}

		echo "<script>window.alert('Registrazione effettuata con successo :)')
				window.location.href='home.php';</script>";
	}
}
?>
