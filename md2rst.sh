#!/bin/bash

find . -type f -name "*.md"|awk -F "." '{print "pandoc -f markdown -t rst \""$0"\" -o \"." $2".rst\""}'|bash
