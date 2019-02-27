<?php
	$user="root";
	$password="";
	$server="localhost";
	$database="new_fashion";
	$col='mysql:host=localhost;dbname=new_fashion';
	$db=new PDO($col, $user, $password);
	
	try{
		$db=new PDO($col, $user, $password);
	}catch(PDOException $e){
		echo 'Errore nel stabilire la connessione con il database' . $e->getMessage();
	}
?>