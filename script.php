<?php 

if ($_POST['value'] == "RemoveUSB"){ 
	shell_exec('sudo /sbin/modprobe -r g_mass_storage');
}

if ($_POST['value'] == "LoadUSB"){ 
	shell_exec('sudo /sbin/modprobe -r g_mass_storage');
	$fileName = "./usb-drive.img";
	shell_exec('sudo /sbin/modprobe g_mass_storage file=' . $fileName . ' stall=0 removable=1');
}

if ($_POST['value'] == "Reboot"){ 
	shell_exec('sudo reboot' );
}

if ($_POST['value'] == "Shutdown"){ 
	shell_exec('sudo shutdown -h now' );
}
?>
