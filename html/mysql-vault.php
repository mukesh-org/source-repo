<?php

{{- with secret "secret/myapp/config" }}
  <ul>
  <li><pre>$username: {{ .Data.username }}</pre></li>
  <li><pre>$password: {{ .Data.password }}</pre></li>
  </ul>
{{ end }}

$servername = "35.244.31.183";
$username = "abcd"
$password = "abcd"
try {
    $conn = new PDO("mysql:host=$servername;dbname=my_db", $username, $password);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected successfully using Vault credentials"; 
    }
catch(PDOException $e)
    {
    echo "Connection failed: " . $e->getMessage();
    }
?>
