BEGIN {
p=0
q=0
pks=64
itv=0.05
print "\n\tSource\tRoute-pseudonym\tNonce\tBroadcastkey\n" > "Route-Pseudonym"
}

{
if(FILENAME=="btemp") {
stnd=$1
ednd=$2
tm=$3
itval=$4
src=$5
dst=$6
hash=$7
}


if(FILENAME=="Neighbor" ) {
if($1>=0 && $1<=100) {
n[p,1]=$1
n[p,2]=$2
n[p,3]=$5
p++
}
}

if(FILENAME=="KeyDetails" ) {
if($1>=0 && $1<=100) {
sig[$1]=$2
id[$1]=$3
ses[$1,$3]=$5
brd[$1]=$6
q++
}
}
}


END {

# Route Pseudonym
for(i=stnd;i<ednd;i++) {
nr[i]=int(rand()*50) i
f=1
while(f) {
f=0
nonce[i]=int(rand()*1100)
for(l=0;l<i;l++) {
if(nonce[i]==nonce[l] && nonce[i]<1000) {
f=1
break
}
f=0
}
}
#print nonce[i]" "nr[i]
}


for(i=stnd;i<ednd;i++) {
nym[i]=hash nonce[i]*brd[i]
print "\t"i"\t"nr[i]"\t\t"nym[i]"\t"brd[i] > "Route-Pseudonym"
}


# Des ID 
for(i=0;i<p;i++) {
if(n[i,1]==dst) {
sd=id[i,2]
}
}

# Acending order 
 for(x=0;x<p;x++)
 {
  for(y=x+1;y<p;y++)
  {
   
   if(n[x,3]>n[y,3] && n[x,1]==n[y,1])
   {
    temp1=n[x,3]
    n[x,3]=n[y,3]
    n[y,3]=temp1

    temp2=n[x,2]
    n[x,2]=n[y,2]
    n[y,2]=temp2
   }
  }
 }


x=0
y=0
a[0]=src

for(s=stnd;s<=x;s++) #indicate Route order
 {
  src=a[s]
  for(j=stnd;j<p;j++)
   { 
    f=1
    if(src==n[j,1]) 
    {
      for(s1=0;s1<=x;s1++) #check chain format
      { 
        if(a[s1]==n[j,2])
         f=0
      } 
      if(f==1)
      {
       m[x,1]=n[j,1]
       m[x,2]=n[j,2]
       a[x+1]=n[j,2]
       x++
       
      }
    }
  }
 }


# Print into file
for(i=0;i<x;i++)
{
# For Unobservable Route-Request
if(m[i,1]==m[i-1,1]) {
 print "set inf"y" [attach-CBR-traffic $node_("m[i,1]") $sink("m[i,2]") "pks" "itv"]" > "bcast.tcl"
	print "$ns_ at "tm" \"$inf"y" start\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$inf"y" stop\"" > "bcast.tcl"
	print "$ns_ at "tm" \"$node_("m[i,2]") color maroon\"" > "bcast.tcl"
	print "$ns_ at "tm" \"$node_("m[i,1]") color blue\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$node_("m[i,2]") color green4\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$node_("m[i,1]") color green4\"" > "bcast.tcl" 
	print ("$ns_ at "tm+0.025" \"$ns_ trace-annotate \\\"Node - "m[i,1]" sends the RouteRequest packet to its neighbor - "m[i,2]" \\\"\"") > "bcast.tcl"
  y++
  tm=tm+0.01

if(id[m[i,2]]==sd) {break}

} else {
 tm=tm+0.01
 print "set inf"y" [attach-CBR-traffic $node_("m[i,1]") $sink("m[i,2]") "pks" "itv"]" > "bcast.tcl"
	print "$ns_ at "tm" \"$inf"y" start\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$inf"y" stop\"" > "bcast.tcl"
	print "$ns_ at "tm" \"$node_("m[i,2]") color maroon\"" > "bcast.tcl"
	print "$ns_ at "tm" \"$node_("m[i,1]") color blue\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$node_("m[i,2]") color green4\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$node_("m[i,1]") color green4\"" > "bcast.tcl" 
	print ("$ns_ at "tm+0.025" \"$ns_ trace-annotate \\\"Node - "m[i,1]" sends the RouteRequest packet to its neighbor - "m[i,2]" \\\"\"") > "bcast.tcl"
  y++
  tm=tm+0.01

if(id[m[i,2]]==sd) {break}

}
}


print tm+itval > "Time"
}
