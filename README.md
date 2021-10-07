# NFRCV
The NFRCV template was created to provide a LaTeX alternative to the template in Word at [www.forskningsradet.no](https://www.forskningsradet.no/siteassets/utlysninger/vedlegg-utlysninger/cv-template-researchers.docx). The template is obtained with the options [printversion,calibri]. The calibri (font) option requires licensed Microsoft files which can be obtained from the Windows OS (search for "calibri" in the C:\Windows\WinSxS folder). The default font is Carlito which is close to identical to the Calibri font.

The main.tex file can be compiled by:
lualatex -synctex=1 -interaction=nonstopmode %.tex|biber %|lualatex -synctex=1 -interaction=nonstopmode %.tex|lualatex -synctex=1 -interaction=nonstopmode %.tex|evince %.pdf
