@echo off

::: STOPPING SERVICES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Killing NVIDIA Services to resolve file lock...
sc stop "NVDisplay.ContainerLocalSystem"
sc stop "NvContainerLocalSystem"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 5 > NUL
cls

::: SET DIRECTORY AND START TEXT EDITOR :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Opening config.xml. Amend value 'EnableAutomaticApplicationScan' from '1' to '0'. Save, and then close.
timeout 2 > NUL
cd %APPDATA%/../Local/NVIDIA/NvBackend/
attrib -r "config.xml"
start /wait notepad.exe "%APPDATA%/../Local/NVIDIA/NvBackend/config.xml"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

:: BACKUP AND RECREATE VISUALOPSDATA ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Backing up existing 'VisualOPSData'...
ren VisualOPSData backup_VisualOPSData
mkdir "VisualOPSData"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

:: SET READONLY ATTRIBUTE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Setting file and folder attributes appropriately...
attrib +r "VisualOPSData"
attrib -r "journalBS.jour.dat"
attrib -r "journalBS.main.xml"
attrib +r "config.xml"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

::: BACKUP EXISTING DATA ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Backing up existing 'JournalBS' data...
ren journalBS.jour.dat backup_journalBS.jour.dat
ren journalBS.main.xml backup_journalBS.main.xml

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

::: DISABLING ONTOLOGY TO FINISH UP :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::: otherwise NvBackend will rebuild OPSData on app launch using ontology catalogue thus leading to duplicates

echo Disabling NVIDIA 'Applications Ontology' feature...
cd ApplicationOntology
ren Ontology64.dll Ontology64.dll.bak

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

::: RESTARTING SERVICES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Restarting NVIDIA Services...
sc start "NVDisplay.ContainerLocalSystem"
sc start "NvContainerLocalSystem"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

::: EXIT ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Job completed. Exiting...
timeout 2 > NUL
exit
