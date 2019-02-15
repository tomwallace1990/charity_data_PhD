*global path1 ""
global path1 ""
global path11 ""
global path12 ""
global path13 ""
*global path3 ""
*global path7 "" 

* Temporary folder:
*global path9 "" 
global path9 ""

********************
*Sequence analysis of funding and staff/trustee numbers
********************

*Gross income
********************
{
use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

sum annualreturninformationgrossinco, detail

keep if annualreturninformationgrossinco ~=.

capture drop pid
egen pid = group(charitynumbernum)

foreach val in 33 67 {
	capture drop grossincomcat`val'
	egen grossincomcat`val'=pctile(annualreturninformationgrossinco), p(`val') by(charitynumbernum)
}
*
capture drop grossincomcat
gen grossincomcat =.

recode grossincomcat .=1 if annualreturninformationgrossinco<=grossincomcat33
recode grossincomcat .=2 if annualreturninformationgrossinco<grossincomcat67
recode grossincomcat .=3 if annualreturninformationgrossinco>=grossincomcat67

drop grossincomcat33
drop grossincomcat67

tab grossincomcat

tab year grossincomcat, col

*Wide
keep grossincomcat charitynumbernum yearaccount
reshape wide grossincomcat, i(charitynumbernum) j(yearaccount)

*sequence analysis to detect drops in income, staff ect
cap drop seqstr

stripe grossincomcat2007-grossincomcat2015, gen(seqstr) symb("lMH")

count if regexm(seqstr,"H+M+l+") | regexm(seqstr,"H+l+")

*Coding drop - ^ means begining with, $ means ends with, * means and
capture drop dropinco
gen dropinco=0
recode dropinco 0=1 if regexm(seqstr,"H+M+l+")
recode dropinco 0=1 if regexm(seqstr,"H+l+")

tab dropinco

*Spells
capture drop nspinco
nspells grossincomcat* , gen(nspinco)

tab nspinco

*Remerge with main data
reshape long

*sav
keep dropinco nspinco yearaccount charitynumbernum 

sav "$path9/dropinco.dta" , replace

*Graphing and balancing
use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

sum annualreturninformationgrossinco, detail

keep if annualreturninformationgrossinco ~=.

capture drop allyears
bys charitynumbernum:gen allyears=[_N]
tab allyears

keep if allyears==9

xtset charitynumbernum yearaccount
xtdes

capture drop pid
egen pid = group(charitynumbernum)

foreach val in 33 67 {
	capture drop grossincomcat`val'
	egen grossincomcat`val'=pctile(annualreturninformationgrossinco), p(`val') by(charitynumbernum)
}
*
capture drop grossincomcat
gen grossincomcat =.

recode grossincomcat .=1 if annualreturninformationgrossinco<=grossincomcat33
recode grossincomcat .=2 if annualreturninformationgrossinco<grossincomcat67
recode grossincomcat .=3 if annualreturninformationgrossinco>=grossincomcat67

drop grossincomcat33
drop grossincomcat67

*Wide
keep grossincomcat charitynumbernum yearaccount
reshape wide grossincomcat, i(charitynumbernum) j(yearaccount)

chronogram grossincomcat2007-grossincomcat2015

*Blue is low income, green is high. Over preiod low decreases and high increases. Red buldges in the middle. If you are in low, chances are of moving to med or high (about the same chances) and these increase over time
*If you are in med your chances are high over moving to low at the start but as time goes on you tend to move to high. If you are in high your chances of moving to med are pretty flat, and chances of low decreases over time.  

*Slows down running
trprgr grossincomcat*

*Long
reshape long
sqset grossincomcat charitynumbernum yearaccount

sqindexplot, overplot (200)

*All equal as was cut up equally
xttab grossincomcat
*trans
xttrans grossincomcat

}


*

*Gross expenditure
********************
{
use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

sum annualreturninformationgrossexpe, detail

keep if annualreturninformationgrossexpe ~=.

capture drop pid
egen pid = group(charitynumbernum)

foreach val in 33 67 {
	capture drop grossexpcat`val'
	egen grossexpcat`val'=pctile(annualreturninformationgrossexpe), p(`val') by(charitynumbernum)
}
*
capture drop grossexpcat
gen grossexpcat =.

recode grossexpcat .=1 if annualreturninformationgrossexpe<=grossexpcat33
recode grossexpcat .=2 if annualreturninformationgrossexpe<grossexpcat67
recode grossexpcat .=3 if annualreturninformationgrossexpe>=grossexpcat67

drop grossexpcat33
drop grossexpcat67

tab grossexpcat

tab year grossexpcat, col

*Wide
keep grossexpcat charitynumbernum yearaccount
reshape wide grossexpcat, i(charitynumbernum) j(yearaccount)

*sequence analysis to detect drops in income, staff ect
cap drop seqstr

stripe grossexpcat2007-grossexpcat2015, gen(seqstr) symb("lMH")

count if regexm(seqstr,"H+M+l+") | regexm(seqstr,"H+l+")

*Coding drop - ^ means begining with, $ means ends with, * means and
capture drop dropexp
gen dropexp=0
recode dropexp 0=1 if regexm(seqstr,"H+M+l+")
recode dropexp 0=1 if regexm(seqstr,"H+l+")

tab dropexp

*Spells
capture drop nspexp
nspells grossexpcat* , gen(nspexp)

tab nspexp

