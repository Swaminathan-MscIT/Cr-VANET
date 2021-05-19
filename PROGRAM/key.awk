BEGIN {
i=0
k=0
c=-1
fflg=0
ds=0
print"\n  --------------------------------------------------------------------------------------------" > "KeyDetails"
print"    Node-ID\tSignature\tID-based Key\tNeighbor-ID\tSessionKey\tBroadcast-Key" > "KeyDetails"
print"  --------------------------------------------------------------------------------------------" > "KeyDetails"

print "\n\t---------------------------------------------------------------" > "IDS_Table"
print "\t\tIDS_Node\tNeighborNode\tDistance" > "IDS_Table"
print "\t---------------------------------------------------------------" > "IDS_Table"
}

{
if(FILENAME=="ntemp") {
stnd=$1
ednd=$2
tm=$3
itval=$4
hsh=$5
}

if(FILENAME=="Neighbor") {
if($1>=0 && $1<=100) {
n[i,1]=$1
n[i,2]=$2
n[i,3]=$5
i++
}
}

if(FILENAME=="RNumber") {
r[$1]=$2
}

if(FILENAME=="KeyServer.txt") {
id[$2]=$3
gsk[$2]=$4
}

if(FILENAME=="IDSnode") {
ids[ds++]=$1
}

}

END {
# Signature Generation
for(j=stnd;j<=ednd;j++) {
sig[j]=r[j]*gsk[j]
print sig[j]
}

for(j=0;j<i;j++) {

ses[n[j,1],n[j,2]]=hsh r[n[j,1]]*r[n[j,2]]
print ses[n[j,1],n[j,2]]" "n[j,1]" "n[j,2]

if(c!=n[j,1]) {

# broadcast key generation
ff=1
while(ff) {
bky=rand()*200
if(bky>=100 && bky<=200) {
bkey="0"n[j,1] int(rand()*500)
ff=0 
}
}
print "" > "KeyDetails"
src=n[j,1]
c=n[j,1]
t=tm+0.03
tm=tm+itval
}
print"  \t"n[j,1]"\t"sig[src]"            "id[src]"            "n[j,2]"            "ses[n[j,1],n[j,2]]"            "bkey > "KeyDetails"
print "set cbr"src"_"n[j,2]" [attach-CBR-traffic $node_("src") $sink("n[j,2]") 64 0.06]" > "key.tcl"
print "$ns_ at "t" \"$cbr"src"_"n[j,2]" start\"" > "key.tcl"
print "$ns_ at "t+itval" \"$cbr"src"_"n[j,2]" stop\"" > "key.tcl"
print "$ns_ at "t" \"$node_("src") color maroon\"" > "key.tcl"
#print "$ns_ at "t+itval" \"$node_("src") color black\"" > "key.tcl" 
print ("$ns_ at "t+0.025" \"$ns_ trace-annotate \\\"node_ - "src" send the Hello message with key values to its neighbor - "n[j,2]" \\\"\"") > "key.tcl"
t=t+0.01

print "set cbr"src"_"n[j,2]" [attach-CBR-traffic $node_("n[j,2]") $sink("src") 64 0.06]" > "key.tcl"
print "$ns_ at "t" \"$cbr"src"_"n[j,2]" start\"" > "key.tcl"
print "$ns_ at "t+itval" \"$cbr"src"_"n[j,2]" stop\"" > "key.tcl"
print ("$ns_ at "t+0.025" \"$ns_ trace-annotate \\\"node_ - "src" send the reply hello key message with session to its neighbor - "n[j,2]" \\\"\"") > "key.tcl"
t=t+0.01

print "set cbr"src"_"n[j,2]" [attach-CBR-traffic $node_("src") $sink("n[j,2]") 64 0.06]" > "key.tcl"
print "$ns_ at "t" \"$cbr"src"_"n[j,2]" start\"" > "key.tcl"
print "$ns_ at "t+itval" \"$cbr"src"_"n[j,2]" stop\"" > "key.tcl"
print ("$ns_ at "t+0.025" \"$ns_ trace-annotate \\\"node_ - "src" send about the acceptance of session key with broadcast key to its neighbor - "n[j,2]" \\\"\"") > "key.tcl"
t=t+0.01
} 


for(ls=0;ls<9;ls++) {
print "" > "IDS_Table"
for(j=0;j<i;j++) {
if(n[j,1]==ids[ls])
print "\t\t   "n[j,1]"\t\t"n[j,2]"\t\t"n[j,3] > "IDS_Table"
}

}
}
