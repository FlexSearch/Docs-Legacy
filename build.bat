@echo off

echo Downloading FlexSearch Core
git submodule update --init --recursive

echo Building the FlexSearch API
cd flexsearch
call build.bat api
cd ..

echo Copying the generated api.html file
copy flexsearch\documentation\api.html _partials\api.html