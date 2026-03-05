# Nematostella CNV qPCR Workflow 
This directory contains the detailed workflow for design and analysis along with excel sheets and scripts. 


## 1. Design Primers 
A) TRIM
  - Using alignment file for TRIM seqs (all.trim.fasta)
  - Open primer3: [https://www.primer3plus.com/]
  - click on general settings tab and change product size: 80-120 --> press pick primers
  - Go through primers and compare to alignment - find areas with few polymorphisims
      - Open alignment seqs (all.trim.fasta) in SnapGene - and annotate primers
  - Copy primers and targets into IDT UNAfold (under tools) to veiw secondary structure (we want under 50C)
  - Check primers (all sequences and RC) in thermofisher: https://www.thermofisher.com/us/en/home/brands/thermo-scientific/molecular-biology/molecular-biology-learning-center/molecular-biology-resource-library/thermo-scientific-web-tools/multiple-primer-analyzer.html
  - Record all info (Primers, targets, IDT UNAfold, and Thermofisher primer analyzer) in excel (Primers_immunity_genes_Nematostella_3-8-23) and choose primers to make and test

B) STING
  - Using alignment file for TRIM seqs (all.sting.realigned.fasta)
  - Open primer3: [https://www.primer3plus.com/]
  - click on general settings tab and change product size: 80-120 --> press pick primers
  - Go through primers and compare to alignment - find areas with few polymorphisims
      - Open alignment seqs (all.sting.realigned.fasta) in SnapGene - and annotate primers
  - Copy primers and targets into IDT UNAfold (under tools) to veiw secondary structure (we want under 50C)
  - Check primers (all sequences and RC) in thermofisher: https://www.thermofisher.com/us/en/home/brands/thermo-scientific/molecular-biology/molecular-biology-learning-center/molecular-biology-resource-library/thermo-scientific-web-tools/multiple-primer-analyzer.html
  - Record all info (Primers, targets, IDT UNAfold, and Thermofisher primer analyzer) in excel (Primers_immunity_genes_Nematostella_3-8-23) and choose primers to make and test


C) cGAS
  - Using alignment file for TRIM seqs (cgas.combine.fasta)
  - Open primer3: [https://www.primer3plus.com/]
  - click on general settings tab and change product size: 80-120 --> press pick primers
  - Go through primers and compare to alignment - find areas with few polymorphisims
      - Open alignment seqs (cgas.combine.fasta) in SnapGene - and annotate primers
  - Copy primers and targets into IDT UNAfold (under tools) to veiw secondary structure (we want under 50C)
  - Check primers (all sequences and RC) in thermofisher: https://www.thermofisher.com/us/en/home/brands/thermo-scientific/molecular-biology/molecular-biology-learning-center/molecular-biology-resource-library/thermo-scientific-web-tools/multiple-primer-analyzer.html
  - Record all info (Primers, targets, IDT UNAfold, and Thermofisher primer analyzer) in excel (Primers_immunity_genes_Nematostella_3-8-23) and choose primers to make and test


## 2. Calculate primer efficency
  - Calculate 4 point dilution series:
      - 96-Well-qPCR-Plate-Map_Primer_dilutions_final.xlsx
  - Set up plate and run qPCR:
      - 96-Well-qPCR-Plate-Map_Primer_dilutions_final.xlsx
  - Calculate Standard curve:
      - calc_Primer_efficiency.xlsx


## 3. Design qPCR experiment and Run


## 4. Analyze qPCR Results
