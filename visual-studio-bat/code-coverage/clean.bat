@ECHO OFF

@ECHO 1. Apagando diretorios

if exist Reports (
	RD Reports /S /Q
)

if exist coverage (
	RD coverage /S /Q
)

if exist CodeCoverageHTML (
	RD CodeCoverageHTML /S /Q
)

@ECHO 2. Apagando arquivos

if exist emma.xml (
	DEL emma.xml
)

if exist TestResult.xml (
	DEL TestResult.xml
)

if exist results.xml (
	DEL results.xml
)

if exist outputCobertura.xml (
	DEL outputCobertura.xml
)

if exist outputCoverage.xml (
	DEL outputCoverage.xml
)

if exist dupReport.html (
	DEL dupReport.html
)

if exist dupReport.xml (
	DEL dupReport.xml
)