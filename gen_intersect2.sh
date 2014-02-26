#!/bin/bash
###############################################################
###############################################################
# sub routine for generating corrected tree
###############################################################
###############################################################
gen_tree () {
	Exefile=$1
	TreeFormat=$2
	IntvFormat=$3
	OutFile=$4
	#tmp="$4.tmp"
	#treeformat="$4.tftmp"
	#intvformat="$4.iftmp"
	#tf_len=$(awk 'END{print NF}' $TreeFormat)
	#if_len=$(awk 'END{print NF}' $IntvFormat)
	##echo $treeformat $intvformat
	##echo $tf_len $if_len
	if [ -e "$TreeFormat" ] && [ -e "$IntvFormat" ]
	then
		$Exefile $IntvFormat $TreeFormat $OutFile
		#join "$TreeFormat" "$IntvFormat">$tmp
		#if [ -s "$tmp" ]
		#then
		#	awk '{for(i=1;i<=tlen;i++)if(i!=tlen)printf("%s ", $i);else printf("%s \n", $i)}' tlen=$tf_len $tmp > $treeformat
		#	awk '{printf "%s ", $1; for(i=tlen+1;i<=NF;i++)if(i!=NF)printf("%.2f ",$i);else printf("%.2f\n",$i)}' tlen=$tf_len $tmp > $intvformat
		#	if [ -f "$Exefile" ]
		#	then
		#		$Exefile $intvformat $treeformat $OutFile
		#	fi
		#rm $treeformat $intvformat $tmp
		#fi
	fi
}
###############################################################
###############################################################
# main part of the shell program
###############################################################
###############################################################
exe_file=$1
ori_tree_dir=$2
gen_intv_dir=$3
prefix=$5

if test -e "$4"
then
	out_tree_dir=$4
else
	mkdir $4
	out_tree_dir=$4
fi

for i in $(ls $ori_tree_dir|grep "$prefix.*\\.tree");do
	intv_prefix=${i%.*}
	gen_intv_file=$(ls $gen_intv_dir|grep "$(echo $intv_prefix|sed -n s/$/_/gp)")
	gen_tree "$exe_file" "$ori_tree_dir$i" "$gen_intv_dir$gen_intv_file" "$out_tree_dir$i"
done
