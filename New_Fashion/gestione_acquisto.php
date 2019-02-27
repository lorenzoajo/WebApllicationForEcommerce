<?php
session_start();
require("connessione.php");

$codice_ordine=$_POST['ordine'];
$codice_spedizione=$_POST['spedizione'];
$totale_c=$_POST['tot'];
$consegna=$_POST['consegna'];
$pagamento=$_POST['pagamento'];

if(empty($consegna))
	echo "<script>window.alert('Inserire il luogo di consegna')
	window.location.href=history.go(-1);</script>";
else {
	$user=$_SESSION['email']; //non faccio il controllo se la sessione esiste perchè si arriva qui solo se si ha già eseguito l'accesso
	foreach($db->query("SELECT codice_carrello FROM utenti WHERE email='$user'") as $row) //cerca codice carrello
		$carrello=$row['codice_carrello'];
	$flag=0;
	foreach($db->query("SELECT * FROM carrello_prodotti WHERE codice_carrello='$carrello'") as $row) { //scorro prodotti nel carrello
		$codice=$row['codice_prodotto'];
		$t=$row['taglia_scelta'];
		$q=$row['quantita_scelta']; //quantità desiderata dall'utente
		
		foreach($db->query("SELECT quantita FROM dettagli WHERE codice='$codice' AND taglia='$t'") as $row2) //carca quantità del prodotto
			$tot_quant=$row2['quantita']; //quantità disponibili in magazzino
		if($tot_quant<$q) {
			$flag=1;
			echo "<script>window.alert('Quantità prodotto di codice $codice di taglia $t non è disponibile, attende un paio di giorni oppure diminuire quantità prodotto')
	window.location.href=history.go(-1);</script>";
		}
	}
	if($flag!=1) { //se la quantità del prodotto richiesta non è più grande di quella disponibile
		$query_ins=$db->prepare("INSERT INTO ordini (codice_ordine,prezzo_totale,metodo_di_pagamento,codice_spedizione,email) VALUES ('$codice_ordine','$totale_c','$pagamento','$codice_spedizione','$user')"); //inserisco dati nella tabella ordini
		$query_ins->execute();
		
		foreach($db->query("SELECT * FROM carrello_prodotti WHERE codice_carrello='$carrello'") as $row) { //scorro prodotti nel carrello
			$codice_prodotto=$row['codice_prodotto'];
			$taglia=$row['taglia_scelta'];
			$quantita=$row['quantita_scelta'];
			
			$query=$db->prepare("INSERT INTO ordini_prodotti (codice_ordine,codice_prodotto,taglia,quantita) VALUES ('$codice_ordine','$codice_prodotto','$taglia','$quantita')"); //inserisco i prodotti nellla tabella ordini_prodotti
			$query->execute();
			
			foreach($db->query("SELECT quantita FROM dettagli WHERE codice='$codice_prodotto' AND taglia='$taglia'") as $row) //cerco quantità dei prodotti nel magazzino
				$tot_quant=$row['quantita'];
			$tot_quant=$tot_quant-$quantita; //decremento la quantità in base a quanti prodotti sono stati acquistati
			
			$query2=$db->prepare("UPDATE dettagli SET quantita='$tot_quant' WHERE codice='$codice_prodotto' AND taglia='$taglia'"); //aggiorno quantità
			$query2->execute();
		}
		
		$query3=$db->prepare("DELETE FROM carrello_prodotti WHERE codice_carrello='$carrello'"); //elimino prodotti dal carrello
		$query3->execute();
		
		echo "<script>window.alert('Pagamento effettuato con successo :)')
		window.location.href='elenco_ordini.php';</script>";
	}
}
?>