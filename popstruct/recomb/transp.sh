#!/bin/bash



if [[ $2 != '\t' ]]; then

    file="$1"
    sep="$2"
    nsites=$(sed '1d' $file | wc -l)
    nsamp=$(head -1 $file | sed s/"$sep"/"\n"/g | wc -l)
    
    echo -e "$nsamp"$sep"$nsites"$sep"1""" > t${file}

    #numc=$(($(head -n 1 "$file" | grep -o "$sep" | wc -l)+1))
    for ((i=1; i<="$nsamp"; i++))
    #do cut -d "$sep" -f"$i" "$file" | paste -s -d "$sep" >> t${file}

    do cut -d "$sep" -f"$i" $file | \
	  paste -s -d "$sep" | \
	  awk -v col="$i" '{print ">"$col}';
       cut -d "$sep" -f"$i" $file | \
	  paste -s -d "$sep" | \
	  cut -f 2- -d "$sep" | \
	  sed 's/ //g' | \
	  fold -2000;
    done >> t$file

else
    file="$1"
    sep="$2"
    nsites=$(sed '1d' $file | wc -l)
    nsamp=$(head -1 $file | sed s/"$sep"/"\n"/g | wc -l)
    
    echo -e "$nsamp"$sep"$nsites"$sep"1""" > t${file}
    

    for i in $(seq 1 $nsamp); do
        cut -f$i $file | \
           paste -s -d' ' | \
           awk '{print ">"$1}'; 
        cut -f$i $file | \
           paste -s -d' ' | \
           cut -f 2- -d' ' | \
           sed 's/ //g' | \
           fold -2000; 
    done >> t$file

#    do cut -f"$i" $file | \
#          paste -s -d' ' | \
#          awk -v col="$i" '{print ">"$col}' >> t$file
#       cut -f"$i" $file | \
#          paste -s -d' ' | \
#          cut -f 2- -d' ' | \
#          sed 's/ //g' | \
#          fold -2000 >> t$file
#
#    done

fi
