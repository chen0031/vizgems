#!/bin/ksh

export SHELL=$(which ksh 2> /dev/null)
[[ $SECONDS != *.* ]] && exec $SHELL $0 "$@"

SWIFTPROFILES=${SWIFTPROFILES:-$HOME/.suirc}

if [[ -f $SWIFTPROFILES/all.lefty ]] then
    CMD1="load ('$SWIFTPROFILES/all.lefty');"
fi

if [[ -f $SWIFTPROFILES/$1.lefty ]] then
    CMD2="load ('$SWIFTPROFILES/$1.lefty');"
fi

if [[ -f $7/$8.lefty ]] then
    CMD3="load ('$7/$8.lefty');"
fi

lefty3d -e "
    load ('suiplot.lefty');
    load ('suiutil.lefty');
    suiutil.msglabel = 'SWIFT Plot message: ';
    load ('$1.lefty');
    $CMD1
    $CMD2
    $CMD3
    suiplot.init ($1);
    suiplot.main (
        concat ('/dev/tcp/$2/', '$3'), 'http://$4:$5', '$6', '$7'
    );
    txtview ('off');
"