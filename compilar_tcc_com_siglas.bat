@echo off
setlocal
cd /d "%~dp0"
title Sobral em Mapas - Compilacao completa

echo ================================================
echo  Sobral em Mapas - Bibliografia e lista de siglas
echo ================================================
echo.
if not exist "documento.tex" (
  echo ERRO: Este arquivo .bat deve ficar na pasta TCC_Walisson, ao lado de documento.tex.
  goto :erro
)
where pdflatex >nul 2>&1
if errorlevel 1 (
  echo ERRO: pdflatex nao encontrado no PATH do Windows.
  goto :erro
)
where bibtex >nul 2>&1
if errorlevel 1 (
  echo ERRO: bibtex nao encontrado no PATH do Windows.
  goto :erro
)
where makeglossaries >nul 2>&1
if errorlevel 1 (
  echo ERRO: makeglossaries nao encontrado no PATH do Windows.
  echo Se usar MiKTeX, talvez precise instalar Perl, alem do pacote glossaries.
  goto :erro
)

echo [1/5] pdflatex ...
pdflatex -interaction=nonstopmode -halt-on-error documento.tex
if errorlevel 1 goto :erro

echo.
echo [2/5] bibtex ...
bibtex documento
if errorlevel 1 goto :erro

echo.
echo [3/5] makeglossaries ...
makeglossaries documento
if errorlevel 1 (
  echo ERRO em makeglossaries. Se usar MiKTeX, confira se Perl esta instalado.
  goto :erro
)

echo.
echo [4/5] pdflatex ...
pdflatex -interaction=nonstopmode -halt-on-error documento.tex
if errorlevel 1 goto :erro

echo.
echo [5/5] pdflatex ...
pdflatex -interaction=nonstopmode -halt-on-error documento.tex
if errorlevel 1 goto :erro

echo.
echo CONCLUIDO: documento.pdf foi atualizado.
echo Confira a lista de siglas (EPSG, OSM, PWA, SEUMA, WGS 84).
pause
exit /b 0

:erro
echo.
echo FALHA: Envie a ultima mensagem de erro mostrada nesta janela.
pause
exit /b 1
