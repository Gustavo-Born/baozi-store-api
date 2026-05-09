@echo off
echo.
echo === BAOZI STORE - Iniciando servidor ===
echo.

SET "PROJ=%~dp0"
SET "MVN_DIR=%PROJ%.maven-local\apache-maven-3.9.6"
SET "MVN_BIN=%MVN_DIR%\bin\mvn.cmd"
SET "MVN_ZIP=%PROJ%.maven-local\maven.zip"
SET "MVN_URL=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.6/binaries/apache-maven-3.9.6-bin.zip"

java -version >nul 2>&1
IF ERRORLEVEL 1 (
    echo [ERRO] Java nao encontrado. Instale em: https://adoptium.net
    pause
    exit /b 1
)
echo [OK] Java encontrado.

IF EXIST "%MVN_BIN%" goto RODA

echo [INFO] Baixando Maven pela primeira vez, aguarde...
IF NOT EXIST "%PROJ%.maven-local" mkdir "%PROJ%.maven-local"

powershell -Command "$url='%MVN_URL%'; $dest='%MVN_ZIP%'; [Net.ServicePointManager]::SecurityProtocol='Tls12'; (New-Object Net.WebClient).DownloadFile($url,$dest)"

IF NOT EXIST "%MVN_ZIP%" (
    echo [ERRO] Falha no download. Verifique a internet.
    pause
    exit /b 1
)

powershell -Command "$src='%MVN_ZIP%'; $dst='%PROJ%.maven-local'; Add-Type -A System.IO.Compression.FileSystem; [IO.Compression.ZipFile]::ExtractToDirectory($src,$dst)"
del "%MVN_ZIP%" >nul 2>&1

IF NOT EXIST "%MVN_BIN%" (
    echo [ERRO] Falha ao extrair Maven.
    pause
    exit /b 1
)
echo [OK] Maven pronto.

:RODA
echo.
echo [INFO] Iniciando aplicacao... (primeira vez demora ~2 min)
echo [INFO] Para parar: pressione Ctrl+C
echo.
"%MVN_BIN%" -f "%PROJ%pom.xml" spring-boot:run
pause
