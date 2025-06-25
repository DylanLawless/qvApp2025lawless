#!/bin/bash

# Create zip excluding PDF and build artefacts, placing it in the current directory
zip -r qvApp2025lawless_source.zip latex/qvApp2025lawless.tex latex/references.bib latex/images/ latex/head.tex
