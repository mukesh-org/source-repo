<!DOCTYPE html>
<html>
<body>

<h1>This is a PHP page using Skaffold Docker image and FLUX</h1>

<?php
echo "Hello Kubernetes! PR 1234!! postjob-check done.";
?> 

  <p>Some secrets from vault:</p>
  
  {{- with secret "secret/myapp/config" }}
  <ul>
  <li><pre>username: {{ .Data.username }}</pre></li>
  <li><pre>password: {{ .Data.password }}</pre></li>
  </ul>
  {{ end }}
  
</body>
</html>
