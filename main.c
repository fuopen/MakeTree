#include<stdio.h>
#include<stdlib.h>
#include"gen_func.h"
#include"file.h"
#include"tree.h"
#include"list.h"

int main(int argc,char** argv){
	if(argc!=4){
		perror("Invalid Arguments Numbers\n");
		exit(124);
	}

	FLOAT** flt;
	STRING* itv;
	STRING* tfs;
	int frow=0,fcol=0,trow=0;
	MakeFloatTable(argv[1],&flt,&frow,&fcol);
	MakeTreeFormat(argv[2],&itv,&tfs,&trow);
	STRING* ntf=(STRING*) malloc(sizeof(STRING)*trow);;
	int i;
	FILE* fp=fopen(argv[3],"w");
	for(i=0;i!=trow;i++){
		STRING s=tfs[i];
		FLOAT* f=cumsum(flt[i],fcol);
		CorrectTree(tfs[i],&ntf[i],f,fcol);
		fprintf(fp,"%s %s",itv[i],ntf[i]);
		if(i!=trow-1)fprintf(fp,"\n");
		free(f);
		free(itv[i]);
		free(tfs[i]);
		free(flt[i]);
		free(ntf[i]);
	}
	free(tfs);
	free(itv);
	free(flt);
	free(ntf);
	fclose(fp);
	return 0;
}
