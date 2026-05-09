@REM ----------------------------------------------------------------------------
@REM Licensed to the Apache Software Foundation (ASF) under one
@REM or more contributor license agreements. See the NOTICE file
@REM distributed with this work for additional information
@REM regarding copyright ownership. The ASF licenses this file
@REM to you under the Apache License, Version 2.0 (the
@REM "License"); you may not use this file except in compliance
@REM with the License. You may obtain a copy of the License at
@REM
@REM https://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing,
@REM software distributed under the License is distributed on an
@REM "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
@REM KIND, either express or implied. See the License for the
@REM specific language governing permissions and limitations
@REM under the License.
@REM ----------------------------------------------------------------------------

@REM ----------------------------------------------------------------------------
@REM Apache Maven Wrapper startup batch script
@REM ----------------------------------------------------------------------------

@IF "%__MVNW_ARG0_NAME__%"=="" (SET "__MVNW_ARG0_NAME__=%~nx0")
@SET ___MVNW_UGLY_WHITESPACE_SNIFF_TEST___=X
@IF NOT "X%__MVNW_ARG0_NAME__: =%"=="X%__MVNW_ARG0_NAME__%" (
  @ECHO The name of the Maven Wrapper script contains whitespace: "%__MVNW_ARG0_NAME__%"
  @ECHO This is not supported because there may be problems with how arguments are passed to Java programs.
)
@SET ___MVNW_UGLY_WHITESPACE_SNIFF_TEST___=

@IF NOT "%MVNW_USERNAME%"=="" (
  SET _MVNW_USERNAME_=%MVNW_USERNAME%
) ELSE IF NOT "%USERNAME%"=="" (
  SET _MVNW_USERNAME_=%USERNAME%
) ELSE (
  FOR /F "tokens=*" %%a IN ('whoami') DO (SET _MVNW_USERNAME_=%%a)
  SET _MVNW_USERNAME_=%_MVNW_USERNAME_:\=_%
  SET _MVNW_USERNAME_=%_MVNW_USERNAME_: =_%
)

@SET MAVEN_PROJECTBASEDIR=%~dp0
@IF "%MAVEN_PROJECTBASEDIR:~-1%"=="\" (
  SET "MAVEN_PROJECTBASEDIR=%MAVEN_PROJECTBASEDIR:~0,-1%"
)
@SET MAVEN_WRAPPER_PROPERTIES_FILE=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.properties
@SET MVNW_REPOURL=
@FOR /F "usebackq tokens=1,2 delims==" %%a IN ("%MAVEN_WRAPPER_PROPERTIES_FILE%") DO (
  @IF "%%a"=="wrapperUrl" (SET MVNW_REPOURL=%%b)
)
@SET MVNW_DISTRIBUTION_URL=
@FOR /F "usebackq tokens=1,2 delims==" %%a IN ("%MAVEN_WRAPPER_PROPERTIES_FILE%") DO (
  @IF "%%a"=="distributionUrl" (SET MVNW_DISTRIBUTION_URL=%%b)
)

@SET WRAPPER_LAUNCHER=org.apache.maven.wrapper.MavenWrapperMain

@SET MAVEN_WRAPPER_JAR_PATH=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar

@SET DOWNLOAD_URL=%MVNW_REPOURL%

@SET JAVA_HOME_DIR=%JAVA_HOME%
@IF NOT "%JAVA_HOME_DIR%"=="" (
  @SET "JAVA_CMD=%JAVA_HOME_DIR%\bin\java.exe"
) ELSE (
  @SET JAVA_CMD=java
)

@SET MVNW_VERBOSE=false
@IF "%MVNW_VERBOSE%"=="true" (
  @ECHO Verbose mode enabled
)

@IF NOT EXIST "%MAVEN_WRAPPER_JAR_PATH%" (
  @ECHO Downloading Maven Wrapper JAR...
  @"%JAVA_CMD%" -classpath "%CLASSPATH%" "-Djavax.net.ssl.trustStoreType=WINDOWS-ROOT" org.apache.maven.wrapper.MavenWrapperDownloader "%DOWNLOAD_URL%" "%MAVEN_WRAPPER_JAR_PATH%" >NUL 2>&1
  @IF ERRORLEVEL 1 (
    @ECHO Trying PowerShell download...
    @powershell -Command "$webclient = new-object System.Net.WebClient; $webclient.DownloadFile('%DOWNLOAD_URL%', '%MAVEN_WRAPPER_JAR_PATH%')" 2>NUL
  )
)

@IF EXIST "%MAVEN_WRAPPER_JAR_PATH%" (
  @"%JAVA_CMD%" ^
    %MAVEN_OPTS% ^
    %MAVEN_DEBUG_OPTS% ^
    -classpath "%MAVEN_WRAPPER_JAR_PATH%" ^
    "-Dmaven.multiModuleProjectDirectory=%MAVEN_PROJECTBASEDIR%" ^
    %WRAPPER_LAUNCHER% %MAVEN_CONFIG% %*
) ELSE (
  @ECHO [ERROR] Maven Wrapper JAR not found. Trying direct Maven download...
  @powershell -Command "& { $url = '%MVNW_DISTRIBUTION_URL%'; $dest = '%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-dist.zip'; Write-Host 'Downloading Maven...'; (New-Object Net.WebClient).DownloadFile($url, $dest); Write-Host 'Extracting...'; Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory($dest, '%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-dist'); $dirs = Get-ChildItem '%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-dist' -Directory; $mvnDir = $dirs[0].FullName; Write-Host ('Maven at: ' + $mvnDir); [System.Environment]::SetEnvironmentVariable('PATH', $mvnDir + '\bin;' + $env:PATH, 'Process'); Write-Host 'Maven ready.' }"
  @SET "_MAVEN_WRAPPER_FALLBACK_DIR=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-dist"
  @FOR /D %%d IN ("%_MAVEN_WRAPPER_FALLBACK_DIR%\apache-maven-*") DO (
    @ECHO Using Maven at %%d
    @"%%d\bin\mvn.cmd" %*
    @GOTO end
  )
  @ECHO [ERROR] Could not download or find Maven. Please install Maven manually.
)
:end
