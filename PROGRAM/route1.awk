BEGIN {
i=0
pkt=512
itv=0.01
j=0
d=0
}

{
 if(FILENAME=="rtemp") 
 {
  src=$1
  des=$2
  tm=$3
  itval=$4
  itvl=$5
  clr=$6
  flg=$7
  ff=$8
 }

 if(FILENAME=="Attacker") {
 att=$1
 dnd=$2
 vic=$3
 }

 if(FILENAME=="dflag") {
 stat=$1
 stat1=$2
 }

 if(FILENAME=="IDSnode") {
  ids[j]=$1;j++
 }

 if(FILENAME=="Neighbor") # Get (x,y) coordination
  {
  if(i==$1) 
  {
   s[i,1]=$1
   s[i,2]=$3
   s[i++,3]=$4
  }
  if($1>=0 && $1<=100) 
  {
   n[d,1]=$1
   n[d,2]=$2
   n[$1,$2]=$5
   d++
  }
}
 if(FILENAME=="Route-Pseudonym") # Get (x,y) coordination
  if($1>=0 && $1<=50)  
  {
  n[$1]=$2
  nym[$1]=$3
  ks[$1]=$4
  }


 }

END {
for(ll=0;ll<5;ll++)
a[ll]=-1


 tm1=tm+0.1
 min=2500
 k=0
 desx=s[des,2]
 desy=s[des,3]
 a[0]=src
 for(hct=0;a[hct]!=des;hct++)
 {
 src=a[hct] # Alternative src node
 k=k+1
 srcx=s[src,2]
 srcy=s[src,3]
 for(j=0;j<i;j++) # find all node Distances
  {
   if(src!=j && j!=stat && j!=stat1)
   { 
    x=s[j,2]
    y=s[j,3]
    srcd=int(sqrt(((x-srcx)^2)+((y-srcy)^2)))
    desd=int(sqrt(((x-desx)^2)+((y-desy)^2)))

    if(srcd<230 && desd<min) # Check high dist from src and low dis from des
     {
        min=desd
	a[k]=j
     }
   }
  }
 }

dis=1000
att2=-1
if(att!=-1 && stat==-1) {
for(j=0;j<d;j++) {
if(n[j,1]==vic && n[n[j,2],dnd]!="") {
print n[j,2]" "n[n[j,2],dnd]
if(n[j,2]!=ids[0] && n[j,2]!=ids[1] && n[j,2]!=ids[2] && n[j,2]!=ids[3] && n[j,2]!=ids[4] && n[j,2]!=ids[5] && n[j,2]!=a[0] && n[j,2]!=a[1] && n[j,2]!=a[2] && n[j,2]!=a[3] && n[j,2]!=a[4] && n[j,2]!=a[5] && n[n[j,2],dnd]<=dis) {
dis=n[n[j,2],dnd]
att2=n[j,2]
print att2"---------"vic" "dnd" "dis
}
}
}

if(att2!=-1) {
  #print "set inf [attach-CBR-traffic $node_("att2") $sink("vic") "pkt" 0.01]" > "route.tcl"
  #print "$ns_ at "tm" \"$inf start\"" > "route.tcl"
  #print "$ns_ at "tm+0.5" \"$inf stop\"" > "route.tcl"
  #print "$ns_ at "tm+0.6" \"$node_("att2") add-mark C4 black circle \"" > "route.tcl" 
  #print "$ns_ at "tm+0.6" \"$node_("att2") label Attacker \"" > "route.tcl" 
  #print "$ns_ at "tm+0.6" \"$node_("att2") color white \"" > "route.tcl" 
}
  print "$ns_ at "tm+0.6" \"$node_("att") add-mark C4 black circle \"" > "route.tcl" 
  print "$ns_ at "tm+0.6" \"$node_("att") label Attacker \"" > "route.tcl" 
  print "$ns_ at "tm+1" \"$node_("att") color white \"" > "route.tcl" 

  print "$ns_ at "tm" \"bcast 0 49 "tm+0.5" 0.1 "dnd" "att" "att2"\"" > "route.tcl"
#itvl=0.6
#tm=tm+0.5
}


nd=-1
if(att==-1) {
if(flg==clr) {
f=1
cnt=0
while(f) {
#if(cnt>=10000) { break;print "Going to terminate" > "route.tcl" 
#print "exit 0" > "route.tcl"
#exit }
nd=int(rand()*hct)
print nd
cnt++
if(nd!=0 && nd!=hct-1 && a[nd]!=ids[0] && a[nd]!=ids[1] && a[nd]!=ids[2] && a[nd]!=ids[3] && a[nd]!=ids[4] && a[nd]!=ids[5])
f=0
}
#print a[nd] > "Attacker"
} 
}

 print "$ns_ at "tm" \"$node_("des") color "clr"\"" > "route.tcl" 
 print "$ns_ at "tm" \"$node_("a[0]") color "clr"\"" > "route.tcl" 
 print a[0] > "path"ff
 print a[0] > "path"

for(q=0;q<hct;q++) {
print a[q+1] > "path"ff
print a[q+1] > "path"

if(q==nd)
itv=0.005
else
itv=0.08

print "\t\t"a[q]"\t"n[a[q-1]]"\t"n[a[q]]"\t"ks[a[q-1]]"\t\t"ks[a[q]] > "RouteTable"

  print "set inf"q" [attach-CBR-traffic $node_("a[q]") $sink("a[q+1]") "pkt" "itv"]" > "route.tcl"
  print "$ns_ at "tm" \"$inf"q" start\"" > "route.tcl"
  print "$ns_ at "tm+itvl" \"$inf"q" stop\"" > "route.tcl"
  print ("$ns_ at "tm+0.025" \"$ns_ trace-annotate \\\"Node - "a[q]" sends Data packet to Node - "a[q+1]" \\\"\"") > "route.tcl"
  print "$ns_ at "tm" \"$node_("a[q+1]") color "clr"\"" > "route.tcl" 
  print "$ns_ at "tm" \"$node_("a[q]") color "clr"\"" > "route.tcl" 
  print "$ns_ at "tm+itvl" \"$node_("a[q+1]") color black\"" > "route.tcl" 
  print "$ns_ at "tm+itvl" \"$node_("a[q]") color black\"" > "route.tcl" 
  tm=tm+0.01
 }


print "\t\t"a[q]"\t"n[a[q]]"\t"n[a[q+2]]"\t"ks[a[q]]"\t\t"ks[a[q+2]] > "RouteTable"
}
