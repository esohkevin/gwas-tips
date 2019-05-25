echo 'If pulling from github, change --geneticMapFile to ../tables/genetic_map_hg19_example.txt.gz'
echo

for chr in {1..2}; do
 ../eagle \
    --vcfRef=ref.bcf \
    --vcfTarget=target.vcf.gz \
    --geneticMapFile=../tables/genetic_map_hg19_withX.txt.gz \
    --outPrefix=target.phased \
    --chrom ${chr} \
    2>&1 | tee example_ref.log

done

# --vcfOutFormat: Specify output format (.vcf, .vcf.gz, or .bcf)
# --noImpMissing: Turn off imputation of missing genotypes
# --bpStart=50e6, --bpEnd=100e6, and --bpFlanking=1e6: Impute genotypes to specific regions
# --Kpbwt=10000: Adjust speed and accuracy of impuatation. Increase value to improve accuracy
