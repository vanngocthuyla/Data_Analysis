## Python 3
## Publication: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4312015/
## Source of tool: https://github.com/ebi-wp/webservice-clients/blob/master/python/iprscan5.py
## Download the py file to run interproscan

import os

#### Define paths to input and output directories
datadir = '/home/Input' # input
outdir = '/home/Output' # output
tooldir = '/home/Tool' #containing the downloaded file 'iprscan5.py'

#### Define paths to input and tool files
query = os.path.join(datadir, 'Protein.fasta') # query sequence(s)
tool = os.path.join(tooldir, 'iprscan5.py') #tool

my_email='**@gmail.com' #modified the email to run code
title='DNA'
filename = 'Result'

#### Available database: #database: ProDom, PRINTS, PIRSF, PfamA, SMART, TIGRFAM, PrositeProfiles
%run $tool --sequence $query --email $my_email --title $title --outfile $filename --outformat xml,log

