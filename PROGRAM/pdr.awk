BEGIN {
print "LabelFont: Monospace" > "M-PDR.xg"
print "TitleFont: Monospace" > "M-PDR.xg"
print "MARKERS: TRUE" > "M-PDR.xg"
print "BoundBox: true" > "M-PDR.xg"

print "LabelFont: Monospace" > "M-Drop.xg"
print "TitleFont: Monospace" > "M-Drop.xg"
print "MARKERS: TRUE" > "M-Drop.xg"
print "BoundBox: true" > "M-Drop.xg"
	t=0;d=0
	itval=3
	dest=34
}

{

	if($3<=t && $32=="-Id") {
		if($1=="r" && $19=="AGT") {
			r++
		}
		if($1=="d" && $21!="COL") {
			d++
		}
	}
			
	if($3>t && $32=="-Id") {
		if($1=="r" && $19=="AGT") {
			r++
		}
		if($1=="d" && $21!="COL") {
			d++
		}
		s=r+d
	if(s!=0) {
		pdr=r/s
		print t " \t"pdr > "M-PDR.xg"
		print t " \t"d > "M-Drop.xg"
		s=0
		r=0
		d=0
		}
		t=t+itval	
	}
	
}

END {
	s=r+d
	if(s!=0) {
		pdr=r/s
		print t " \t"pdr > "M-PDR.xg"
		print t " \t"d > "M-Drop.xg"
	}

}

