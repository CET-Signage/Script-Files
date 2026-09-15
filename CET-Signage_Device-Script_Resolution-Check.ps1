        #Parameters should be used to load dynamic values into this script
        #param($PCNameOrIP, $VariableName, $VariableValue, $ReaderIDName)

        #In place of parameters, static values can be defined here for testing purposes
        #set to CMS test device
         $PCNameOrIP = "CMS-DD-SPARE01"
         $VariableName = "Resolution"
        # $VariableValue = "http://ctexp-web01-signage.westus.cloudapp.azure.com/media/files/EnvisioningTheatre/Images/CEC-InvisioningTheatre_Manufacturing_1.jpg"
        # $ReaderIDName = "IMAGE"
        
        #Define the URL used to pass a variable value to the cotnent player PC
        $Raw_Resolution = (Get-WmiObject -Class Win32_VideoController).VideoModeDescription
        $VariableValue = ($Raw_Resolution -split '\s+x\s+', 3)[0..1] -join 'x'
        $VariableURL = "http://$PCNameOrIP"+":10561/player/command/RunScript?1=Player.SetVariable($VariableName,$VariableValue)"

        #Define the URL used to pass a Reader ID to the cotnent player PC
        #$ReaderURL = "http://$PCNameOrIP"+":10561/player/readerId/$ReaderIDName"

        #Define the credentials used to pass commands to the cotnent player PC
        $Username = "MSCET"
        $Password = "Cloud_33"
        $Domain = ""

        #write-host Sending $VariableURL

        #Pass the variable value to the cotnent player PC
        $webclient = new-object System.Net.WebClient
        $webclient.Credentials = new-object System.Net.NetworkCredential($Username, $Password, $Domain)
        $webpage = $webclient.DownloadString($VariableURL)

        #write-host Sending $ReaderURL

        #Pass the ReaderID to the cotnent player PC
       # $webclient = new-object System.Net.WebClient
       # $webclient.Credentials = new-object System.Net.NetworkCredential($Username, $Password, $Domain)
       # $webpage = $webclient.DownloadString($ReaderURL)