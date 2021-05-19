BEGIN {
p=0
pks=64
itv=0.05
}
{
if(FILENAME=="btmp") {
stnd=$1
ednd=$2
tm=$3
itval=$4
src=$5
}


if(FILENAME=="Neighbor" ) {
if($1>=0 && $1<=100) {
n[p,1]=$1
n[p,2]=$2
n[p,3]=$5
p++
}
}
}


END {
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
	print "set inf"y" [attach-CBR-traffic $node_("m[i,1]") $sink("m[i,2]") "pks" "itv"]" > "flood.tcl"
	print "$ns_ at "tm" \"$inf"y" start\"" > "flood.tcl"
	print "$ns_ at "tm+itval" \"$inf"y" stop\"" > "flood.tcl"
	print "$ns_ at "tm" \"$node_("m[i,2]") color maroon\"" > "flood.tcl"
	print "$ns_ at "tm" \"$node_("m[i,1]") color blue\"" > "flood.tcl"
	print "$ns_ at "tm+itval" \"$node_("m[i,2]") color purple\"" > "flood.tcl"
	print "$ns_ at "tm+itval" \"$node_("m[i,1]") color purple\"" > "flood.tcl" 
	print ("$ns_ at "tm+0.025" \"$ns_ trace-annotate \\\"Node - "m[i,1]" forwards the Topology Discovery packet with master key value to its neighbor "m[i,2]" \\\"\"") > "flood.tcl"
tm=tm+0.05
}	
}														
