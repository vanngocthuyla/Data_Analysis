## Python 3

#### Run blastx by python code
import os
from Bio.Blast import NCBIWWW

#### Define paths to input and output directories
datadir = '/home/Input' # input
outdir = '/home/Output' # output
os.makedirs(outdir, exist_ok=True) # create output directory if it doesn't exist

#### Define paths to input and output files
query = os.path.join(datadir, 'Sequence.fas') # query sequence(s)
result = os.path.join(outdir, 'Result.xml') # output result(s)

#### Load the fasta from query file and run blastn
#### 1st
fasta_string = open(query).read()
result_handle = NCBIWWW.qblast("blastx", database="refseq_protein", sequence=fasta_string, hitlist_size=10)

#### SAVING THE OUTPUT
with open(result, "w") as save_to:
    save_to.write(result_handle.read())
    result_handle.close()
with open(result) as result_handle:
    print(result_handle)
    
#### PARSING THE BLAST OUTPUT
from Bio.Blast import NCBIXML
result_handle = open(result, 'r')
blast_records = NCBIXML.parse(result_handle)
blast_record = next(blast_records)
print(blast_record.database_sequences)

#### The BLAST record class
E_VALUE_THRESH = 1.0e-100
#from Bio.Blast import NCBIXML
result_handle = open(result, 'r')
blast_records = NCBIXML.parse(result_handle)

for alignment in blast_record.alignments:
    for hsp in alignment.hsps:
        if hsp.expect < E_VALUE_THRESH:
            print('****Alignment****')
            print('sequence:', alignment.title)
            print('length:', alignment.length)
            print('e value:', hsp.expect)
            print(hsp.query[0:75] + '...')
            print(hsp.match[0:75] + '...')
            print(hsp.sbjct[0:75] + '...')
