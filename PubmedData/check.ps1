Get-ChildItem . -Filter *.md5 | ForEach-Object {
  $compressedFile = $_.FullName.Trim(".md5")
  if ((Get-FileHash $compressedFile -Algorithm MD5).hash -ne (Get-Content $_).Split(" ")[1]) {
    "Mismatch in: " + $compressedFile.ToString()
    exit 1
  }
  else {$compressedFile.ToString() + " = ✅"}
}