<?php
// Create connection
$con = mysqli_connect("HOSTADDRESS","DATABASE","PASSWORD","TABLE");

// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

if (empty($_GET["code"])) {
	$bytes = $_GET["bytes"];
	if (!empty($bytes) and $bytes > 0)
	{
		mysqli_query($con,"INSERT INTO games (id, bytes) VALUES (NULL, " . $bytes . ")");
		
		$return = mysqli_insert_id ($con);
		$type = "code";
	}
} else {
	$code = $_GET["code"];
	$queryResult = mysqli_query($con,"SELECT bytes FROM games WHERE id=". $code);
	
	$row = mysqli_fetch_array($queryResult);
	
	$return = $row['bytes'];
	$type = "byte";
}
mysqli_close($con);

$arr = array('type' => $type, 'result' => $return);

echo json_encode($arr);
?>