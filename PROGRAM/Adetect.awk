BEGIN {
i=0
j=0;l=0
}

{
if(FILENAME=="IDS_Table") {
n[i,1]=$1
n[i,2]=$2
n[i,3]=$3
i++
}

if(FILENAME=="Load") {
if($1>=0 && $1<=100) {
nd[j]=$1
ld[j]=$2
j++
}
}

}
END {
mnd=-1
for(s=1;s<j;s++) {
if((ld[s]-ld[1])>=3000) {
print nd[s-1] 
mnd=nd[s-1]
vic=nd[s]
}
}

dis=1000
for(l=0;l<i;l++) {
if(n[l,2]==mnd && n[l,3]<dis) {
ids=n[l,1]
dis=n[l,3]
print ids"----- "dis" "mnd
}
}

print mnd" "ids" "vic > "Attacker"

}



