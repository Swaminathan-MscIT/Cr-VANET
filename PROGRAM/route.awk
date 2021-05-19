BEGIN {
i=0
pks=64
pks1=512
itv=0.05
print "\n\t---------------------------------------------------------------------" > "RouteTable"
print "\t\tNode\tP_RNym\tN_RNym\tPrev_Hop\tNext_Hop" > "RouteTable"
print "\t---------------------------------------------------------------------" > "RouteTable"
}

{
 if(FILENAME=="ntemp") 
 {
  src=$1
  des=$2
  tm=$3
  itval=$4
  itvl=$5
  clr=$6
 }

 if(FILENAME=="Neighbor") # Get (x,y) coordination
  if(i==$1) 
  {
   s[i,1]=$1
   s[i,2]=$3
   s[i++,3]=$4
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
   if(src!=j)
   { 
    x=s[j,2]
    y=s[j,3]
    srcd=int(sqrt(((x-srcx)^2)+((y-srcy)^2)))
    desd=int(sqrt(((x-desx)^2)+((y-desy)^2)))

    if(srcd<=250 && desd<min) # Check high dist from src and low dis from des
     {
        min=desd
	a[k]=j
     }
   }
  }
 }

 print "$ns_ at "tm" \"$node_("des") color "clr"\"" > "route.tcl" 

 print a[0] > "path"
  for(q=hct;q>0;q--)
 {
  print "set inf"q" [attach-CBR-traffic $node_("a[q]") $sink("a[q-1]") "pks" "itv"]" > "route.tcl"
  print "$ns_ at "tm" \"$inf"q" start\"" > "route.tcl"
  print "$ns_ at "tm+itval" \"$inf"q" stop\"" > "route.tcl"
  #print "$ns_ at "tm" \"$node_("a[q-1]") color "clr[x]"\"" > "route.tcl" 
  #print "$ns_ at "tm+itval" \"$node_("a[q-1]") color green4\"" > "route.tcl" 
  print ("$ns_ at "tm+0.025" \"$ns_ trace-annotate \\\"Node - "a[q]" sends Route Reply packet to Node - "a[q-1]" \\\"\"") > "route.tcl"
print "$ns_ at "tm" \"$node_("a[q-1]") color "clr"\"" > "route.tcl" 
tm=tm+0.1
}

for(q=0;q<hct;q++) {
print a[q+1] > "path"
print "\t\t"a[q]"\t"n[a[q-1]]"\t"n[a[q]]"\t"ks[a[q-1]]"\t\t"ks[a[q]] > "RouteTable"

  print "set inf"q" [attach-CBR-traffic $node_("a[q]") $sink("a[q+1]") "pks1" "itv"]" > "route.tcl"
  print "$ns_ at "tm" \"$inf"q" start\"" > "route.tcl"
  print "$ns_ at "tm+itvl" \"$inf"q" stop\"" > "route.tcl"
  print ("$ns_ at "tm+0.025" \"$ns_ trace-annotate \\\"Node - "a[q]" sends Data packet to Node - "a[q+1]" \\\"\"") > "route.tcl"
print "$ns_ at "tm" \"$node_("a[q+1]") color "clr"\"" > "route.tcl" 
tm=tm+0.1
 }

q=hct-1
print "\t\t"a[q]"\t"n[a[q]]"\t"n[a[q+2]]"\t"ks[a[q]]"\t\t"ks[a[q+2]] > "RouteTable"
}
