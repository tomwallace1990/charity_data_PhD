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

**************************
*Introduction

*	This Dofile contains the analysis which comprises chapter 1 of my thesis. This analysis is based on ///
*	"TWAROSCRmergedCleanedNOtom.dta" which is a cleaned merge between my survey, Rutherford & Burt's survey and ///
*	OSCR annual returns data. This data has Tom Wallace's survey removed. The analysis seeks to answer the questions below. The analysis will be /// 
*	structured around answering the analytical questions. 

**************************
*Questions to be answered
**************************

*Research questions
*	1.	What external data usage is there in the Scottish third sector 
*	2.	What barriers and enablers are there to making more use of external data
*	3.	How does trust in external data, or its providers, affect its usage
*NA	4.	What does the network of support (for using external data) look like? 
*	5.	How does the support network affect external data usage among third sector organisations


*Analytical questions
*	1.	What level of external data usage is there among the third sector in Scotland and what external data sets are being used by the sector?
*	2.	Which organisational features best predict differences in levels of use?
*	3.	What other factors enable or inhibit external data usage in the Scottish third sector?
*	4.	How does trust in data sets and data providers affect usage?
*NA	5.	Which organisations comprise the infrastructure and support network for the Scottish third sector data use and how well are they linked to respondent organisations?
*	6.	How does network centrality, among other network metrics and networking variables, relate to external data usage?
*NA	7.	What sort of contact is the network actually built on and to what extent does it act as a predictor for non-public networking?



clear

**************************
*Analytical quesiton 1 - External usage
**************************
{
*	What level of external data usage is there among the third sector in Scotland and what external data sets are being used by the sector?

use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

drop if fromtomsurvey==1

*	What level of use is there?
tab zUsedat9
recode zUsedat9 5=0
tab zUsedat9
histogram zUsedat9 if fromtomsurvey==0, freq xlabel(0 "0" 1 "1" 2 "2" 3 "3" 4 "4") discrete color(ebblue) lcolor(white) graphregion(color(white)) xtitle("What data sources are most useful to your charity: external data")
graph export $path11\Analysis\Graphs\useexternaldataAR.tif , width(1200)  height(1000) replace

sum zUsedat9, detail


*This variable is a harmonized combonation of 'What data sources are most useful to your charity?' 4 cat and NA [AR] and ///
*'Please indicate your organisation's overall ability to utilize the data you previously selected' 10 cat scale [TW]. The ///
*harmonisation can be undone in analysis with the variable 'fromtomsurvey' and it will only be at full strength with other harmonized variables.
*As the table and histogram show, this variable is relativly normally distrubuted with a negative skew. Category 0 is an expeption to this ///
*But it is debatalbe wither it should be included or not and this will vary in the analysis. 
*For answering question 1, more than half of the sample find external data moderatly or extremly usful. And 70% indicate that they use it in ///
*Some capacity. Considering this refers to external data only this means there is relativly good use of this data in the Scottish third sector.

use $path11/TWAROSCRmergedCleaned.dta, clear
*How often use data - reload main data
tab SS_aHowoftentoyouuseextern
*This question was only asked in the primary survey and so has only 19 responses. Almost 2/3 of those responses, however, claim to be ///
*continuously using external data. This is a surprisingly strong result when there is hypothesised to be a lack of skills in the sector /// 
*but selectin effects for who answered the survey may be in pay - especially since category 1 was not even selected.


*	Skills
*My survey
tab SS_whatyouwant 
tab SS_readingoutput 
tab SS_creatingtabs 
tab SS_sharing
tab SS_publishing 
tab SS_linking
*Skills are a key indicator of and tool for explaining useage.
*This first set of skills are from the primary survey only. Case number are therefore low (19). The results were similar for all variables ///
*however, with the majority of respondents claiming to have strong skills concenring 'knowing what you want' 'redeading output' 'creating ///
* tabs' 'sharing' and 'publishing'. The exeption to this was 'linking' where the weight of responses was on moderate.
*This is a surprisingly strong result as above and it may be due t selection bias for survey respondents.

drop if fromtomsurvey==1
*Rutherford & Burt survey

*These two varialbes also concern skills and were from AR survey but were not able to harmonised with the primary survey.
*As with previous results these are normally distrubuted with a negative skew. The majority of responses for each, 60-70% ///
*lay in 'just about' or 'easy'

*
recode zEasDif1 -99/-9=0
recode zEasDif4 -99/-9=0
recode zEasDif2 -99/-9=0
recode zEasDif3 -99/-9=0
recode zEasDif5 -99/-9=0

tab zEasDif1 
tab zEasDif2
tab zEasDif3
tab zEasDif4
tab zEasDif5

*These 4 skill related questions were harmonized from similiar questions between the sruveys. Follow same patterns as above. 'zbarrs7' is a bit ///
*diferent mins split between skills being a 'minor' and 'considerable' barrier. These are the middle categories of the varaible as usual ///
*But they are more split than the usual 'moderate' 'strong'

*Possibly create an index of skills - add more to it, just has my survey atm
capture drop skillindex
gen skillindex=zEasDif1+zEasDif2+zEasDif3+zEasDif4+zEasDif5
tab skillindex
histogram skillindex , discrete
*This looks like all the others, normal with negative skew

*	Which data sets are being used?
*See "E:\Stats\1Thesis\OSCRdata\Analysis\primarysurvey_unharmonized.do"


*UK census 6
*Annual population survey 9
*Charity register 12
*Scottish household survey 13
*Scottish health survey 4
*Scottish social attitude survey 3
*Labour force survey 2
*BHPS 2

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

*Testing the depenent

use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

drop if fromtomsurvey==1

*
tab zUsedat9
recode zUsedat9 5=0
tab zUsedat9

*create alternative coding
capture drop zUsedat9ALT
gen zUsedat9ALT=zUsedat9
recode zUsedat9ALT 1=0
tab zUsedat9ALT

*r2 is 0.96 which suggests only a very minor diference in varaition - reg used opposed to logit due to collinear nonconvergence
reg zUsedat9ALT zUsedat9

*very similar
tab zDataStrat zUsedat9, chi2 gamma
tab zDataStrat zUsedat9ALT, chi2 gamma

forval val=0/4 {
gen datcat`val'=zUsedat9==`val'
}
*
keep if yearacc==2014

*0 and 1 load diferently
factor datcat* , factors(4)
screeplot 
rotate, clear
rotate, promax blanks(0.4)

*1 doesn't load on 3 factors
factor datcat* , factors(3)
rotate, clear
rotate, promax blanks(0.4)

*Same on 2
factor datcat* , factors(2)
rotate, clear
rotate, promax blanks(0.4)



}
*

