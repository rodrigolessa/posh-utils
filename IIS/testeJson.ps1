$json = @"{"Stuffs":[{"Name": "Darts","Type": "Fun Stuff"},{"Name": "Clean Toilet","Type":"Boring Stuff"}]}"@

$x = $json | ConvertTo-Json;

$x.Stuffs[0]; # access to Darts
$x.Stuffs[1]; # access to Clean Toilet

$use = Read-Host "Teste!";