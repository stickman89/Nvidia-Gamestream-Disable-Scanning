@echo off

::: STOPPING SERVICES :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Killing NVIDIA Services to resolve file lock...
sc stop "NVDisplay.ContainerLocalSystem"
sc stop "NvContainerLocalSystem"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 5 > NUL
cls

::: SET DIRECTORY AND START TEXT EDITOR :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Opening config.xml. Amend value 'EnableAutomaticApplicationScan' from '0' to '1'. Save, and then close.
timeout 2 > NUL
cd %APPDATA%/../Local/NVIDIA/NvBackend/
attrib -r "config.xml"
start /wait notepad.exe "%APPDATA%/../Local/NVIDIA/NvBackend/config.xml"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

:: REMOVE AND RESTORE VISUALOPSDATA ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Reinstating previously backed up 'VisualOPSData' directory...
attrib -r "VisualOPSData"
rmdir "VisualOPSData" /S /Q
ren backup_VisualOPSData VisualOPSData

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

:: SET READONLY ATTRIBUTE :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Setting file and folder attributes appropriately...
attrib -r "VisualOPSData"
attrib -r "journalBS.jour.dat"
attrib -r "journalBS.main.xml"

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

::: RESTORE PREVIOUS DATA ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Removing existing 'JournalBS' data...
del "journalBS.jour.dat"
del "journalBS.main.xml"
ren backup_journalBS.jour.dat journalBS.jour.dat
ren backup_journalBS.main.xml journalBS.main.xml

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

timeout 2 > NUL
cls

::: ENABLING ONTOLOGY TO FINISH UP :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Enabling NVIDIA 'Applications Ontology' feature...
cd ApplicationOntology
ren Ontology64.dll.bak Ontology64.dll

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