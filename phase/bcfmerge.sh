for i in chr*-phased_wref.vcf.gz; do
echo "`tabix -f -p vcf ${i}`"
done


bcftools concat -a -d snps -Oz \
chr1-phased_wref.vcf.gz \
chr2-phased_wref.vcf.gz \
chr3-phased_wref.vcf.gz \
chr4-phased_wref.vcf.gz \
chr5-phased_wref.vcf.gz \
chr6-phased_wref.vcf.gz \
chr7-phased_wref.vcf.gz \
chr8-phased_wref.vcf.gz \
chr9-phased_wref.vcf.gz \
chr10-phased_wref.vcf.gz \
chr11-phased_wref.vcf.gz \
chr12-phased_wref.vcf.gz \
chr13-phased_wref.vcf.gz \
chr14-phased_wref.vcf.gz \
chr15-phased_wref.vcf.gz \
chr16-phased_wref.vcf.gz \
chr17-phased_wref.vcf.gz \
chr18-phased_wref.vcf.gz \
chr19-phased_wref.vcf.gz \
chr20-phased_wref.vcf.gz \
chr21-phased_wref.vcf.gz \
chr22-phased_wref.vcf.gz \
-o autosomePhase_wref.vcf.gz

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
