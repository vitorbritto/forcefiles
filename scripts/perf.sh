#!/usr/bin/env bash

# ------------------------------------------------------------------------------------------------------------
#
# Program:      perf.sh
# Author:       Vitor Britto
# Description:  This script is a shortcut to measure frontend performance with Phantomas and Highcharts
#
# Usage:        ./perf.sh [options]
# Example:      ./perf.sh -u http://www.vitorbritto.com.br -r 5
#
# Options:
#       -u            url to evaluate
#       -r            times to run
#
# Important:
#     If you prefer, create an alias: perf="bash ~/path/to/script/perf.sh"
#     And execute with: perf -u http://www.vitorbritto.com.br -r 5
#
# Copyright (c) Vitor Britto
# Licensed under the MIT license.
# ------------------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

URL=http://www.vitorbritto.com.br
DEFAULT_OPTS="--no-externals --reporter=json --progress --timeout=600"
RUNS=2


# ------------------------------------------------------------------------------
# | UTILS                                                                      |
# ------------------------------------------------------------------------------

# Header logging
e_header() {
    printf "$(tput setaf 38)→ %s$(tput sgr0)\n" "$@"
}

# Success logging
e_success() {
    printf "$(tput setaf 76)✔ %s$(tput sgr0)\n" "$@"
}

# Error logging
e_error() {
    printf "$(tput setaf 1)✖ %s$(tput sgr0)\n" "$@"
}

# Warning logging
e_warning() {
    printf "$(tput setaf 3)! %s$(tput sgr0)\n" "$@"
}


# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

while getopts ":r:u:" opt; do
    case $opt in
        u)
            URL=$OPTARG
            URLSET=1
        ;;
        r)
            RUNS=$OPTARG
            if [[ "$OPTARG" -le 1 ]]; then
                e_error "You need to perform at least 2 (two) runs."
                exit 1
            fi
        ;;
        \?)
            e_error "Invalid option: -$OPTARG" >&2
            exit 1
        ;;
    esac
done

if [[ "$URLSET" -ne 1 ]]; then
    e_error "You need to set a URL. Crawling vitorbritto.com.br"
    exit 1
fi

# ------------------------------------------------------------------------------
# | MAIN                                                                       |
# ------------------------------------------------------------------------------

