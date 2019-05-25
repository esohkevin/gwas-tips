for i in chr*.filtered.vcf.gz; do
echo "`tabix -f -p vcf ${i}`"
done


bcftools concat -a -d snps -Oz \
chr1.filtered.vcf.gz \
chr2.filtered.vcf.gz \
chr3.filtered.vcf.gz \
chr4.filtered.vcf.gz \
chr5.filtered.vcf.gz \
chr6.filtered.vcf.gz \
chr7.filtered.vcf.gz \
chr8.filtered.vcf.gz \
chr9.filtered.vcf.gz \
chr10.filtered.vcf.gz \
chr11.filtered.vcf.gz \
chr12.filtered.vcf.gz \
chr13.filtered.vcf.gz \
chr14.filtered.vcf.gz \
chr15.filtered.vcf.gz \
chr16.filtered.vcf.gz \
chr17.filtered.vcf.gz \
chr18.filtered.vcf.gz \
chr19.filtered.vcf.gz \
chr20.filtered.vcf.gz \
chr21.filtered.vcf.gz \
chr22.filtered.vcf.gz \
-o merge.filtered.vcf.gz

#zgrep "^#" chr1.filtered.vcf.gz > merged.filtered.vcf.gz
#zgrep -v "^#" chr1.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr2.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr3.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr4.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr5.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr6.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr7.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr8.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr9.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr10.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr11.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr12.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr13.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr14.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr15.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr16.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr17.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr18.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr19.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr20.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr21.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chr22.filtered.vcf.gz >> merged.filtered.vcf.gz
#zgrep -v "^#" chrX.auto.filtered.vcf.gz >> merged.filtered.vcf.gz 
#zgrep -v "^#" chrX.no.auto_female.filtered.vcf.gz >> merged.filtered.vcf.gz
