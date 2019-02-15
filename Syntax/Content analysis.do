
global path1 "E:\Dropbox\Stats\1Thesis\1Network_analysis"
global path2 "E:\Dropbox\Stats\1Thesis\1Network_analysis\Working_data_mentions_reaplies_only"
global path3 "E:\Dropbox\Stats\1Thesis\1Network_analysis\Mater_combined_network_data"
global path4 "E:\Dropbox\Stats\1Thesis\1Network_analysis\Graphs"
global path5 "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis"
global path5 "E:\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis"
global path9 "E:\Dropbox\Stats\1Thesis\Temp"

*Merging
import excel using $path5/tweets_from_1MASTERdatabasedon.xlsx , firstrow clear

rename Tweet tweet

sav "$path5/1.dta" , replace

******************************************************************
use $path5/1.dta, clear

*Tweets per group - support most active- charity and data similar - not ajdusted for relitive numbers in smaple
tab Groupofsender

*Adusted for size of groups (sizes from analysisof3master...). Support most active - followed by data, charity least active
di 2972/112
di 7528/69
di 2247/26
di 9/1

*Overall

quietly count if regexm(tweet,"RT")
di (r(N)/_N)*100

quietly count if regexm(tweet,"http")
di (r(N)/_N)*100

quietly count if regexm(tweet,"#")
di (r(N)/_N)*100

quietly count if regexm(tweet,"Data")
scalar a=r(N)
quietly count if regexm(tweet,"data")
scalar b=r(N)
quietly count if regexm(tweet,"DATA")
scalar c=r(N)
scalar d=a+b+c
di (d/_N)*100


quietly count if regexm(tweet,"Stat")
scalar a=r(N)
quietly count if regexm(tweet,"stat")
scalar b=r(N)
quietly count if regexm(tweet,"statistic")
scalar c=r(N)
quietly count if regexm(tweet,"Statistic")
scalar d=r(N)
scalar e=a+b+c+d
di (e/_N)*100


quietly count if regexm(tweet,"Finding")
scalar a=r(N)
quietly count if regexm(tweet,"finding")
scalar b=r(N)
scalar c=a+b
di (c/_N)*100

quietly count if regexm(tweet,"Evidence")
scalar a=r(N)
quietly count if regexm(tweet,"evidence")
scalar b=r(N)
scalar c=a+b
di (c/_N)*100

quietly count if regexm(tweet,"Report")
scalar a=r(N)
quietly count if regexm(tweet,"report")
scalar b=r(N)
scalar c=a+b
di (c/_N)*100

*Foreach group
use $path5/1.dta, clear

tab Groupofsender

*Group 1 - Charities 
{
quietly count if regexm(tweet,"RT") & Groupofsender==1
di (r(N)/2972)*100

quietly count if regexm(tweet,"http") & Groupofsender==1
di (r(N)/2972)*100

quietly count if regexm(tweet,"#") & Groupofsender==1
di (r(N)/2972)*100

quietly count if regexm(tweet,"%") & Groupofsender==1
di (r(N)/2972)*100

quietly count if regexm(tweet,"Data") & Groupofsender==1
scalar a=r(N)
quietly count if regexm(tweet,"data") & Groupofsender==1
scalar b=r(N)
quietly count if regexm(tweet,"DATA") & Groupofsender==1
scalar c=r(N)
scalar d=a+b+c
di (d/2972)*100

quietly count if regexm(tweet,"Research") & Groupofsender==1
scalar a=r(N)
quietly count if regexm(tweet,"research") & Groupofsender==1
scalar b=r(N)
scalar c=a+b
di (c/2972)*100

quietly count if regexm(tweet,"Stat") & Groupofsender==1
scalar a=r(N)
quietly count if regexm(tweet,"stat") & Groupofsender==1
scalar b=r(N)
quietly count if regexm(tweet,"statistic") & Groupofsender==1
scalar c=r(N)
quietly count if regexm(tweet,"Statistic") & Groupofsender==1
scalar d=r(N)
scalar e=a+b+c+d
di (e/2972)*100


quietly count if regexm(tweet,"Finding") & Groupofsender==1
scalar a=r(N)
quietly count if regexm(tweet,"finding") & Groupofsender==1
scalar b=r(N)
scalar c=a+b
di (c/2972)*100

quietly count if regexm(tweet,"Evidence") & Groupofsender==1
scalar a=r(N)
quietly count if regexm(tweet,"evidence") & Groupofsender==1
scalar b=r(N)
scalar c=a+b
di (c/2972)*100

quietly count if regexm(tweet,"Report") & Groupofsender==1
scalar a=r(N)
quietly count if regexm(tweet,"report") & Groupofsender==1
scalar b=r(N)
scalar c=a+b
di (c/2972)*100
}
*