**************************
*Analytical quesiton 2 - Organisational features
**************************
{
use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

*	Dependent variable
recode zUsedat9 5=0
tab zUsedat9

gen zUsedat9bin=zUsedat9
recode zUsedat9bin 0=0 1/4=1

********************
*Bivariate exploration and analysis
********************

*	Organisational charicteristics
********************

*Data managment strategy
tab zDataStrat
*This is a simple yes/no. 66% of respondents said yes to having a data managmnet strategy.
tab zUsedat9 zDataStrat, gamma chi2 col
*gamma=-0.2263 Pr=0.119
tab zUsedat9 zDataStrat if zUsedat9~=0, gamma chi2 col
*gamma=-0.2557 chi2=0.084
*Excluding 0 (which focuses on variation within those who use data and not wither they use it or not) is more significant with a slightly ///
*larger gamma
tab zUsedat9bin zDataStrat, gamma chi2 col
*insig, so the strategy doesnt affect if you use or not but the scope of use
*There seems to be a pattern, with orgs which have a data managment strat being more likely to use external data more (if statment sig so variation is what mattters)

*How long had strategy
recode zSratLen -99/-9=.
recode zSratLen .=0 if yearacc==2014
tab zSratLen
histogram zSratLen
*Yhis shows how long those with a strategy have had it for. It is acending with 55% having one for more than 5 years
tab zUsedat9 zSratLen, gamma chi2 col
*gamma=0.0773 Pr= 0.909
*This does not appear to be related to using external data - or at least there is no evidence for a relationship
tab zUsedat9bin zSratLen, gamma chi2 col
tab zUsedat9 zSratLen if zUsedat9~=0, gamma chi2 col
*Running the bin and ~=0 tabs were also insig

*Structure
recode zStructure -9 4=.
tab zStructure 
tab zUsedat9 zStructure, gamma chi2 col
*gamma=-0.1 Pr=0.495
tab zUsedat9bin zStructure, gamma chi2 col
tab zUsedat9 zStructure if zUsedat9~=0, gamma chi2 col
*This variable, unsurprisingly returns no significant assosiation - it is a very unbalanced variable with 87% of orgs 'centralised'
*

*Primary area of activity
recode zPrimAct -99/-9=.
tab zPrimAct 
tab zUsedat9 zPrimAct, gamma chi2 col
*gamma=0.2 Pr=0.335
tab zUsedat9bin zPrimAct, gamma chi2 col
tab zUsedat9 zPrimAct if zUsedat9~=0, gamma chi2 col
*This varible records what areas of society an org serves, it is very mixed and returns no results 

*User profile
recode zUserprof -99/-9=.
tab zUserprof 
tab zUsedat9 zUserprof, gamma chi2 col
*gamma=-0.02 Pr=0.425
tab zUsedat9bin zUserprof, gamma chi2 col
tab zUsedat9 zUserprof if zUsedat9~=0, gamma chi2 col
*Records who the charity serves in low detail

*How long had website
recode zWebslen -99/-9=.
tab zWebslen 
tab zUsedat9 zWebslen, gamma chi2 col
*gamma=0.0796 Pr=0.021
*This is significantly assosiated with data use, but with a low gamma
tab zUsedat9 zWebslen if zUsedat9~=0, gamma chi2 col
*gamma=0.0999 Pr=0.003
*Variation within is even more signifcant
tab zUsedat9bin zWebslen , gamma chi2 col
*bin is totally insig 

*Age
list RegisteredDateNum in 1/100
*RegisteredDateNum is the number of days since 1/1/1900+1 inclusive
capture drop age
gen age=114-(RegisteredDateNum/365)

ologit zUsedat9 age
*Pr=0.0794 R2=0.0066
ologit zUsedat9 age if zUsedat9~=0
logit zUsedat9bin age
*Pr=0.0720 R2=0.0210
*Bigger number means younger, positive means younger charities using more data
ologit zUsedat9 age ib2.zWebslen
ologit zUsedat9 age ib2.zWebslen if zUsedat9~=0
logit zUsedat9 age ib2.zWebslen

*Plan to personalise web services?
recode zPersonal -99/-9 4=.
tab zPersonal
tab zUsedat9 zPersonal, gamma chi2 col
*gamma=-0.1488 Pr=0.547
tab zUsedat9bin zPersonal, gamma chi2 col
tab zUsedat9 zPersonal if zUsedat9~=0, gamma chi2 col

*Archetype
recode zType -99/-9=.
tab zType
tab zUsedat9 zType , gamma chi2 col 
*gamma=0.1149 Pr=0.154
tab zUsedat9 zType if zUsedat9~=0, gamma chi2 col
tab zUsedat9bin zType , gamma chi2 col
*Should be assosiated and isnt - orgs being forced to use data even though they arn't good at it?

*Constitutonal form
tab zCurrentConstitutionalForm 
tab currentconstitutionalform if yearacc==2014
tab zUsedat9 currentconstitutionalform, gamma chi2 col 
*gamma=-0.0217 Pr=0.032
tab zUsedat9 currentconstitutionalform if zUsedat9~=0, gamma chi2 col
*gamma=-0.1051 Pr=0.025
*Both near significant but with very small gammas.
tab zUsedat9bin currentconstitutionalform, gamma chi2 col
*gamma=0.1 Pr=0.559
*Form predicts within variance

*no of staff
list annualreturninformationtotalnumb in 1/50
ologit zUsedat9 annualreturninformationtotalnumb
ologit zUsedat9 annualreturninformationtotalnumb if zUsedat9~=0
logit zUsedat9bin annualreturninformationtotalnumb

regress annualreturninformationtotalnumb ib3.zUsedat9
*Prob>F=0.1883
regress annualreturninformationtotalnumb ib3.zUsedat9 if zUsedat9~=0
*prob>F=0.0688
regress annualreturninformationtotalnumb zUsedat9bin
*prob>F=0.3022
*Staff numbers affect within variation

*no of trustees
sum numberofcharitytrustees
regress numberofcharitytrustees ib3.zUsedat9
*P=0.6350
*Not related 
ologit zUsedat9 numberofcharitytrustees
ologit zUsedat9 numberofcharitytrustees  if zUsedat9~=0
logit zUsedat9bin  numberofcharitytrustees

*Spread
tab geographicalspread 
recode geographicalspread 2=1 3=2 4=3 1=4 6=5 7=6 5=7 8=8

tab zUsedat9 geographicalspread, gamma chi2 col 
*gamma=-0.0327 Pr=0.266
tab zUsedat9 geographicalspread if zUsedat9~=0, gamma chi2 col 
*gamma=-0.0103 Pr=0.6
tab zUsedat9bin geographicalspread, gamma chi2 col
*gamma=-0.0907 Pr=0.015
*Spread significant in determining wither used or not, but not in socpe of use



*	Benifactor group
********************

*Children/young people
tab zBenGroup1
recode zBenGroup1 .=0 if yearacc==2014
tab zUsedat9 zBenGroup1, gamma chi2 col
*gamma=-0.0513 Pr=0.274
tab zUsedat9 zBenGroup1 if zUsedat9~=0, gamma chi2 col
tab zUsedat9bin zBenGroup1, gamma chi2 col

*No specific group
tab zBenGroup2
recode zBenGroup2 .=0 if yearacc==2014
tab zUsedat9 zBenGroup2, gamma chi2 col
*gamm=0.2388 Pr=0.018
tab zUsedat9 zBenGroup2 if zUsedat9~=0, gamma chi2 col
*gamma=0.2326 Pr=0.015
tab zUsedat9bin zBenGroup2, gamma chi2 col
*gamma=0.2475 pr=0.209
*Scope but not use BUT not native so seems to have reverse effect to most

*Older people
tab zBenGroup3 
recode zBenGroup3 .=0 if yearacc==2014
tab zUsedat9 zBenGroup3, gamma chi2 col
*gamma=0.3080 Pr=0.066
tab zUsedat9 zBenGroup3 if zUsedat9~=0, gamma chi2 col
*gamma=0.2829 Pr=0.091
tab zUsedat9bin zBenGroup3, gamma chi2 col
*Pr=0.162
*Scope but not use ALSO positive direction

*Other charities
tab zBenGroup4
recode zBenGroup4 .=0 if yearacc==2014
tab zUsedat9 zBenGroup4, gamma chi2 col
*gamma=0.161 Pr=0.823 - unexpecidly insig - very low case numbers however and may not have enough support orgs in this data
tab zUsedat9 zBenGroup4 if zUsedat9~=0, gamma chi2 col
tab zUsedat9bin zBenGroup4, gamma chi2 col

*Other defined group
tab zBenGroup5
recode zBenGroup5 .=0 if yearacc==2014
tab zUsedat9 zBenGroup5, gamma chi2 col
*gamma=-0.08 Pr=0.247
tab zUsedat9 zBenGroup5 if zUsedat9~=0, gamma chi2 col
tab zUsedat9bin zBenGroup5, gamma chi2 col

*Ethnic/racial
tab zBenGroup6
recode zBenGroup6 .=0 if yearacc==2014
tab zUsedat9 zBenGroup6, gamma chi2 col
*gamma=0.3508 Pr=0.124
tab zUsedat9 zBenGroup6 if zUsedat9~=0, gamma chi2 col
tab zUsedat9bin zBenGroup6, gamma chi2 col

*Disabilities
tab zBenGroup7
recode zBenGroup7 .=0 if yearacc==2014
tab zUsedat9 zBenGroup7, gamma chi2 col
*gamma=-0.0798 Pr=0.565
tab zUsedat9 zBenGroup7 if zUsedat9~=0, gamma chi2 col
tab zUsedat9bin zBenGroup7, gamma chi2 col

*	Financials
********************

*Gross income figure
list annualreturninformationgrossinco in 1/50
/*regress annualreturninformationgrossinco ib3.zUsedat9
*Pr>F=0.1828 R2=0.04
regress annualreturninformationgrossinco ib3.zUsedat9 if zUsedat9~=0
*Pr>F=0.1139 r2=0.0486
regress annualreturninformationgrossinco zUsedat9bin
*/
ologit zUsedat9 annualreturninformationgrossinco
ologit zUsedat9 annualreturninformationgrossinco if zUsedat9~=0
*Pr=0.0336
logit zUsedat9 annualreturninformationgrossinco
*Same this way around but with better significance

*Gross expenditure figure
list annualreturninformationgrossexpe in 1/50
/*
regress annualreturninformationgrossexpe ib3.zUsedat9
*Prob>F=0.0761
regress annualreturninformationgrossexpe zUsedat9bin
*Pr=0.9627
regress annualreturninformationgrossexpe ib3.zUsedat9 if zUsedat9~=0
*Pr=0.0488
*same as income
*/
ologit zUsedat9 annualreturninformationgrossexpe
ologit zUsedat9 annualreturninformationgrossexpe if zUsedat9~=0
*Pr=0.0121
logit zUsedat9 annualreturninformationgrossexpe
*better sig than regress

*Donations
list incometotaldonations in 1/50
olog zUsedat9 incometotaldonations
logit zUsedat9bin incometotaldonations
olog zUsedat9 incometotaldonations if zUsedat9~=0
*
*Intrest
list incomeinterest in 1/50
olog zUsedat9 incomeinterest
logit zUsedat9bin incomeinterest
olog zUsedat9 incomeinterest if zUsedat9~=0
*

*Gov
list incomegov in 1/50
olog zUsedat9 incomegov
logit zUsedat9bin incomegov
olog zUsedat9 incomegov if zUsedat9~=0
*

*Trading
list incometrading in 1/50
olog zUsedat9 incometrading
logit zUsedat9bin incometrading
*Pr=0.0853 R2=0.023
olog zUsedat9 incometrading if zUsedat9~=0
*

*Income from charitable activity
list incomecharitableactivity in 1/50
/*regress incomecharitableactivity ib3.zUsedat9
*Prob>F=0.1694
regress incomecharitableactivity ib3.zUsedat9  if zUsedat9~=0
regress incomecharitableactivity zUsedat9bin
*0.029
*/
ologit zUsedat9 incomecharitableactivity
*Pr=0.0988
ologit zUsedat9 incomecharitableactivity if zUsedat9~=0
*Pr=0.8556
logit zUsedat9bin incomecharitableactivity
*Pr=0.0472
*This one predicts using data rather than scope

*Total income listed in accounts this is EXACTLYT the same as gross income - so kick
drop incometotal

*Net assets - not sure what negative means
list netassets in 1/50
olog zUsedat9 netassets
logit zUsedat9bin netassets
olog zUsedat9 netassets if zUsedat9~=0

*Total funds - not sure what this is
list totalfunds in 1/50
olog zUsedat9 totalfunds
logit zUsedat9bin totalfunds
olog zUsedat9 totalfunds if zUsedat9~=0

********************
*Proportional Normalisation of funding variables
********************

*Prep work
********************

*Checking that the individual incomes equal the gross income - they are not prefect in some cases
capture drop totalcheck
gen totalcheck=(incometotaldonations+incomeinterest+incomegov+incometrading+incomecharitableactivity)/annualreturninformationgrossinco
drop totalcheck

*Generate perfect total for analysis
capture drop perfecttotalincome
gen perfecttotalincome=(incometotaldonations+incomeinterest+incomegov+incometrading+incomecharitableactivity)

*Donations
capture drop prop_incometotaldonations
gen prop_incometotaldonations=incometotaldonations/perfecttotalincome

*Intrest
capture drop prop_incomeinterest
gen prop_incomeinterest=incomeinterest/perfecttotalincome

*Gov
capture drop prop_incomegov
gen prop_incomegov=incomegov/perfecttotalincome

*Trading
capture drop prop_incometrading
gen prop_incometrading=incometrading/perfecttotalincome

*Charitable activity
capture drop prop_incomecharitableactivity
gen prop_incomecharitableactivity=incomecharitableactivity/perfecttotalincome

*Total checking - perfect besides very small rounding errors
capture drop totalcheck1
gen totalcheck1=(prop_incometotaldonations+prop_incomeinterest+prop_incomegov+prop_incometrading+prop_incomecharitableactivity)
drop totalcheck1

*Analysis
********************
*Highly variable - gov and charitable acitivty the largest, then donations, then traiding, then intrest
sum prop_*

*Same story if only look at 2014
sum prop_* if yearaccounts==2014

*Analysis continued in regression models


********************
*Factor analysis
********************

*	Characteristis
********************

*Not suitbale for factor analysis (due to coding of variables, no suspected colinearity anyway)

*	Benafactor groups
********************
tab1 zBenGroup*

polychoric zBenGroup*
di r(sum_w)
global N=r(sum_w)
matrix r=r(R)
factormat r, n($N) blanks(0.3) factors(1) forcepsd 

*used to decide how many factors to use - 1
screeplot

*rotations 
rotate, clear
rotate, promax blanks(0.4)
rotate, clear
*Old people/ethnic/health loading on 1, no specific group loading on 2 with children loading negativly, other charities loads on 3, other defined groups on 4

*Plot loadings (variables)
*loadingplot, factors(1)
*plot cases (rows of data)
*scoreplot, mlabel(TWtwittername)

*gets the factors into data as variables

capture drop fben1 
predict fben1

*used to justify using factor analysis - usually above 0.5 is justified
factor zBenGroup*
estat kmo

*Conclusion 
*KMO is just over threashold but interpretation is dificult, seems to be a health factor (with ethnic), a 'general', an other charities, and 'other'
*Worth trying in regressions, no obvioius collinearity detected

***Mokken Scale
*forval val=1/7 {
*drop if zBenGroup`val'==.
*}

msp zBenGroup*

*Mokken and factor analysis agree but at diferent cut offs - mokken selects 3, 6, and 7 where as factor adds 1 (and debatebly 5)


/*	Financials - this is not appropriate data for factor analysis, use proportonal normalisation instead
********************
{
factor annualreturninformationgrossinco annualreturninformationgrossexpe prop*

*incometotal removed for perfect coliniearity

*used to decide how many factors to use - 4
screeplot

*rotations 
rotate, clear
rotate, varimax blanks(0.4)
rotate, promax blanks(0.4)
rotate, clear
*Intrest, training and total funds load on 1, donations loads on 2, gov loads on 3, charitable activity loads on 4, gorss income and expend load on both 3 and 4 equally
*Net assets loads on nothing and has a high uniquenss, training income also has a high uniquness, everything else is low

*Plot loadings (variables)
loadingplot, factors(2)
*plot cases (rows of data)
scoreplot, mlabel(TWtwittername)

*gets the factors into data as variables
capture drop f1 
capture drop f2 
capture drop f3
capture drop f1bar 
capture drop f2bar 
capture drop f3bar
predict f1 f2 f3
gen f1bar=f1
gen f2bar=f2
gen f3bar=f3

*used to justify using factor analysis - usually above 0.5 is justified
estat kmo

*Conclusion 
*Interpretation of factors unclear, with low KMO best to use origional variables and be aware of colinearity (esp between intrest, training and total funds, and gorss income and expenditure)
*For size use anual gorss income but then can't include gorss expenditure/gov/charityable activity
}
*/

********************
*Sequence analysis
********************
preserve

run $path11\Analysis\Suplamentary_dofiles\sequenceanalysis.do

restore

merge 1:1 charitynumbernum yearaccounts using $path9\dropinco.dta
capture drop _merge
merge 1:1 charitynumbernum yearaccounts using $path9\dropexp.dta
capture drop _merge
merge 1:1 charitynumbernum yearaccounts using $path9\dropstaff.dta
capture drop _merge

ologit zUsedat9 dropinco
ologit zUsedat9 nspinco
reg nspinco dropinco
ologit zUsedat9 dropinco nspinco

ologit zUsedat9 dropexp
ologit zUsedat9 nspexp
reg nspstaff dropexp
ologit zUsedat9 dropexp nspexp

ologit zUsedat9 dropstaff
ologit zUsedat9 nspstaff
reg nspstaff dropstaff
ologit zUsedat9 dropstaff nspstaff


********************
*Modelling
********************

*	Characteristics
********************

olog zUsedat9 ib2.zDataStrat ib2.zSratLen ib2.zStructure ib2.zPrimAct ib2.zUserprof ib2.zWebslen ib2.zPersonal ib2.zType ib1.currentconstitutionalform ///
 annualreturninformationtotalnumb numberofcharitytrustees ib2.geographicalspread age dropstaff
 est store mod1a
*Prob>chi2=0.0135 R2=0.1672

olog zUsedat9 ib2.zDataStrat ib2.zSratLen ib2.zStructure ib2.zPrimAct ib2.zUserprof ib2.zWebslen ib2.zPersonal ib2.zType ib2.currentconstitutionalform ///
 annualreturninformationtotalnumb numberofcharitytrustees ib2.geographicalspread age dropstaff if zUsedat9~=0
 est store mod1b
*Prob>chi2=0.014 R2=0.2394
 
logit zUsedat9bin ib2.zDataStrat ib2.zSratLen ib2.zStructure ib2.zPrimAct ib2.zWebslen ib2.zPersonal ib2.zType ib2.currentconstitutionalform ///
 annualreturninformationtotalnumb numberofcharitytrustees ib2.geographicalspread age 
 est store mod1c
 *Pr>chi2=0.0281 R2=0.4278
 *ib2.zUserprof AND dropstaff omitted for causing non-convergence
 
 
 
  *	Benfactor groups
  ********************
olog zUsedat9 zBenGroup*
*Pr=0.069 R2=0.0278
olog zUsedat9 zBenGroup* if zUsedat9~=0
*Pr=0.3964 r2=0.023
logit zUsedat9bin zBenGroup*
*Pr=0.2483 R2=0.0521

*Only main model sig suggesting benafactors groups have an effect on both binary and variation - but only one point estimate significant

olog zUsedat9 fben*
olog zUsedat9 fben* if zUsedat9~=0
logit zUsedat9bin fben*
*Factor models not usful and insig

*	Financial
********************

*Ologit
ologit zUsedat9 annualreturninformationgrossinco annualreturninformationgrossexpe
*near sig

*all insig
ologit zUsedat9 prop_incometotaldonations
ologit zUsedat9 prop_incomeinterest
ologit zUsedat9 prop_incomegov
ologit zUsedat9 prop_incometrading
ologit zUsedat9 prop_incomecharitableactivity


*Ologit intenral variation
ologit zUsedat9 annualreturninformationgrossinco annualreturninformationgrossexpe if zUsedat9~=0
*significant prob>Chi2=0.0336 P>|z|=0.041 R2=0.0142

*donations is near sig and negative, suggesting charities deriving larger proportions of income from donations find data less usful
ologit zUsedat9 prop_incometotaldonations if zUsedat9~=0
ologit zUsedat9 prop_incomeinterest if zUsedat9~=0
ologit zUsedat9 prop_incomegov if zUsedat9~=0
ologit zUsedat9 prop_incometrading if zUsedat9~=0
ologit zUsedat9 prop_incomecharitableactivity if zUsedat9~=0

*Logit
logit zUsedat9bin annualreturninformationgrossinco annualreturninformationgrossexpe
*insig

*all insig
logit zUsedat9bin prop_incometotaldonations
logit zUsedat9bin prop_incomeinterest
logit zUsedat9bin prop_incomegov
logit zUsedat9bin prop_incometrading
logit zUsedat9bin prop_incomecharitableactivity




*	Combined
********************

***DROP IN STAFF REMOVED
***STAFF RERMOVED FROM 2 AND LOGIT, CANT BE BOTHERED FOR 1

ologit zUsedat9 ib2.zDataStrat annualreturninformationgrossinco ib2.zSratLen ib2.zStructure ib2.zPrimAct ib2.zUserprof ib2.zWebslen ib2.zPersonal ib2.zType ib2.currentconstitutionalform ///
  numberofcharitytrustees ib2.geographicalspread zBenGroup* age
 est store mod2a
 
 ologit zUsedat9 ib2.zDataStrat annualreturninformationgrossinco ib2.zSratLen ib2.zStructure ib2.zPrimAct ib2.zUserprof ib2.zWebslen ib2.zPersonal ib2.zType ib2.currentconstitutionalform ///
  numberofcharitytrustees ib2.geographicalspread zBenGroup* age if zUsedat9~=0
 est store mod2b
 
 logit zUsedat9bin annualreturninformationgrossinco ib2.zSratLen ib2.zPrimAct ib2.zWebslen ib2.zPersonal ib2.zType ib2.currentconstitutionalform ///
  numberofcharitytrustees ib2.geographicalspread zBenGroup* age
 est store mod2c
 *zDatStrat zStructure excluded for causing nonconvergence
*all sig, where point estimates sig they are positive    

 est table mod1a mod2a,  stats(bic N ll_0 ll r2 r2_p) b(%8.4g) star
 est table mod1b mod2b,  stats(bic N ll_0 ll r2 r2_p) b(%8.4g) star
 est table mod1c mod2c,  stats(bic N ll_0 ll r2 r2_p) b(%8.4g) star
 
 est table mod2a mod2b mod2c,  stats(bic aic N ll_0 ll r2 r2_p) b(%8.4g) star
 
 
 *	Longitudinal
 *Cannot do panel regressions becasue the outcome does not vary - jusy fits an olog
    
}
*

**************************
*Analytical quesiton 3 - Other inhibitors and enablers
**************************
{
use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

********************
*Dependent variable
********************
recode zUsedat9 5=0
tab zUsedat9

drop if fromtomsurvey==1

capture drop zUsedat9bin
gen zUsedat9bin=zUsedat9
recode zUsedat9bin 0=0 1 2 3 4=1
tab zUsedat9bin

********************
*Bivariate exploration and analysis
********************

*	Barriers
********************

*Cost
recode zBarrs1 -99/-9 0 5=.
tab zBarrs1
tab zUsedat9 zBarrs1, col gamma chi2
*gamma=0.09 Pr=0.255
tab zUsedat9 zBarrs1 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs1, col gamma chi2

*Time
recode zBarrs2 -99/-9 5=.
tab zBarrs2
tab zUsedat9 zBarrs2, col gamma chi2
*gamma=-0.1991 Pr=0.671
tab zUsedat9 zBarrs2 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs2, col gamma chi2

*Integrating IT within charity
recode zBarrs3 -99/-9=.
tab zBarrs3
tab zUsedat9 zBarrs3, col gamma chi2
*gamma=0.0874 Pr=0.830
tab zUsedat9 zBarrs3 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs3, col gamma chi2

*Integrating IT with partner org
recode zBarrs4 -99/-9 5=.
tab zBarrs4 
tab zUsedat9 zBarrs4, col gamma chi2
*gamma=0.0967 Pr=0.479
tab zUsedat9 zBarrs4 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs4, col gamma chi2

*Agreeing information standards
recode zBarrs5 -99/-9=.
tab zBarrs5 
tab zUsedat9 zBarrs5, col gamma chi2
*gamma=0.1536 Pr=0.306
tab zUsedat9 zBarrs5 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs5, col gamma chi2

*Agreeing shared information standards
recode zBarrs6 -99/-9=.
tab zBarrs6
tab zUsedat9 zBarrs6, col gamma chi2
*gamma=0.2339 Pr=0.348
tab zUsedat9 zBarrs6 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs6, col gamma chi2

*Lack of analytical skills
recode zBarrs7 -99/-9=.
tab zBarrs7
tab zUsedat9 zBarrs7 , col gamma chi2
*gamma=-0.0559 Pr=0.591
tab zUsedat9 zBarrs7 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs7, col gamma chi2

*Data security concerns
recode zBarrs8 -99/-9=.
tab zBarrs8
tab zUsedat9 zBarrs8, col gamma chi2
*gamma=-0.0.202 Pr=0.008
tab zUsedat9bin zBarrs8  , row gamma chi2
*gamma=-0.3637 Pr=0.002 More sig and stronger gamma when limmited to detemrining use or no use
tab zUsedat9 zBarrs8 if zUsedat9~=0, col gamma chi2

*Data privicy concerns
recode zBarrs9 -99/-9=.
tab zBarrs9 
tab zUsedat9 zBarrs9, col gamma chi2
*gamma=-0.1108 Pr=0.044
tab zUsedat9bin zBarrs9, col gamma chi2
*gamma=-0.2719 Pr=0.007 More sig and stronger gamma when limmited to detemrining use or no use
tab zUsedat9 zBarrs9 if zUsedat9~=0, col gamma chi2

tab zBarrs8 zBarrs9, chi2 gamma

*Legal/regulatory contraints
recode zBarrs10 -99/-9=.
tab zBarrs10
tab zUsedat9 zBarrs10, col gamma chi2
*gamma=-0.0445 Pr=0.646
tab zUsedat9 zBarrs10 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs10, col gamma chi2

*Seeing innovation in data
recode zBarrs11 -99/-9=.
tab zBarrs11
tab zUsedat9 zBarrs11, col gamma chi2
*gamma=-0.0135 Pr=0.314
tab zUsedat9 zBarrs11  if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs11, col gamma chi2

*Seeing data informed performance
recode zBarrs12 -99/-9=.
tab zBarrs12 
tab zUsedat9 zBarrs12, col gamma chi2
*gamma=-0.0110 Pr=0.306
tab zUsedat9 zBarrs12  if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zBarrs12, col gamma chi2

*Ethical issues
recode zBarrs13 -99/-9=.
tab zBarrs13
tab zUsedat9 zBarrs13, col gamma chi2
*gamma=-0.0371 Pr=0.188
tab zUsedat9bin zBarrs13, col gamma chi2
*gamma=-0.2571 Pr=0.044 Makes sig and reverses relationship
tab zUsedat9 zBarrs13 if zUsedat9~=0, col gamma chi2


*	Enablers
********************

*Data can inform strategy
recode zEnab1 -99/-9=.
tab zEnab1
tab zUsedat9 zEnab1 , col gamma chi2
*gamma=-0.268 Pr=0.151
tab zUsedat9 zEnab1 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zEnab1 , col gamma chi2

*Reporting and accountabilty
recode zEnab2 -99/-9=.
tab zEnab2 
tab zUsedat9 zEnab2 , col gamma chi2
*gamma=-0.2749 Pr=0.012
tab zUsedat9 zEnab2 if zUsedat9~=0, col gamma chi2
*gamma=-0.37 Pr=0.002
tab zUsedat9bin zEnab2 , col gamma chi2

*Leadership
recode zEnab3 -99/-9=.
tab zEnab3
tab zUsedat9 zEnab3, col gamma chi2
*gamma=-0.2925 Pr=0.000
tab zUsedat9 zEnab3 if zUsedat9~=0, col gamma chi2
*gamma=-0.36 Pr=0.000
tab zUsedat9bin zEnab3 , col gamma chi2

*Better use of resources
recode zEnab4 -99/-9=.
tab zEnab4
tab zUsedat9 zEnab4 , col gamma chi2
*gamma=-0.1983 Pr=0.068
tab zUsedat9 zEnab4 if zUsedat9~=0, col gamma chi2
*gamma=-0.24 Pr=0.09 - less sig but stronger gamma
tab zUsedat9bin zEnab4, row gamma chi2
*gamma=-0.15 Pr=0.034 - more sig but smaller gamma

*Competative advantage
recode zEnab5 -99/-9 5=.
tab zEnab5
tab zUsedat9 zEnab5 , col gamma chi2
*gamma=-0.1252 Pr=0.105
tab zUsedat9 zEnab5 if zUsedat9~=0, col gamma chi2
tab zUsedat9bin zEnab5 , col gamma chi2

********************
*Factor analysis and collinearity
********************

*Suspect enablers 2 and 3 are colinear and barriers 8, 9 and maybe 13

*Privicy, security and ethics
tab1 zBarrs8 zBarrs9 zBarrs13
tab zBarrs8 zBarrs9, gamma chi2
tab zBarrs8 zBarrs13, gamma chi2
tab zBarrs9 zBarrs13, gamma chi2
*8 and 9 seem to be, 13 maybe not 

*Enalbers
tab1 zEnab2 zEnab3
tab zEnab2 zEnab3, row chi2 gamma
tab zEnab1 zEnab3, row chi2 gamma
*Enablers all seem assosiated to each other

*Factor analysis for barriers - 8, 9, 13
polychoric zBarrs*
di r(sum_w)
global N=r(sum_w)
matrix r=r(R)
factormat r, n($N) blanks(0.3) factors(3)

*used to decide how many factors to use - 3
screeplot

*rotations - the first one, seems to create an ethics/legal (bar 8,9,10,13) factor 1, a general 2 and a inovation/informed performance facootr 3
*Rotation 2 does the same but with the factors order swapped
rotate, clear
rotate, varimax blanks(0.4)
rotate, promax blanks(0.4)
rotate, clear

*Plot loadings (variables) on factor 1 and 2 - this seems to show the groups identified in the rotations above
loadingplot, factors(2)
*plot cases (rows of data) on factors 1 and 2 - minimual outlayers
scoreplot, mlabel(TWtwittername)

*gets the factors into data as variables -
capture drop f1 
capture drop f2 
capture drop f3
capture drop f1bar 
capture drop f2bar 
capture drop f3bar
predict f1 f2 f3
gen f1bar=f1
gen f2bar=f2
gen f3bar=f3

*used to justify using factor analysis - usually above 0.5 is justified - close to justified but the full reg model will still be better
estat kmo


polychoric zBarrs8 zBarrs9 zBarrs10 zBarrs13
di r(sum_w)
global N=r(sum_w)
matrix r=r(R)
factormat r, n($N) blanks(0.3) factors(1)

estat kmo


polychoric zBarrs11 zBarrs12
di r(sum_w)
global N=r(sum_w)
matrix r=r(R)
factormat r, n($N) blanks(0.3) factors(1)

estat kmo


*Conclusion - 3 main latent factors identified, one general with 1-7 with uniquness >0.3, 
*	one ethics/legal/security with 2 of 4 variables with uniquness >0.3 
*	one inovation/informed performance with both variables <0.3
*	This suggests that 8 and 9 are coliniear, 11 and 12 are coliniear and therefore models may benefit from only having 1 included
*	With a low KMO and high uniqnesses for most varaibles it is not sensible to model the factors over the normal variables


*	Leadership and reporting
tab1 zEnab2 zEnab3
tab zEnab2 zEnab3, gamma chi2

polychoric zEnab*
di r(sum_w)
global N=r(sum_w)
matrix r=r(R)
factormat r, n($N) blanks(0.3) factors(1)

*One big single factor
screeplot

*enab5 is a little diferent
rotate, clear
rotate, varimax blanks(0.4)
rotate, promax blanks(0.4)
rotate, clear

*enab5 is somewhat diferent
*loadingplot, factors(1)
*Not many outlayers
*scoreplot, mlabel(TWtwittername)

*Very justified
estat kmo

*load factors into data
capture drop f1 
capture drop f2 
capture drop f3
capture drop f1enab 
capture drop f2enab
predict f1 f2
gen f1enab=f1
gen f2enab=f2

*Conclusion - one the whole the enablers are one big factor with hight factor 1 correlations and low uniqunesses
*	Enabler 5 is slightly diferent and is split between 2 factors. With this degree of colinearity it may be sensible to model the factor as one
*	espcially with a KMO of 0.8

********************
*Modelling
********************

*Barriers
********************

*Ologit
ologit zUsedat9 ib3.zBarrs*
est store one
*Pr>chi2=0.0152 R2=0.1607 - in combination these barriers are more powerful than individual insig results would protray
*They have diferent point esitmate signs but also alot of insig
ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 ib3.zBarrs8 ///
 ib3.zBarrs10  ib3.zBarrs11 ib3.zBarrs13
 *less sig but still sig and with a lower r2 as a result of removing colliearity - removed 9 ands 12 which had low uniquness

*Indig
 ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 f2bar ib3.zBarrs11 ib3.zBarrs12
est store two
 
ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 ib3.zBarrs8 ib3.zBarrs9 ///
 ib3.zBarrs10  f3bar ib3.zBarrs13
 est store three
 *Factor model - sig with slightly lower r2
 
 ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 f2bar f3bar
 est store four
 
est table one two three four,  stats(bic aic N ll_0 ll r2 r2_p) b(%8.4g) star


*If statemnt
ologit zUsedat9 ib3.zBarrs*  if zUsedat9~=0
est store ifone

ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 ib3.zBarrs8 ///
 ib3.zBarrs10  ib3.zBarrs11 ib3.zBarrs13 if zUsedat9~=0
 
 ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 f2bar ib3.zBarrs11 ib3.zBarrs12 if zUsedat9~=0
est store iftwo
 
*ologit zUsedat9 zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 ib3.zBarrs8 ib3.zBarrs9 ///
 *ib3.zBarrs10  f3bar ib3.zBarrs13 if zUsedat9~=0


ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 f2bar f3bar if zUsedat9~=0
est store iffour

est table ifone iftwo iffour,  stats(bic aic N ll_0 ll r2 r2_p) b(%8.4g) star
 
*Logit
logit zUsedat9bin ib3.zBarrs*
est store binone
*Pr>chi2=0.0216 R2=0.5185 - This logit crushes the dependent into a binary reulting in a much higher R2 suggesting 50% of the variation ///
*in using data at all or not is in the 12 barriers in the model
logit zUsedat9bin f1bar f2bar f3bar
logit zUsedat9bin ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 f2bar f3bar
logit zUsedat9bin ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 ib3.zBarrs8 ///
 ib3.zBarrs10 f3bar ib3.zBarrs13

logit zUsedat9bin ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 ib3.zBarrs8 ///
 ib3.zBarrs10  ib3.zBarrs11 ib3.zBarrs13
 *The non-collinear model is worse here and shows lower r2 - but have only removed 9 and 12 which had the lowest
 *uniqunesses of the factors 2 and 3
 
  logit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 f2bar ib3.zBarrs11 ib3.zBarrs12 
 est store bintwo
 
logit zUsedat9 zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 ib3.zBarrs8 ib3.zBarrs9 ///
 ib3.zBarrs10  f3bar ib3.zBarrs13

logit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs3 ib3.zBarrs4 ib3.zBarrs5 ib3.zBarrs6 ib3.zBarrs7 f2bar f3bar
 est store binfour

 est table binone bintwo binfour,  stats(bic aic N ll_0 ll r2 r2_p) b(%8.4g) star
 
*Cost, time and skills
ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs7
ologit zUsedat9 ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs7 if zUsedat9~=0
logit zUsedat9bin ib3.zBarrs1 ib3.zBarrs2 ib3.zBarrs7

*Enablers
********************

*Ologit
ologit zUsedat9 ib3.zEnab*
est store genone
*Pr>chi2=0.0874 R2=0.0425 - borderline, low r2
ologit zUsedat9 f1enab f2enab
ologit zUsedat9 f1enab
est store gentwo
*Both factor models are better - the sinlge one is the most sig and the full has highest r2. R2 both lower than origional
*model due to collinearity being removed


ologit zUsedat9 ib3.zEnab* if zUsedat9~=0
est store ifone
*Pr>chi2=0.0009 r2=0.1099 - highly sig, double the r2
ologit zUsedat9 f1enab if zUsedat9~=0
est store iftwo
*More sig, lower r2 - direction of factors is opposed?

ologit zUsedat9 f1enab f2enab if zUsedat9~=0

*logit
logit zUsedat9bin ib3.zEnab*
est store binone
*Prob>chi2=0.4728 r2=0.0734 - insig
logit zUsedat9bin f1enab 
est store bintwo

 est table genone gentwo ifone iftwo binone bintwo,  stats(bic aic N ll_0 ll r2 r2_p) b(%8.4g) star
 

*With the barrier logits sig and the enabler logits insig it may sugget that barriers determine wither data is used at all where ///
*as enablers are more powerful for explaining variations within data use - this would also explain why the logit excluding zUsedat9 ///
*category 0 is much more poweful.

*Combined
********************

* Barriers and enablers
ologit zUsedat9 ib3.zEnab* ib3.zBarrs*
ologit zUsedat9 f1enab f2enab ib3.zBarrs*
*full normal model works best
*Pr>chi2=0.0026 R2=0.2247

*enabler 3 breaks it
ologit zUsedat9 ib3.zEnab1 ib3.zEnab2 ib3.zEnab4 ib3.zEnab5 ib3.zBarrs* if zUsedat9~=0
ologit zUsedat9 f1enab f2enab ib3.zBarrs* if zUsedat9~=0
*enalber 2-4 break it - think its due to non response
logit zUsedat9bin f1enab f2enab ib3.zBarrs*

logit zUsedat9 ib3.zEnab1 ib3.zEnab5 ib3.zBarrs*

*Selection models
********************

tab zUsedat9
gen zUsedat9if=zUsedat9
recode zUsedat9if 0=.

keep if yearaccounts==2014

probit zUsedat9 ib1.zEnab1 ib1.zEnab5

heckoprobit zUsedat9if f1enab f2enab, select(zUsedat9bin=ib3.zBarrs1 ib3.zBarrs3)

*Mokken scale procedure
msp zBarrs*

capture drop bar1
gen bar1=(zBarrs1 + zBarrs2 + zBarrs3 + zBarrs4 + zBarrs5 + zBarrs6 + zBarrs7)/7
capture drop bar2
gen bar2=(zBarrs8 + zBarrs9 + zBarrs10 + zBarrs11 + zBarrs12 + zBarrs13)/6
tab1 bar1 bar2

capture drop barALL
gen barALL=(zBarrs1 + zBarrs2 + zBarrs3 + zBarrs4 + zBarrs5 + zBarrs6 + zBarrs7 + zBarrs8 + zBarrs9 + zBarrs10 + zBarrs11 + zBarrs12 + zBarrs13)/13
tab1 barALL

msp zEnab*

capture drop  ena1
gen ena1=(zEnab1+zEnab2+zEnab3+zEnab4+zEnab5)/5
tab ena1

*tobit
*Ordered logit - between linier and ordered logit - can there be diferent spacing between cateogries
*Ask OSRC about staff numbers
*
 *Generalised logit
 
 *findit gologit2
*net from http://fmwww.bc.edu/RePEc/bocode/g
*net install gologit2 

*ologit from combined models just to test
ologit zUsedat9 bar1 bar2 ena1

*With MSP variables shows no improvment
gologit2 zUsedat9 bar1 bar2 ena1, pl
gologit2 zUsedat9 bar1 bar2 ena1, npl

*With all bars indexed togeothr (theory over MSP) ther is a diference which supports the if statment and removing 0 regresisons
*	All bars togethor becasue the distinction trying to uncover is betwene bars and enablers
gologit2 zUsedat9 barALL ena1, pl
gologit2 zUsedat9 barALL ena1, npl

*With factors - also works with factors, may be sensible to exclude MSP
gologit2 zUsedat9 f1bar f2bar f3bar f1enab f2enab, pl
gologit2 zUsedat9 f1bar f2bar f3bar f1enab f2enab, npl



}
*

**************************
*Analytical quesiton 4 - Trust
**************************
{
*See primarysurvey_unharmonized.do in E:\Stats\1Thesis\OSCRdata\Analysis
}
*

**************************
*Analytical quesiton 6 - Networking
**************************
{
*	How does network centrality, among other network metrics and networking variables, relate to external data usage?
*		This section covers networking varaibles in the surveys

use $path11/TWAROSCRmergedCleanedNOtom.dta, clear

drop if fromtomsurvey==1

*Recodes
tab zUsedat5
recode zUsedat5 -9=. 5=0

capture drop zUsedat5bin
gen zUsedat5bin=zUsedat5
recode zUsedat5bin 0=0 1 2 3 4=1
tab zUsedat5bin

tab zUsedat9
recode zUsedat9 -9=. 5=0

capture drop zUsedat9bin
gen zUsedat9bin=zUsedat9
recode zUsedat9bin 0=0 1 2 3 4=1
tab zUsedat9bin

forval val = 1/3 {
recode zRecfrom`val' -99/-9=.
}
*
tab1 zRecfrom*

forval val = 1/5 {
recode zProvto`val' -99/-9=.
}
*
tab1 zProvto*

************
*Bivariate
************

****external and network
tab zUsedat5 zUsedat9, chi2 col gamma
*highly significant but not a very strong relationship


tab zUsedat5 zUsedat9 if zUsedat5~=0, chi2 col gamma
*sig but relationship even smaller
tab zUsedat5 zUsedat9 if zUsedat9~=0, chi2 col gamma
*sig but relationship even smaller
tab zUsedat5 zUsedat9 if zUsedat5~=0 & zUsedat9~=0, chi2 col gamma
*highly sig and with 0 removed relationship is much stronger gamma=0.2325. This may suggest that variations match better than binary use


tab zUsedat5bin zUsedat9, chi2 col gamma
*sig but weak
tab zUsedat5 zUsedat9bin, chi2 col gamma
*sig but weak
tab zUsedat5bin zUsedat9bin, chi2 col gamma
*significant and very strong gamma=0.5248. This infaltion is expected with a 2 category corss tab but still suggests that binary use correlates.
*Why both split down variables work better tha nthe full one is unclear.


***Recive data - negative means more common contact corelates with higher use

*Orgs to which provide a service
tab zUsedat9 zRecfrom1, col chi2 gamma
*Near sig, low negative relationship
tab zUsedat9 zRecfrom1 if zUsedat9~=0, col chi2 gamma
*significant moderate negative Pr=0.036 gamma=-0.1855
tab zUsedat9bin zRecfrom1, col chi2 gamma
*insig
*Suggests that reciving data from an org you provide a service to is corealted with varaition in data use - with more common contact indicating more use of data

*Collaborating orgs
tab zUsedat9 zRecfrom2, col chi2 gamma
*insig
tab zUsedat9 zRecfrom2 if zUsedat9~=0, col chi2 gamma
*insig
tab zUsedat9bin zRecfrom2, col chi2 gamma
*Pr=0.028 gamma=-0.3512
*Suggests that more common contact with collaborating orgs indicates use of data over not using it

*Data analytic providers
tab zUsedat9 zRecfrom3, col chi2 gamma
*Insig
tab zUsedat9 zRecfrom3 if zUsedat9~=0, col chi2 gamma
*insig
tab zUsedat9bin zRecfrom3, col chi2 gamma
*insig
*Given the large org make up of this data this may not be surprising - theory that smaller orgs are who is useing data analytic support

****Provide data

*Orgs to which provide a service
tab zUsedat9 zProvto1, col chi2 gamma
*sig, moderate relationship
tab zUsedat9 zProvto1 if zUsedat9~=0, col chi2 gamma
*more sig, larger relationship - Pr=0.001 gamma=-0.1735 - suggests providing data to org you provide a service corlates with data use variation - more contact, more use. Also stronger than reciving from this group.
tab zUsedat9bin zProvto1, col chi2 gamma
*insig

*Collaborating orgs
tab zUsedat9 zProvto2, col chi2 gamma
*sig, moderate Pr=0.021 gamma=-0.1798 - unlike its recive counterpart this predicts the overall data best - both binary and variation
tab zUsedat9 zProvto2 if zUsedat9~=0, col chi2 gamma
*sig, small
tab zUsedat9bin zProvto2, col chi2 gamma
*insig

*Third party intermediaries
tab zUsedat9 zProvto3, col chi2 gamma
*insig
tab zUsedat9 zProvto3 if zUsedat9~=0, col chi2 gamma
*insig
tab zUsedat9bin zProvto3, col chi2 gamma
*insig

*Regulatory bodies
tab zUsedat9 zProvto4, col chi2 gamma
*near sig, small
tab zUsedat9 zProvto4 if zUsedat9~=0, col chi2 gamma
*sig, small Pr=0.022 gamma=-0.1209 - this suggests providing data to regualtory boides commonly corelates with variation in data use - but the relationship is small
tab zUsedat9bin zProvto4, col chi2 gamma
*insig

*Grant making trusts
tab zUsedat9 zProvto5, col chi2 gamma
*insig
tab zUsedat9 zProvto5 if zUsedat9~=0, col chi2 gamma
*insig
tab zUsedat9bin zProvto5, col chi2 gamma
*near sig Pr=0.095 gamma=-0.0751 - this is both not significant and very small relationship - hard to conclude much

************
*Factor analysis
************

*Factor analysis for zRecfrom
polychoric zRecfrom*
di r(sum_w)
global N=r(sum_w)
matrix r=r(R)
factormat r, n($N) blanks(0.3) factors(1)

*used to decide how many factors to use - 1
screeplot

*rotations 
rotate, clear
rotate, promax blanks(0.4)
rotate, clear
*3 wont load on the factor

*MSP to see if 3 loads
msp zRecfrom*

*3 is also kicked here 

*gets the factors into data as variables
capture drop rec1  
predict rec1

*used to justify using factor analysis - usually above 0.5 is justified - just justified
estat kmo


*Factor analysis for zProvto
polychoric zProvto*
di r(sum_w)
global N=r(sum_w)
matrix r=r(R)
factormat r, n($N) blanks(0.3) factors(1)

*used to decide how many factors to use - 1
screeplot

*rotations 
rotate, clear
rotate, promax blanks(0.4)
rotate, clear

*All variables loading, check with MSP
msp zProvto*

*gets the factors into data as variables
capture drop prov1  
predict prov1

*used to justify using factor analysis - usually above 0.5 is justified - is justified
estat kmo

*Factor analysis for zProvto
polychoric zProvto* zRecfrom*
di r(sum_w)
global N=r(sum_w)
matrix r=r(R)
factormat r, n($N) blanks(0.3) factors(1)

*used to decide how many factors to use - 1
screeplot, graphregion(color(white))
graph export $path11\Analysis\Graphs\screeplot.tif , width(900)  height(700) replace


*rotations 
rotate, clear
rotate, promax blanks(0.4)
rotate, clear

*MSP suggests they are all the same anyways as some form of network contact latent variable
msp zProvto* zRecfrom*

*gets the factors into data as variables
capture drop combo1  
predict combo1

*kmo test - justified
estat kmo


************
*Regression of factors
************
ologit zUsedat9 rec1
ologit zUsedat9 rec1 if zUsedat9~=0
logit zUsedat9bin rec1
*sig

ologit zUsedat9 prov1
ologit zUsedat9 prov1 if zUsedat9~=0
logit zUsedat9bin prov1
*factor 1 is insig in all cases

ologit zUsedat9 combo1
ologit zUsedat9 combo1 if zUsedat9~=0
logit zUsedat9bin combo1
*near sig

}
*














