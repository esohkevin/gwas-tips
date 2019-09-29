plink --bfile qc-camgwas --exclude Exclude-qc-camgwas-1000G.txt --make-bed --out TEMP1
plink --bfile TEMP1 --update-map Chromosome-qc-camgwas-1000G.txt --update-chr --make-bed --out TEMP2
plink --bfile TEMP2 --update-map Position-qc-camgwas-1000G.txt --make-bed --out TEMP3
plink --bfile TEMP3 --flip Strand-Flip-qc-camgwas-1000G.txt --make-bed --out TEMP4
plink --bfile TEMP4 --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --out qc-camgwas-updated
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 1 --out qc-camgwas-updated-chr1
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 2 --out qc-camgwas-updated-chr2
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 3 --out qc-camgwas-updated-chr3
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 4 --out qc-camgwas-updated-chr4
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 5 --out qc-camgwas-updated-chr5
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 6 --out qc-camgwas-updated-chr6
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 7 --out qc-camgwas-updated-chr7
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 8 --out qc-camgwas-updated-chr8
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 9 --out qc-camgwas-updated-chr9
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 10 --out qc-camgwas-updated-chr10
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 11 --out qc-camgwas-updated-chr11
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 12 --out qc-camgwas-updated-chr12
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 13 --out qc-camgwas-updated-chr13
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 14 --out qc-camgwas-updated-chr14
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 15 --out qc-camgwas-updated-chr15
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 16 --out qc-camgwas-updated-chr16
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 17 --out qc-camgwas-updated-chr17
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 18 --out qc-camgwas-updated-chr18
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 19 --out qc-camgwas-updated-chr19
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 20 --out qc-camgwas-updated-chr20
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 21 --out qc-camgwas-updated-chr21
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 22 --out qc-camgwas-updated-chr22
plink --bfile qc-camgwas-updated --reference-allele Force-Allele1-qc-camgwas-1000G.txt --make-bed --chr 23 --out qc-camgwas-updated-chr23
rm TEMP*
