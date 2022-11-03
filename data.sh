#!/bin/bash

qsub -hold_jid "bedgraph" -t 1-12 -P {group}.prjc bedgraph.sh

qsub -hold_jid "multicov" -P {group}.prjc multicov.sh
