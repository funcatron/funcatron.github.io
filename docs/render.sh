#!/bin/sh
# adoc2pdf *.adoc

program=$(basename $0)
dir=$(dirname $0)
cwd=$(pwd -P)
cd "$dir"
dir=$(pwd -P)

if [ -z "$@" ]; then
    sources=*.adoc
else
    sources=$@
fi

build="rendered"
resources="./resources"
# stylesdir="$resources/themes"
# fontsdir="$resources/fonts"
imagesdir="$resources/images"
stylesdir="$resources/css"

echo "Making HTML5 in $build/"
if [ -d "$imagesdir" ]; then
    mkdir -p "$build/images"
    cp -a "$imagesdir" "$build/"
fi
if [ -d "$stylesdir" ]; then
    mkdir -p "$build/css"
    cp -a "$stylesdir" "$build/"
fi

attrs="--attribute imagesdir=images"
attrs="$attrs --attribute sectanchors"
attrs="$attrs --attribute sectlinks"
attrs="$attrs --attribute linkcss"
attrs="$attrs --attribute stylesdir=css"
attrs="$attrs --attribute stylesheet=funcatron-adoc.css"

asciidoctor --require=asciidoctor-diagram --destination-dir="$build" \
            $attrs $sources

ls -1 $build/*.html
