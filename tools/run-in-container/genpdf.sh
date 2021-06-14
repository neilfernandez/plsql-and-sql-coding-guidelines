#!/bin/bash

function create_target_dir(){
    rm -Rf ${TARGET_DIR}
    mkdir -p ${TARGET_DIR}/docs
}

function copy_resources() {
    cp ${DATA_DIR}/mkdocs.yml ${TARGET_DIR}/mkdocs.yml
    cp -r ${DATA_DIR}/custom-theme ${TARGET_DIR}/custom-theme
    cp -r ${DATA_DIR}/docs/images ${TARGET_DIR}/docs
    cp -r ${DATA_DIR}/docs/stylesheets ${TARGET_DIR}/docs/stylesheets
}

function create_cover() {
    sed -e "s/#VERSION#/$(get_version)/g" ${DATA_DIR}/docs/cover-template.html \
        | sed -e "s/#YEAR#/$(date +'%Y')/g" > ${TARGET_DIR}/docs/cover.html
}

# sed -e 's|../../3-coding-style/coding-style/#rules|#rules|g' | \

function write_file(){
    FILE=$1
    echo "" >> ${TARGET_DIR}/docs/index.md
    sed -e 's/..\/image/image/g' ${DATA_DIR}/docs/${FILE} | \
        sed -e 's|ngena-PLSQL-and-SQL-Coding-Guidelines.pdf||g' | \
        sed -e 's/&#10008;/X/g' >> ${TARGET_DIR}/docs/index.md
}

function fix_footnote_links() {
    mv index.html index.ori.html
    sed -e 's/a class="footnote-ref"/a /g' index.ori.html > index.html
}

function write_text(){
    TEXT=$1
    echo "" >> ${TARGET_DIR}/docs/index.md
    echo "${TEXT}" >> ${TARGET_DIR}/docs/index.md
}

function write_guidelines(){
    DIR=$1
    HEADER=$2
    for f in ${DATA_DIR}/docs/${DIR}/*.md
    do
        echo "" >> ${TARGET_DIR}/docs/index.md
        sed -e "s|# |${HEADER} |g" $f >> ${TARGET_DIR}/docs/index.md
    done
}

function get_version(){
    VERSION="$(grep guideline_version ${DATA_DIR}/mkdocs.yml | awk '{print $2}')"
    echo ${VERSION}
}

function convert_to_pdf(){
    cd ${TARGET_DIR}
    mkdocs build
    cd site
    fix_footnote_links
    wkhtmltopdf --javascript-delay 3000 \
                --outline-depth 6 \
                --enable-local-file-access \
                --outline \
                --print-media-type \
                --margin-top 10 \
                --margin-right 10 \
                --margin-bottom 20 \
                --margin-left 10 \
                --footer-spacing 10 \
                --footer-font-name "Roboto" \
                --footer-font-size 8 \
                --footer-left "PL/SQL & SQL Coding Guidelines Version $(get_version)" \
                --footer-right "Page [page] of [topage]" \
                --title "PL/SQL & SQL Coding Guidelines Version $(get_version)" \
                cover ../docs/cover.html \
                toc \
                --xsl-style-sheet stylesheets/toc.xsl \
                index.html ${DATA_DIR}/docs/ngena-PLSQL-and-SQL-Coding-Guidelines.pdf
}

DATA_DIR="$(cd "$(dirname "${0}")/../.." && pwd)"
TARGET_DIR=${DATA_DIR}/pdf

create_target_dir
copy_resources
create_cover
write_file "index.md"
write_file "1-document-conventions/1-document-conventions.md"
write_file "2-naming-conventions/naming-conventions.md"
write_text "# Coding Style"
write_guidelines "3-coding-style" "##"
write_text "# Language Usage"
write_text "## General"
write_guidelines "4-language-usage/1-general" "###"
write_text "## Variables &amp; Types"
write_text "### General"
write_guidelines "4-language-usage/2-variables-and-types/1-general" "####"
write_text "### Numeric Data Types"
write_guidelines "4-language-usage/2-variables-and-types/2-numeric-data-types" "####"
write_text "### Character Data Types"
write_guidelines "4-language-usage/2-variables-and-types/3-character-data-types" "####"
write_text "### Boolean Data Types"
write_guidelines "4-language-usage/2-variables-and-types/4-boolean-data-types" "####"
write_text "### Large Objects"
write_guidelines "4-language-usage/2-variables-and-types/5-large-objects" "####"
write_text "## DML &amp; SQL"
write_text "### General"
write_guidelines "4-language-usage/3-dml-and-sql/1-general" "####"
write_text "### Bulk Operations"
write_guidelines "4-language-usage/3-dml-and-sql/2-bulk-operations" "####"
write_text "## Control Structures"
write_text "### CURSOR"
write_guidelines "4-language-usage/4-control-structures/1-cursor" "####"
write_text "### CASE / IF / DECODE / NVL / NVL2 / COALESCE"
write_guidelines "4-language-usage/4-control-structures/2-case-if-decode-nvl-nvl2-coalesce" "####"
write_text "### Flow Control"
write_guidelines "4-language-usage/4-control-structures/3-flow-control" "####"
write_text "## Exception Handling"
write_guidelines "4-language-usage/5-exception-handling" "###"
write_text "## Dynamic SQL"
write_guidelines "4-language-usage/6-dynamic-sql" "###"
write_text "## Stored Objects"
write_text "### General"
write_guidelines "4-language-usage/7-stored-objects/1-general" "####"
write_text "### Packages"
write_guidelines "4-language-usage/7-stored-objects/2-packages" "####"
write_text "### Procedures"
write_guidelines "4-language-usage/7-stored-objects/3-procedures" "####"
write_text "### Functions"
write_guidelines "4-language-usage/7-stored-objects/4-functions" "####"
write_text "### Oracle Supplied Packages"
write_guidelines "4-language-usage/7-stored-objects/5-oracle-supplied-packages" "####"
write_guidelines "4-language-usage/7-stored-objects/6-object-types" "###"
write_text "### Triggers"
write_guidelines "4-language-usage/7-stored-objects/7-triggers" "####"
write_text "### Sequences"
write_guidelines "4-language-usage/7-stored-objects/8-sequences" "####"
write_text "## Patterns"
write_text "### Checking the Number of Rows"
write_guidelines "4-language-usage/8-patterns/1-checking-the-number-of-rows" "####"
write_text "### Access objects of foreign application schemas"
write_guidelines "4-language-usage/8-patterns/2-access-objects-of-foreign-application-schemas" "####"
write_text "### Validating input parameter size"
write_guidelines "4-language-usage/8-patterns/3-validating-input-parameter-size" "####"
write_text "### Ensure single execution at a time of a program unit"
write_guidelines "4-language-usage/8-patterns/4-ensure-single-execution-at-a-time-of-a-program-unit" "####"
write_text "### Use dbms_application_info package to follow progress of a process"
write_guidelines "4-language-usage/8-patterns/5-use-dbms-application-info-package-to-follow-progress-of-a-process" "####"
write_file "6-code-reviews/code-reviews.md"
# write_file "7-tool-support/tool-support.md"
# write_text "## Appendix"
# write_file "9-appendix/appendix.md"
convert_to_pdf
