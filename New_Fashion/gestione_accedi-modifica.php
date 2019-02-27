<?php
session_start();
require("connessione.php");
	
$user=$_POST['email'];
if(isset($_POST['submit_accedi'])) { //si vuole accedere
	$errore="";
	$password=$_POST['password'];

	if(empty($user) || empty($password)) {
		$errore = "Tutti i campi sono obbligatori!";
		echo "<script>window.alert('$errore')
		window.location.href=history.go(-1);</script>";	
	}
	else {
		$find=$db->prepare("SELECT * FROM utenti WHERE email='$user' AND password='$password'"); //cerco utente
		$find->execute();
		$res=$find->fetchAll();
		if (!$res) { //se non ho risultati
			$find2=$db->prepare("SELECT * FROM utenti WHERE email='$user'"); //cerco email
			$find2->execute();
			$res2=$find2->fetchAll();
			if (!$res2) //se non ho risultati vuol dire che l'email è proprio inesistente nel db
				$errore="Email errata.";
			else //atrimenti è la password ad essere sbagliata
				$errore="Password errata.";
			echo "<script>window.alert('$errore')
			window.location.href=history.go(-1);</script>";	
		} else { //ho ottenuto risultati
			$_SESSION['email']=$user; //inizio sessione
			if(isset($_COOKIE['carrello_nf'])) { //se erano presenti prodotti nel carrello senza aver eseguito l'accesso allora..
				$carrello=$_COOKIE['carrello_nf'];
				foreach($db->query("SELECT codice_carrello FROM utenti WHERE email='$user'") as $row) //cerco codice carrello
					$carrello_utente=$row['codice_carrello'];
				$query2=$db->prepare("UPDATE carrello_prodotti SET codice_carrello='$carrello_utente' WHERE codice_carrello='$carrello'"); //aggiorno il codice del carrello con quello dell'utente che ha appena eseguito l'accesso
				$query2->execute();
				$query=$db->prepare("DELETE FROM carrello WHERE codice_carrello='$carrello'"); //elimino il vecchio codice del carrello dell'utente senza accesso
				$query->execute();
			}
			setcookie('carrello_nf', null, time()-3600);
			header("location:home.php");
		}
	}		
} else if(isset($_POST['submit_modifica'])) { //si vuole modificare il profilo
	$linea_preferita=($_POST['linea_pref']); 
	$capo_preferito=($_POST['capo_pref']);
	$colore_sfondo=($_POST['colore_sfondo']); 
	$colore_elementi=($_POST['colore_elementi']);
	if ($linea_preferita=="Scegli.." || $capo_preferito=="Scegli..") 
		echo "<script>window.alert('Linea preferita o capo preferito non valido!')
		 window.location.href=history.go(-1);</script>";
	$query=$db->prepare("UPDATE utenti SET linea_preferita='$linea_preferita',capo_preferito='$capo_preferito',colore_sfondo='$colore_sfondo',colore_elementi='$colore_elementi' WHERE email='$user'"); //aggiorno i dati della tabella utenti
	$query->execute();
	echo "<script>window.alert('Salvataggio preferenze effettuato con successo')
	 window.location.href='home.php';</script>";	
}
else if(isset($_POST['submit_password'])) { //si vuole modificare la password
	$password=$_POST['password'];
	$password_conferma=$_POST['password_conf'];
	if(empty($password) || empty($password_conferma))
		echo "<script>window.alert('Tutti i campi devono essere compilati per poter modificare la password!')
		window.location.href=history.go(-1);</script>";
	else if($password==$password_conferma) {
		$query=$db->prepare("UPDATE utenti SET password='$password' WHERE email='$user'"); //aggiorno i dati della tabella utenti
		$query->execute();
		echo "<script>window.alert('Salvataggio nuova password effettuato con successo')
	window.location.href='home.php';</script>";
	} else {
		echo "<script>window.alert('I campi password e conferma password non corrispondono, inserire nuovamente i valori!')
	window.location.href=history.go(-1);</script>";
	}
}
?>