# Collect Information and Build the Data Graph
perf_collect() {

OPTS="--runs $RUNS"

e_header "Generating Report..."

phantomas $URL $DEFAULT_OPTS $OPTS > report.json

cat > $1 << \EOL
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/modules/exporting.js"></script>

    <script>
        /**
         * Dark theme for Highcharts JS
         * @author Torstein Honsi
         */

        // Load the fonts
        Highcharts.createElement('link', {
           href: 'http://fonts.googleapis.com/css?family=Roboto',
           rel: 'stylesheet',
           type: 'text/css'
        }, null, document.getElementsByTagName('head')[0]);

        Highcharts.theme = {
           colors: ["#2b908f", "#90ee7e", "#f45b5b", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
              "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
           chart: {
              backgroundColor: {
                 linearGradient: { x1: 0, y1: 0, x2: 1, y2: 1 },
                 stops: [
                    [0, '#2a2a2b'],
                    [1, '#3e3e40']
                 ]
              },
              style: {
                 fontFamily: "'Roboto', sans-serif"
              },
              plotBorderColor: '#606063'
           },
           title: {
              style: {
                 color: '#E0E0E3',
                 textTransform: 'uppercase',
                 fontSize: '20px'
              }
           },
           subtitle: {
              style: {
                 color: '#E0E0E3',
                 textTransform: 'uppercase'
              }
           },
           xAxis: {
              gridLineColor: '#707073',
              labels: {
                 style: {
                    color: '#E0E0E3'
                 }
              },
              lineColor: '#707073',
              minorGridLineColor: '#505053',
              tickColor: '#707073',
              title: {
                 style: {
                    color: '#A0A0A3'

                 }
              }
           },
           yAxis: {
              gridLineColor: '#707073',
              labels: {
                 style: {
                    color: '#E0E0E3'
                 }
              },
              lineColor: '#707073',
              minorGridLineColor: '#505053',
              tickColor: '#707073',
              tickWidth: 1,
              title: {
                 style: {
                    color: '#A0A0A3'
                 }
              }
           },
           tooltip: {
              backgroundColor: 'rgba(0, 0, 0, 0.85)',
              style: {
                 color: '#F0F0F0'
              }
           },
           plotOptions: {
              series: {
                 dataLabels: {
                    color: '#B0B0B3'
                 },
                 marker: {
                    lineColor: '#333'
                 }
              },
              boxplot: {
                 fillColor: '#505053'
              },
              candlestick: {
                 lineColor: 'white'
              },
              errorbar: {
                 color: 'white'
              }
           },
           legend: {
              itemStyle: {
                 color: '#E0E0E3'
              },
              itemHoverStyle: {
                 color: '#FFF'
              },
              itemHiddenStyle: {
                 color: '#606063'
              }
           },
           credits: {
              style: {
                 color: '#666'
              }
           },
           labels: {
              style: {
                 color: '#707073'
              }
           },

           drilldown: {
              activeAxisLabelStyle: {
                 color: '#F0F0F3'
              },
              activeDataLabelStyle: {
                 color: '#F0F0F3'
              }
           },

           navigation: {
              buttonOptions: {
                 symbolStroke: '#DDDDDD',
                 theme: {
                    fill: '#505053'
                 }
              }
           },

           // scroll charts
           rangeSelector: {
              buttonTheme: {
                 fill: '#505053',
                 stroke: '#000000',
                 style: {
                    color: '#CCC'
                 },
                 states: {
                    hover: {
                       fill: '#707073',
                       stroke: '#000000',
                       style: {
                          color: 'white'
                       }
                    },
                    select: {
                       fill: '#000003',
                       stroke: '#000000',
                       style: {
                          color: 'white'
                       }
                    }
                 }
              },
              inputBoxBorderColor: '#505053',
              inputStyle: {
                 backgroundColor: '#333',
                 color: 'silver'
              },
              labelStyle: {
                 color: 'silver'
              }
           },

           navigator: {
              handles: {
                 backgroundColor: '#666',
                 borderColor: '#AAA'
              },
              outlineColor: '#CCC',
              maskFill: 'rgba(255,255,255,0.1)',
              series: {
                 color: '#7798BF',
                 lineColor: '#A6C7ED'
              },
              xAxis: {
                 gridLineColor: '#505053'
              }
           },

           scrollbar: {
              barBackgroundColor: '#808083',
              barBorderColor: '#808083',
              buttonArrowColor: '#CCC',
              buttonBackgroundColor: '#606063',
              buttonBorderColor: '#606063',
              rifleColor: '#FFF',
              trackBackgroundColor: '#404043',
              trackBorderColor: '#404043'
           },

           // special colors for some of the
           legendBackgroundColor: 'rgba(0, 0, 0, 0.5)',
           background2: '#505053',
           dataLabelsColor: '#B0B0B3',
           textColor: '#C0C0C0',
           contrastTextColor: '#F0F0F3',
           maskColor: 'rgba(255,255,255,0.3)'
        };

        // Apply the theme
        Highcharts.setOptions(Highcharts.theme);
    </script>

    <script>
EOL

cat report.json | sed -e 's/^{/var perf={/' >> $1
cat >> $1 << \EOL
;
$(function () {

    # Declare variables
    # -----------------------------

    # Init
    var htmlSize,
        cssSize,
        jsSize,
        imageSize,
        webfontSize,
        htmlCount,
        cssCount,
        jsCount,
        imageCount,
        webfontCount,
        categories      = [],
        i               = 0,
        showData        = perf.runs.metrics;

    # Sizes
    htmlSize         = showData.htmlSize;
    cssSize          = showData.cssSize;
    jsSize           = showData.jsSize;
    imageSize        = showData.imageSize;
    webfontSize      = showData.webfontSize;

    # Counts
    htmlCount        = showData.htmlCount;
    cssCount         = showData.cssCount;
    jsCount          = showData.jsCount;
    imageCount       = showData.imageCount;
    webfontCount     = showData.webfontCount;


    # Render Data
    $('#header').highcharts({
        title: { text: 'Performed URL: ' + perf.runs[0].url }
    });

    $('#sizes').highcharts({
        chart: {
            type: 'bar',
            allowPointSelect: true
        },
        title: { text: 'File Sizes' },
        xAxis: { categories: categories },
        series: [
            { name: 'HTML - Size (in kb)', data: htmlSize },
            { name: 'Styles - Size (in kb)', data: cssSize },
            { name: 'Scripts - Size (in kb)', data: jsSize },
            { name: 'Images - Size (in kb)', data: imageSize },
            { name: 'Fonts - Size (in kb)', data: webfontSize }
        ]
    });

    $('#counts').highcharts({
        chart: {
            type: 'bar',
            allowPointSelect: true
        },
        title: { text: 'File Counts' },
        xAxis: { categories: categories },
        series: [
            { name: 'HTML - Count (number of files)', data: htmlCount },
            { name: 'Styles - Count (number of files)', data: cssCount },
            { name: 'Scripts - Count (number of files)', data: jsCount },
            { name: 'Images - Count (number of files)', data: imageCount },
            { name: 'Fonts - Count (number of files)', data: webfontCount }
        ]
    });

});
    </script>
    <style>
        body {
            background: #3A3A3B;
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
        }
        #header {
            width: 100%;
            height: 40px;
            display: block;
        }
        .box {
            display: block;
            width: 100%;
            margin: 0;
            padding: 0;
            border: 1px solid #222222;
        }
    </style>
</head>
<body>
    <div id="header"></div>
    <div id="generals" class="box"></div>
    <div id="sizes" class="box"></div>
    <div id="counts" class="box"></div>
</body>
</html>
EOL

    # rm report.json
    echo ""
    echo ""
    e_success "Report successfully generated!"
    echo ""

}

# Run it!
perf_collect perf_report.html && open $_
