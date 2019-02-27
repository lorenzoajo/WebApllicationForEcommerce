<?php
session_start();
require_once("connessione.php");
	
$codice_prodotto=$_GET['prod'];
$taglia=$_GET['taglia'];
$quantita=$_GET['quant'];
$flag=$_GET['flag'];

if(isset($_SESSION['email'])) { //se c'è una sessione aperta
	foreach($db->query("SELECT codice_carrello FROM utenti WHERE email='$_SESSION[email]'") as $row) //cerca codice carrello
		$codice_carrello=$row['codice_carrello'];
	if($flag==0) //flag 0 corrisponde all'inserimento
		$query=$db->prepare("INSERT INTO carrello_prodotti (codice_carrello, codice_prodotto, taglia_scelta, quantita_scelta) VALUES ('$codice_carrello','$codice_prodotto','$taglia','$quantita')"); //inserisco il prodotto selezionato nella tabella carrello_prodotto
	else //flag 1 corrisponde all'eliminazione
		$query=$db->prepare("DELETE FROM carrello_prodotti WHERE codice_carrello='$codice_carrello' AND codice_prodotto='$codice_prodotto' AND taglia_scelta='$taglia'"); //elimino il prodotto selezionato dalla tabella corrello_prodotti
} else { //se la sessione non è aperta e quindi l'utente vuole eseguire l'azione senza l'accesso
	if(isset($_COOKIE['carrello_nf'])) //se è già stato assegnato un codice carrello all'utente
		$carrello=$_COOKIE['carrello_nf'];
	else {
		do { //definisco un codice valido per il carrello dell'utente
			$carrello=rand(100,9999);
			$exist=$db->prepare("SELECT * FROM carrello WHERE codice_carrello='$carrello'");
			$exist->execute();
			$count=$exist->rowCount();
		} while(count==1);
		setcookie('carrello_nf', $carrello, time()+(60*60*24*30*6)); //circa 6 mesi
		$query_ins=$db->prepare("INSERT INTO carrello (codice_carrello) VALUES ('$carrello')"); //inserisco il codice nella tabella carrello
		$query_ins->execute();
	}
	if($flag==0) //flag 0 corrisponde all'inserimento
		$query=$db->prepare("INSERT INTO carrello_prodotti (codice_carrello, codice_prodotto, taglia_scelta, quantita_scelta) VALUES ('$carrello','$codice_prodotto','$taglia','$quantita')"); //inserisco il prodotto selezionato nella tabella carrello_prodotto
	else //flag 1 corrisponde all'eliminazione
		$query= $db->prepare("DELETE FROM carrello_prodotti WHERE codice_carrello='$carrello' AND codice_prodotto='$codice_prodotto' AND taglia_scelta='$taglia'");	//elimino il prodotto selezionato dalla tabella corrello_prodotti	
}
$query->execute();
header("location:carrello.php");
?>