<?php
echo "<h1>Hello World from PHP8.2-FPM</h1>";
echo 'Version PHP courante : ' . phpversion();

echo '<pre>';
//print_r($_ENV["MARIADB_DATABASE"]);
try{
     $conn = new \PDO('mysql:host=stack_php_mariadb;dbname=test', 'test', 'roottoor');
     $sth = $conn->prepare('SELECT * FROM pays');
     $sth->execute();
     $checks = $sth->fetchAll(PDO::FETCH_ASSOC);
     foreach ($checks as $check) {

     print_r($check);
     }
   }
   catch(\Exception $e){
       print_r($e);
   }
   echo '</pre>';
?>