*Remerge with main data
reshape long

*sav
keep dropexp nspexp yearaccount charitynumbernum 

sav "$path9/dropexp.dta" , replace

*Graphing and balancing
use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

sum annualreturninformationgrossexpe, detail

keep if annualreturninformationgrossexpe ~=.

capture drop allyears
bys charitynumbernum:gen allyears=[_N]
tab allyears

keep if allyears==9

xtset charitynumbernum yearaccount
xtdes

capture drop pid
egen pid = group(charitynumbernum)

foreach val in 33 67 {
	capture drop grossexpcat`val'
	egen grossexpcat`val'=pctile(annualreturninformationgrossexpe), p(`val') by(charitynumbernum)
}
*
capture drop grossexpcat
gen grossexpcat =.

recode grossexpcat .=1 if annualreturninformationgrossexpe<=grossexpcat33
recode grossexpcat .=2 if annualreturninformationgrossexpe<grossexpcat67
recode grossexpcat .=3 if annualreturninformationgrossexpe>=grossexpcat67

drop grossexpcat33
drop grossexpcat67

*Wide
keep grossexpcat charitynumbernum yearaccount
reshape wide grossexpcat, i(charitynumbernum) j(yearaccount)

chronogram grossexpcat2007-grossexpcat2015

*Blue is low income, green is high. Over preiod low decreases and high increases. Red buldges in the middle. If you are in low, chances are of moving to med or high (about the same chances) and these increase over time
*If you are in med your chances are high over moving to low at the start but as time goes on you tend to move to high. If you are in high your chances of moving to med are pretty flat, and chances of low decreases over time.  

*Slows down running
trprgr grossexpcat*

*Long
reshape long
sqset grossexpcat charitynumbernum yearaccount

sqindexplot, overplot (200)

*All equal as was cut up equally
xttab grossexpcat
*trans
xttrans grossexpcat
}
*

*Staff
********************
{
use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

sum annualreturninformationtotalnumb, detail

keep if annualreturninformationtotalnumb ~=.
keep if annualreturninformationtotalnumb ~=0

capture drop pid
egen pid = group(charitynumbernum)

foreach val in 33 67 {
	capture drop staffnocat`val'
	egen staffnocat`val'=pctile(annualreturninformationtotalnumb), p(`val') by(charitynumbernum)
}
*
capture drop staffnocat
gen staffnocat =.

recode staffnocat .=1 if annualreturninformationtotalnumb<=staffnocat33
recode staffnocat .=2 if annualreturninformationtotalnumb<staffnocat67
recode staffnocat .=3 if annualreturninformationtotalnumb>=staffnocat67

drop staffnocat33
drop staffnocat67

tab staffnocat

tab year staffnocat, col

*Wide
keep staffnocat charitynumbernum yearaccount
reshape wide staffnocat, i(charitynumbernum) j(yearaccount)

*sequence analysis to detect drops in income, staff ect
cap drop seqstr

stripe staffnocat2007-staffnocat2015, gen(seqstr) symb("lMH")

count if regexm(seqstr,"H+M+l+") | regexm(seqstr,"H+l+")

*Coding drop - ^ means begining with, $ means ends with, * means and
capture drop dropstaff
gen dropstaff=0
recode dropstaff 0=1 if regexm(seqstr,"H+M+l+")
recode dropstaff 0=1 if regexm(seqstr,"H+l+")

tab dropstaff

*Spells
capture drop nspstaff
nspells staffnocat* , gen(nspstaff)

tab nspstaff

*Remerge with main data
reshape long

*sav
keep dropstaff nspstaff yearaccount charitynumbernum 

sav "$path9/dropstaff.dta" , replace

*Graphing and balancing
use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

sum annualreturninformationtotalnumb, detail

keep if annualreturninformationtotalnumb ~=.
keep if annualreturninformationtotalnumb ~=0

capture drop allyears
bys charitynumbernum:gen allyears=[_N]
tab allyears

keep if allyears==9

xtset charitynumbernum yearaccount
xtdes

capture drop pid
egen pid = group(charitynumbernum)

foreach val in 33 67 {
	capture drop staffnocat`val'
	egen staffnocat`val'=pctile(annualreturninformationtotalnumb), p(`val') by(charitynumbernum)
}
*
capture drop staffnocat
gen staffnocat =.

recode staffnocat .=1 if annualreturninformationtotalnumb<=staffnocat33
recode staffnocat .=2 if annualreturninformationtotalnumb<staffnocat67
recode staffnocat .=3 if annualreturninformationtotalnumb>=staffnocat67

drop staffnocat33
drop staffnocat67

*Wide
keep staffnocat charitynumbernum yearaccount
reshape wide staffnocat, i(charitynumbernum) j(yearaccount)

chronogram staffnocat2007-staffnocat2015

*Blue is low income, green is high. Over preiod low decreases and high increases. Red buldges in the middle. If you are in low, chances are of moving to med or high (about the same chances) and these increase over time
*If you are in med your chances are high over moving to low at the start but as time goes on you tend to move to high. If you are in high your chances of moving to med are pretty flat, and chances of low decreases over time.  

*Slows down running
trprgr staffnocat*

*Long
reshape long
sqset staffnocat charitynumbernum yearaccount

sqindexplot, overplot (200)

*All equal as was cut up equally
xttab staffnocat
*trans
xttrans staffnocat
}


*









