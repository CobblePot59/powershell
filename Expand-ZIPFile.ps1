function Expand-ZIPFile($file, $destination) {
	$shell = new-object -com shell.application
	$zip = $shell.NameSpace($file)
	foreach($item in $zip.items())
		{
			$shell.Namespace($destination).copyhere($item)
		}
}

#Expand-ZIPFile –File test.zip –Destination c:\test
