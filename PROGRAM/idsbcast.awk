BEGIN {
p=0
pks=64
itv=0.05
}

{
if(FILENAME=="btemp") {
stnd=$1
ednd=$2
tm=$3
itval=$4
src=$5
flg=$6
flg1=$7
}


if(FILENAME=="IDS_Table") {
if($1>=0 && $1<=100) {
n[p,1]=$1
n[p,2]=$2
p++
}
}

if(FILENAME=="Neighbor") {
if($1>=0 && $1<=100) {
n[p,1]=$1
n[p,2]=$2
n[p,3]=$5
p++
}
}

}


END {

if(flg==-1) {

for(i=0;i<p;i++)
{
if(n[i,1]==src) {
print "set inf"y" [attach-CBR-traffic $node_("n[i,1]") $sink("n[i,2]") "pks" "itv"]" > "bcast.tcl"
	print "$ns_ at "tm" \"$inf"y" start\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$inf"y" stop\"" > "bcast.tcl"
	print "$ns_ at "tm" \"$node_("n[i,2]") color black\"" > "bcast.tcl"
	print "$ns_ at "tm" \"$node_("n[i,1]") color blue\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$node_("n[i,2]") color maroon\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$node_("n[i,1]") color maroon\"" > "bcast.tcl" 
	print ("$ns_ at "tm+0.025" \"$ns_ trace-annotate \\\"Node - "n[i,1]" sends the Advertisement Packet to its neighbor - "n[i,2]" \\\"\"") > "bcast.tcl"
  y++
  tm=tm+0.001
}
}
} else {


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

#for(x=0;x<p;x++)
# {
# print n[x,1]" - " n[x,2]" - " n[x,3]
#}


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
if(m[i,1]!=flg && m[i,2]!=flg && m[i,1]!=flg1 && m[i,2]!=flg1) {
 print "set inf"y" [attach-CBR-traffic $node_("m[i,1]") $sink("m[i,2]") "pks" "itv"]" > "bcast.tcl"
	print "$ns_ at "tm" \"$inf"y" start\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$inf"y" stop\"" > "bcast.tcl"
	print "$ns_ at "tm" \"$node_("m[i,2]") color maroon\"" > "bcast.tcl"
	print "$ns_ at "tm" \"$node_("m[i,1]") color blue\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$node_("m[i,2]") color black\"" > "bcast.tcl"
	print "$ns_ at "tm+itval" \"$node_("m[i,1]") color black\"" > "bcast.tcl" 
	print ("$ns_ at "tm+0.025" \"$ns_ trace-annotate \\\"Node - "m[i,1]" sends an alarm msg about the presence of adversaries in the network - "m[i,2]" \\\"\"") > "bcast.tcl"
  y++
  tm=tm+0.01
}
}
print flg" "flg1 > "dflag"
}

}



