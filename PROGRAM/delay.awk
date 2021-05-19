BEGIN {
st=0
et=0
i=1
f=0
avg=0
d=0
}
{
if(FILENAME=="tdly.tr") {
start=$1
end=$2
sender=$3
rec=$4
}
if(FILENAME=="usor.tr") {
if($3>=start && $3 <=end) {
if($1=="s" || $1=="r" || $1=="f" || $1=="d") {
if($31~sender && $33~rec) {
if($7>=0) {
if(flg == 0) {
sta=$41
flg=1
}
else {
en=$41
}
val[i,1]=$3
val[i,2]=$41
print $3" "$41
i++
}
}
}
}
}
}
END {
for(j=1;j<i;j++) {
for(l=2;l<i-1;l++) {
if(val[j,2]==val[l,2]) {
d=val[j,1]
}
else {
break
}
}
}
avg=d-val[1,1]
print end" "avg > "tmp"sender
}
