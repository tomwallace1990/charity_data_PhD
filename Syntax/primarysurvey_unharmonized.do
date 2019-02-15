global path1 ""
global path11 ""

***

*Question 1
{
use $path1/primarysurvey_unharmonized.dta, clear

*Level of data use

sum SS_overallweakstrong, detail
tab SS_overallweakstrong
histogram SS_overallweakstrong, freq xlabel(1.5 "1" 2.5 "2" 3.5 "3" 4.5 "4" 5.5 ///
"5" 6.5 "6" 7.5 "7" 8.5 "8" 9.5 "9" 10.5 "10") width(0.99) color(ebblue) lcolor(white) ///
 xtitle("Please indicate your organisation's overall ability to utilize data") graphregion(color(white))
graph export $path11\Analysis\Graphs\primarydatausehisto.tif , width(1200)  height(1000) replace

*Set
list SS_WhichofthefollowingdatasE

foreach val in CJ CO CT CY DD DI EH EM DN {
 list SS_`val'	
 }
*

*UK census 6
*Annual population survey 9
*Charity register 12
*Scottish household survey 13
*Scottish health survey 4
*Scottish social attitude survey 3
*Labour force survey 2
*BHPS 2



*Source
list SS_WhichofthefollowingdatasoE

foreach val in CK CP CU CZ DE DJ EN DO {
 list SS_`val'
 }

*

*National records scotland 1
*Home office 1
*Scot gov 11
*Local authority 13
*Social enterprise scotland 8
*OSCR 8
*SCVO evidence library 7
*TSRC 2
*Volunteer scotland 8
*Data archive 4
*NCVO 3
}
*

***

*Question 4
{
use $path1/primarysurvey_unharmonized.dta, clear

drop if TWtwittername==""
drop if TWtwittername==""

*How important are the following factors to you regarding making use of the data sets and sources you previously selected? Trust

*Trust univariate
tab SS_trust
sum SS_trust, detail
histogram SS_trust, freq xlabel(1 "1" 2 "2" 3 "3" 4 "4") discrete color(ebblue) lcolor(white) ///
 xtitle("How important are the following factors to you regarding making use of the data sets and sources you previously selected? Trust" , size(vsmall))


*Data use
tab SS_overallweakstrong

*Bivariate - insig in tab but looks strong, bad in regress, almost sig in olog with decent R2 - can't measure much more so this suggests an issue for interviews
tab SS_overallweakstrong SS_trust, col chi2 gamma

olog SS_trust SS_overallweakstrong

}
*
