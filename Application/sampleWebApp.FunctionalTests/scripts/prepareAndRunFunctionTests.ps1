pushd $env:temp
$Path = $env:TEMP; $Installer = "chrome_installer.exe"; Invoke-WebRequest "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path$Installer; Start-Process -FilePath $Path$Installer -Args "/silent /install" -Verb RunAs -Wait; Remove-Item $Path$Installer
Invoke-WebRequest https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_win32.zip -outFile chromedriver.zip
Expand-Archive -Path chromedriver.zip
Remove-Item chromedriver.zip
popd
pwd
ls
cd ..
java -version
java -DwebAppUrl="https://$\{{ env.APPNAME \}}.azurewebsites.net/" -DChromeWebDriver="$env:temp/chromedriver" -cp SampleWebAppFunctionalTests-jar-with-dependencies.jar org.junit.platform.console.ConsoleLauncher --class-path SampleWebAppFunctionalTests-jar-with-dependencies.jar --scan-class-path --reports-dir reports --include-engine junit-vintage
