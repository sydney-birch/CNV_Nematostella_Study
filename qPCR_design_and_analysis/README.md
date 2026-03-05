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
      - make 20ul of 100 ng diluton of DNA  (ex: 15.7 ul DNA to 4.83 ul Molecular Biology water)
      - do 4 point dilution series: to start add 15 ul of Molecular Biology water to each tube
          - Add 5ul of 100ng DNA to first tube - mix very well
          - Then take 5 ul from the 100 tube and add to 2nd tube and mix
          - Repeate for four dilutions (get: 100, 25, 6.25, 1.56, 0.39, 0.09ng of DNA)
          - 96-Well-qPCR-Plate-Map_Primer_dilutions_final.xlsx
  - Set up plate and run qPCR - 3 technical replicates for each:
      - 96-Well-qPCR-Plate-Map_Primer_dilutions_final.xlsx        
  - Calculate Standard curve:
      - calc_Primer_efficiency.xlsx


## 3. Design qPCR experiment and Run
  - Run qPCR on 6 populations with 4 primers (TRIM, STING, cGAS, Catalyse) with 3 technical replicates (one population per plate)
      - Plate-Map_Immunity_qPCR.xlsx

## 4. Analyze qPCR Results
  - Calculate the copy number based on the Catalyse activity:
      - Copy_Number_Calc-Immunity_qPCR.xlsx
  - Analyze qPCR results:
      - Nematostella_copy_number_analysis_11-10-23.R