*Group 2 - Support 
{
quietly count if regexm(tweet,"RT") & Groupofsender==2
di (r(N)/7528)*100

quietly count if regexm(tweet,"http") & Groupofsender==2
di (r(N)/7528)*100

quietly count if regexm(tweet,"#") & Groupofsender==2
di (r(N)/7528)*100

quietly count if regexm(tweet,"%") & Groupofsender==2
di (r(N)/7528)*100

quietly count if regexm(tweet,"Data") & Groupofsender==2
scalar a=r(N)
quietly count if regexm(tweet,"data") & Groupofsender==2
scalar b=r(N)
quietly count if regexm(tweet,"DATA") & Groupofsender==2
scalar c=r(N)
scalar d=a+b+c
di (d/7528)*100

quietly count if regexm(tweet,"Research") & Groupofsender==2
scalar a=r(N)
quietly count if regexm(tweet,"research") & Groupofsender==2
scalar b=r(N)
scalar c=a+b
di (c/7528)*100

quietly count if regexm(tweet,"Stat") & Groupofsender==2
scalar a=r(N)
quietly count if regexm(tweet,"stat") & Groupofsender==2
scalar b=r(N)
quietly count if regexm(tweet,"statistic") & Groupofsender==2
scalar c=r(N)
quietly count if regexm(tweet,"Statistic") & Groupofsender==2
scalar d=r(N)
scalar e=a+b+c+d
di (e/7528)*100


quietly count if regexm(tweet,"Finding") & Groupofsender==2
scalar a=r(N)
quietly count if regexm(tweet,"finding") & Groupofsender==2
scalar b=r(N)
scalar c=a+b
di (c/7528)*100

quietly count if regexm(tweet,"Evidence") & Groupofsender==2
scalar a=r(N)
quietly count if regexm(tweet,"evidence") & Groupofsender==2
scalar b=r(N)
scalar c=a+b
di (c/7528)*100

quietly count if regexm(tweet,"Report") & Groupofsender==2
scalar a=r(N)
quietly count if regexm(tweet,"report") & Groupofsender==2
scalar b=r(N)
scalar c=a+b
di (c/7528)*100
}
*

*Group 3 - Support 
{
quietly count if regexm(tweet,"RT") & Groupofsender==3
di (r(N)/2247)*100

quietly count if regexm(tweet,"http") & Groupofsender==3
di (r(N)/2247)*100

quietly count if regexm(tweet,"#") & Groupofsender==3
di (r(N)/2247)*100

quietly count if regexm(tweet,"%") & Groupofsender==3
di (r(N)/2247)*100

quietly count if regexm(tweet,"Data") & Groupofsender==3
scalar a=r(N)
quietly count if regexm(tweet,"data") & Groupofsender==3
scalar b=r(N)
quietly count if regexm(tweet,"DATA") & Groupofsender==3
scalar c=r(N)
scalar d=a+b+c
di (d/2247)*100

quietly count if regexm(tweet,"Research") & Groupofsender==3
scalar a=r(N)
quietly count if regexm(tweet,"research") & Groupofsender==3
scalar b=r(N)
scalar c=a+b
di (c/2247)*100

quietly count if regexm(tweet,"Stat") & Groupofsender==3
scalar a=r(N)
quietly count if regexm(tweet,"stat") & Groupofsender==3
scalar b=r(N)
quietly count if regexm(tweet,"statistic") & Groupofsender==3
scalar c=r(N)
quietly count if regexm(tweet,"Statistic") & Groupofsender==3
scalar d=r(N)
scalar e=a+b+c+d
di (e/2247)*100


quietly count if regexm(tweet,"Finding") & Groupofsender==3
scalar a=r(N)
quietly count if regexm(tweet,"finding") & Groupofsender==3
scalar b=r(N)
scalar c=a+b
di (c/2247)*100

quietly count if regexm(tweet,"Evidence") & Groupofsender==3
scalar a=r(N)
quietly count if regexm(tweet,"evidence") & Groupofsender==3
scalar b=r(N)
scalar c=a+b
di (c/2247)*100

quietly count if regexm(tweet,"Report") & Groupofsender==3
scalar a=r(N)
quietly count if regexm(tweet,"report") & Groupofsender==3
scalar b=r(N)
scalar c=a+b
di (c/2247)*100
}
*

