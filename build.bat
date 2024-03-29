@echo off

echo Downloading FlexSearch Core
git submodule update --init --recursive

cd flexsearch
call build.bat api
call build.bat target=RestorePackages
call build.bat target=BuildApp
call build.bat target=HttpTests
cd ..

echo Copying the generated api.html file
copy flexsearch\documentation\api.html includes\api.html

echo Copying the generated examples
if not exist "includes\examples" mkdir "includes\examples"
copy flexsearch\documentation\docs\data\*.* includes\examples\