*Group 4 - Govenrment 
{
quietly count if regexm(tweet,"RT") & Groupofsender==4
di (r(N)/9)*100

quietly count if regexm(tweet,"http") & Groupofsender==4
di (r(N)/9)*100

quietly count if regexm(tweet,"#") & Groupofsender==4
di (r(N)/9)*100

quietly count if regexm(tweet,"%") & Groupofsender==4
di (r(N)/9)*100

quietly count if regexm(tweet,"Data") & Groupofsender==4
scalar a=r(N)
quietly count if regexm(tweet,"data") & Groupofsender==4
scalar b=r(N)
quietly count if regexm(tweet,"DATA") & Groupofsender==4
scalar c=r(N)
scalar d=a+b+c
di (d/9)*100

quietly count if regexm(tweet,"Research") & Groupofsender==4
scalar a=r(N)
quietly count if regexm(tweet,"research") & Groupofsender==4
scalar b=r(N)
scalar c=a+b
di (c/9)*100


quietly count if regexm(tweet,"Stat") & Groupofsender==4
scalar a=r(N)
quietly count if regexm(tweet,"stat") & Groupofsender==4
scalar b=r(N)
quietly count if regexm(tweet,"statistic") & Groupofsender==4
scalar c=r(N)
quietly count if regexm(tweet,"Statistic") & Groupofsender==4
scalar d=r(N)
scalar e=a+b+c+d
di (e/9)*100


quietly count if regexm(tweet,"Finding") & Groupofsender==4
scalar a=r(N)
quietly count if regexm(tweet,"finding") & Groupofsender==4
scalar b=r(N)
scalar c=a+b
di (c/9)*100

quietly count if regexm(tweet,"Evidence") & Groupofsender==4
scalar a=r(N)
quietly count if regexm(tweet,"evidence") & Groupofsender==4
scalar b=r(N)
scalar c=a+b
di (c/9)*100

quietly count if regexm(tweet,"Report") & Groupofsender==4
scalar a=r(N)
quietly count if regexm(tweet,"report") & Groupofsender==4
scalar b=r(N)
scalar c=a+b
di (c/9)*100
}
*

*Most common tweets
use $path5/1.dta, clear

duplicates tag tweet, generate(tag)
sort tag

*87.9% of tweets unique
tab tag

duplicates drop tweet, force

*87.9% of tweets unique
tab tag

*Popular tweets
list tweet if tag>6

*use $path5/1.dta, clear
use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear

keep if regexm(tweet," great ") | regexm(tweet," Great ")

keep if regexm(tweet," Social ") | regexm(tweet," social ")

keep if regexm(tweet," Scotland ") | regexm(tweet," scotland ")

*Data
use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==1
keep if regexm(tweet," data ") | regexm(tweet," Data ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==2
keep if regexm(tweet," data ") | regexm(tweet," Data ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==3
keep if regexm(tweet," data ") | regexm(tweet," Data ")

*Breakdowns
use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==1
keep if Groupofreciver==2
keep if regexm(tweet," data ") | regexm(tweet," Data ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==1
keep if Groupofreciver==3
keep if regexm(tweet," data ") | regexm(tweet," Data ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==2
keep if Groupofreciver==1
keep if regexm(tweet," data ") | regexm(tweet," Data ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==2
keep if Groupofreciver==3
keep if regexm(tweet," data ") | regexm(tweet," Data ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==3
keep if Groupofreciver==1
keep if regexm(tweet," data ") | regexm(tweet," Data ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==3
keep if Groupofreciver==2
keep if regexm(tweet," data ") | regexm(tweet," Data ")

*others
use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," event ") | regexm(tweet," Event ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," support ") | regexm(tweet," Support ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," help ") | regexm(tweet," Help ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," find ") | regexm(tweet," Find ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," latest ") | regexm(tweet," Latest ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," research ") | regexm(tweet," Research ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," stats ") | regexm(tweet," Stats ") | regexm(tweet," Statistics ") | regexm(tweet," statistics ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," findings ") | regexm(tweet," Findings ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," evidence ") | regexm(tweet," Evidence ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," report ") | regexm(tweet," Report ")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet,"%")

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet," mean") | regexm(tweet," Mean")

*Gov tweets
use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if Groupofsender==4


*URLs

use "C:\Users\tw18\Dropbox\Stats\1Thesis\1Network_analysis\Content_analysis\1.dta" , clear
keep if regexm(tweet,"http") | regexm(tweet,"http")

tab Groupofsender Groupofreciver

keep if regexm(tweet," data ") | regexm(tweet," Data ") | regexm(tweet," research ") | regexm(tweet," Research ") | regexm(tweet," stats ") ///
 | regexm(tweet," Stats ") | regexm(tweet," Statistics ") | regexm(tweet," statistics ") | regexm(tweet," findings ") | regexm(tweet," Findings ")  ///
 | regexm(tweet," evidence ") | regexm(tweet," Evidence ") | regexm(tweet," report ") | regexm(tweet," Report ") | regexm(tweet,"%")

drop if Groupofreciver==4
 
tab Groupofsender Groupofreciver

*
use $path5/1.dta, clear

keep if regexm(tweet,"http") | regexm(tweet,"http")

tab Groupofsender Groupofreciver

keep if regexm(tweet," data ") | regexm(tweet," Data ") | regexm(tweet," research ") | regexm(tweet," Research ") | regexm(tweet," stats ") ///
 | regexm(tweet," Stats ") | regexm(tweet," Statistics ") | regexm(tweet," statistics ") | regexm(tweet," findings ") | regexm(tweet," Findings ")  ///
 | regexm(tweet," evidence ") | regexm(tweet," Evidence ") | regexm(tweet," report ") | regexm(tweet," Report ") | regexm(tweet,"%")

keep if Groupofreciver==2
keep if Groupofsender==3


tab Groupofsender Groupofreciver





