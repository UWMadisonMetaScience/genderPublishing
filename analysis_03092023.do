* final data check/walk through for gender-ethnicity paper - SNP only

global control0 "i.rank i.discipline"
global control "i.rank"

**********Analyzing general submission behavior*******

* total number of respondents replied to the question of whehter submitted to SNP
capture drop SNPSubmit
generate SNPSubmit=0
replace SNPSubmit=1 if jsci==1 | jnat==1 | jpnas==1
replace SNPSubmit=9 if jsci==. & jnat==. & jpnas==.
tab SNPSubmit female if SNPSubmit!=9
tab SNPSubmit gender if discipline_area=="SS"

**Logistic regression analysis on whether gender is related to SNPSubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic SNPSubmit i.female $control if rank>0 & SNPSubmit!=9
logistic SNPSubmit i.female $control0 if rank>0 & SNPSubmit!=9

* total number of respondents replied to the question of whehter submitted to NCSA
tab NCSASubmit gender
capture drop NCSASubmit
generate NCSASubmit=0
replace NCSASubmit=1 if jnc==1 | jsa==1
replace NCSASubmit=9 if jnc==. & jsa==.
tab NCSASubmit female if NCSASubmit!=9
tab discipline_area NCSASubmit if gender=="M"

**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic NCSASubmit i.female $control if rank>0 & NCSASubmit!=9
logistic NCSASubmit i.female $control0 if rank>0 & NCSASubmit!=9

* total number of respondents replied to the question of whehter submitted to NCSA
tab NEJMCSubmit gender
capture drop NEJMCSubmit
generate NEJMCSubmit=0
replace NEJMCSubmit=1 if jnejm==1 | jcell==1
replace NEJMCSubmit=9 if jnejm==. & jcell==.
tab NEJMCSubmit female if NEJMCSubmit!=9
tab discipline_area NEJMCSubmit if gender=="M"
tab discipline_area NEJMCSubmit if gender=="F"

**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic NEJMCSubmit i.female $control if rank>0 & NEJMCSubmit!=9
logistic NEJMCSubmit i.female $control0 if rank>0 & NEJMCSubmit!=9


*****Number of Manuscripts submitted to SNP****
tab SNPtotal_new gender
by discipline_area, sort : summarize SNPtotal_new if SNPtotal_new!=. & gender=="F" 
by discipline_area, sort : summarize SNPtotal_new if SNPtotal_new!=. & gender=="M" 
summarize SNPtotal_new if SNPtotal_new!=. & gender=="M" 
**Regerssion on the number of submissions to SNP****
by discipline_area, sort : regress SNPtotal_new i.female $control if rank!=0 & SNPtotal_new!=.
regress SNPtotal_new i.female $control0 if rank!=0 & SNPtotal_new!=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed SNPtotal_new i.female || rank: if rank!=0


*****Number of Manuscripts submitted to NCSA****
capture drop NCSAtotal_new
generate NCSAtotal_new=.
replace NCSAtotal_new=jncsubmit if NCSASubmit==1 & jncsubmit!=.&jsasubmit==.
replace NCSAtotal_new=jsasubmit if NCSASubmit==1 & jncsubmit==. & jsasubmit!=.
replace NCSAtotal_new=jsasubmit+jncsubmit if NCSASubmit==1 & jncsubmit!=. & jsasubmit!=.
tab NCSAtotal_new gender

by discipline_area, sort : summarize NCSAtotal_new if NCSAtotal_new!=. & gender=="F" 
summarize NCSAtotal_new if NCSAtotal_new!=. & gender=="F" 
by discipline_area, sort : summarize NCSAtotal_new if NCSAtotal_new!=. & gender=="M" 
summarize NCSAtotal_new if NCSAtotal_new!=. & gender=="M" 

**Regerssion on the number of submissions to SNP****
by discipline_area, sort : regress NCSAtotal_new i.female $control if rank!=0 & NCSAtotal_new!=.
regress NCSAtotal_new i.female $control0 if rank!=0 & NCSAtotal_new!=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed NCSAtotal_new i.female || rank: if rank!=0


*****Number of Manuscripts submitted to nejm and cell NEJMCtotal****
capture drop NEJMCtotal_new
generate NEJMCtotal_new=.
replace NEJMCtotal_new=jnejmsubmit if NEJMCSubmit==1 & jnejmsubmit!=.&jcellsubmit==.
replace NEJMCtotal_new=jcellsubmit if NEJMCSubmit==1 & jnejmsubmit==. & jcellsubmit!=.
replace NEJMCtotal_new=jcellsubmit+jnejmsubmit if NEJMCSubmit==1 & jnejmsubmit!=. & jcellsubmit!=.
tab NEJMCtotal_new gender

tab NEJMCtotal_new gender
by discipline_area, sort : summarize NEJMCtotal_new  if NEJMCtotal_new !=. & gender=="F" 
summarize NEJMCtotal_new  if NEJMCtotal_new !=. & gender=="F" 
by discipline_area, sort : summarize NEJMCtotal_new  if NEJMCtotal_new !=. & gender=="M" 
summarize NEJMCtotal_new  if NEJMCtotal_new !=. & gender=="M" 

**Regerssion on the number of submissions to SNP****
by discipline_area, sort : regress NEJMCtotal_new  i.female $control if rank!=0 & NEJMCtotal_new !=.
regress NEJMCtotal_new  i.female $control0 if rank!=0 & NEJMCtotal_new !=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed NCSAtotal_new i.female || rank: if rank!=0

**** Accept Rate of SNP****
**** number of manuscripts accepted by SNP****
capture drop snpaccept
generate snpaccept=.
replace snpaccept=jsciaccept if SNPSubmit==1 & jnataccept==. & jpnasaccept==. & jsciaccept!=.
replace snpaccept=jnataccept if SNPSubmit==1 & jsciaccept==. & jpnasaccept==. & jnataccept!=.
replace snpaccept=jpnasaccept if SNPSubmit==1 & jsciaccept==. & jnataccept==. & jpnasaccept!=.
replace snpaccept=jsciaccept+jnataccept if SNPSubmit==1 & jpnasaccept==. & jsciaccept!=. & jnataccept!=.
replace snpaccept=jsciaccept+jpnasaccept if SNPSubmit==1 & jnataccept==. & jsciaccept!=. & jpnasaccept!=.
replace snpaccept=jnataccept+jpnasaccept if SNPSubmit==1 & jsciaccept==. & jsciaccept!=. & jnataccept!=.
replace snpaccept=jnataccept+jpnasaccept+jsciaccept if SNPSubmit==1 & jsciaccept!=. & jnataccept!=.& jpnasaccept!=.
*** acceptance rate=accept/total submission
capture drop snpacceptRate
generate snpacceptRate=snpaccept/SNPtotal_new
summarize snpacceptRate
by discipline_area, sort : summarize snpacceptRate  if SNPSubmit==1 & gender=="M"
summarize snpacceptRate  if SNPSubmit==1 & gender=="M"
**** regression analysis on acceptance rate
by discipline_area, sort : regress snpacceptRate  i.female $control if rank!=0 & SNPtotal_new!=.
regress snpacceptRate  i.female $control0 if rank!=0 & SNPtotal_new!=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed snpacceptRate i.female || rank: if rank!=0


**** number of manuscripts accepted by NCSA****
capture drop ncsaaccept
generate ncsaaccept=.
replace ncsaaccept=jncaccept if NCSASubmit==1 & jsaaccept==. & jncaccept!=.
replace ncsaaccept=jsaaccept if NCSASubmit==1 & jncaccept==. & jsaaccept!=.
replace ncsaaccept=jncaccept+jsaaccept if NCSASubmit==1 & jsaaccept!=. & jncaccept!=.
*** acceptance rate=accept/total submission
capture drop ncsaacceptRate
generate ncsaacceptRate=ncsaaccept/NCSAtotal_new
summarize ncsaacceptRate
by discipline_area, sort : summarize ncsaacceptRate  if NCSASubmit==1 & gender=="F"
summarize ncsaacceptRate  if NCSASubmit==1 & gender=="F"
**** regression analysis on acceptance rate
by discipline_area, sort : regress ncsaacceptRate  i.female $control if rank!=0 & NCSAtotal_new!=.
regress ncsaacceptRate  i.female $control0 if rank!=0 & NCSAtotal_new!=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed ncsaacceptRate $control || rank: if rank!=0


**** number of manuscripts accepted by nejm cell****
capture drop nejmcaccept
generate nejmcaccept=.
replace nejmcaccept=jnejmaccept if NEJMCSubmit==1 & jcellaccept==. & jnejmaccept!=.
replace nejmcaccept=jcellaccept if NEJMCSubmit==1 & jnejmaccept==. & jcellaccept!=.
replace nejmcaccept=jnejmaccept+jcellaccept if NEJMCSubmit==1 & jnejmaccept!=. & jcellaccept!=.
*** acceptance rate=accept/total submission
capture drop nejmcacceptRate
generate nejmcacceptRate=nejmcaccept/NEJMCtotal_new
summarize nejmcacceptRate
by discipline_area, sort : summarize nejmcacceptRate  if NEJMCSubmit==1 & gender=="M"
summarize nejmcacceptRate  if NEJMCSubmit==1 & gender=="M"
**** regression analysis on acceptance rate
by discipline_area, sort : regress nejmcacceptRate  i.female $control if rank!=0 & NEJMCtotal_new!=.
regress nejmcacceptRate  i.female $control0 if rank!=0 & NEJMCtotal_new!=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed nejmcacceptRate i.female || rank: if rank!=0


**** Desk Rejection for Submissions to SNP****
capture drop snpdeskrej
generate snpdeskrej=.
replace snpdeskrej=1-(jscipeerrev/SNPtotal_new) if SNPSubmit==1 & jscipeerrev!=. & jnatpeerrev==. & jpnaspeerrev==.
replace snpdeskrej=1-(jnatpeerrev/SNPtotal_new) if SNPSubmit==1 & jscipeerrev==. & jnatpeerrev!=. & jpnaspeerrev==.
replace snpdeskrej=1-(jpnaspeerrev/SNPtotal_new) if SNPSubmit==1 & jscipeerrev==. & jnatpeerrev==. & jpnaspeerrev!=.
replace snpdeskrej=1-(jscipeerrev+jnatpeerrev)/SNPtotal_new if SNPSubmit==1 & jpnaspeerrev==. & jscipeerrev!=. & jnatpeerrev!=.
replace snpdeskrej=1-(jscipeerrev+jpnaspeerrev)/SNPtotal_new if SNPSubmit==1 & jpnaspeerrev!=. & jscipeerrev!=. & jnatpeerrev==.
replace snpdeskrej=1-(jpnaspeerrev+jnatpeerrev)/SNPtotal_new if SNPSubmit==1 & jpnaspeerrev!=. & jnatpeerrev!=. & jscipeerrev==.
replace snpdeskrej=1-(jpnaspeerrev+jnatpeerrev+jscipeerrev)/SNPtotal_new if SNPSubmit==1 & jpnaspeerrev!=. & jnatpeerrev!=. & jscipeerrev!=.
summarize snpdeskrej
*** DESK REJECTION OF SNP descriptive stats***
by discipline_area, sort : summarize snpdeskrej  if SNPSubmit==1 & gender=="F"
summarize snpdeskrej  if SNPSubmit==1 & gender=="F"
**** regression analysis on acceptance rate
by discipline_area, sort : regress snpdeskrej  i.female $control if rank!=0 & SNPtotal_new!=.
regress snpdeskrej  i.female $control0 if rank!=0 & SNPtotal_new!=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed snpdeskrej i.female || rank: if rank!=0


**** Desk Rejection for Submissions to NCSA********
capture drop ncsadeskrej
generate ncsadeskrej=.
replace ncsadeskrej=1-(jncpeerrev/NCSAtotal_new) if NCSASubmit==1 & jncpeerrev!=. & jsapeerrev==.
replace ncsadeskrej=1-(jsapeerrev/NCSAtotal_new) if NCSASubmit==1 & jncpeerrev==. & jsapeerrev!=.
replace ncsadeskrej=1-(jncpeerrev+jsapeerrev)/NCSAtotal_new if NCSASubmit==1 & jncpeerrev!=. & jsapeerrev!=.
summarize ncsadeskrej 
tab ncsadeskrej gender
*** DESK REJECTION OF NCSA descriptive stats***
by discipline_area, sort : summarize ncsadeskrej  if NCSASubmit==1 & gender=="M"
summarize ncsadeskrej  if NCSASubmit==1 & gender=="M"
**** regression analysis on acceptance rate
by discipline_area, sort : regress ncsadeskrej  i.female $control if rank!=0 & NCSAtotal_new!=.
regress ncsadeskrej  i.female $control0 if rank!=0 & NCSAtotal_new!=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed ncsadeskrej i.female || rank: if rank!=0

**** Desk Rejection for Submissions to NEJMC********
*** jnejmpeerrev data is string, using real() to convert to float***
generate jnejmpeerrev_convert=real(jnejmpeerrev)
capture drop nejmcdeskrej
generate nejmcdeskrej=.
replace nejmcdeskrej=1-(jnejmpeerrev_convert/NEJMCtotal_new) if NEJMCSubmit==1 & jnejmpeerrev_convert!=. & jcellpeerrev==.
replace nejmcdeskrej=1-(jcellpeerrev/NEJMCtotal_new) if NEJMCSubmit==1 & jnejmpeerrev_convert==. & jcellpeerrev!=.
replace nejmcdeskrej=1-(jcellpeerrev+jnejmpeerrev_convert)/NEJMCtotal_new if NEJMCSubmit==1 & jnejmpeerrev_convert!=. & jcellpeerrev!=.
summarize nejmcdeskrej 
tab nejmcdeskrej gender

*** DESK REJECTION OF NEJM CELL descriptive stats***
by discipline_area, sort : summarize nejmcdeskrej  if NEJMCSubmit==1 & gender=="F"
summarize nejmcdeskrej  if NEJMCSubmit==1 & gender=="F"
**** regression analysis on acceptance rate
by discipline_area, sort : regress nejmcdeskrej  i.female $control if rank!=0 & NEJMCtotal_new!=.
regress nejmcdeskrej  i.female $control0 if rank!=0 & NEJMCtotal_new!=.
*** test using mixed regression model with rank being the mixed effect
by discipline_area, sort : mixed nejmcdeskrej i.female || rank: if rank!=0


********Analysis on Reasons not submitting to top journals -general publications ************************
summarize jsciquality jnatquality jpnasquality jncquality jsaquality jnejmquality jcellquality
tab jpnas gender
***** reason1: not of highly quality ***
tab SNPSubmit gender if SNPSubmit!=9 & SNPSubmit==0
capture drop snpquality
generate snpquality=0
replace snpquality=1 if jsciquality==1 | jnatquality==1 | jpnasquality==1
replace snpquality=. if jsciquality==. & jnatquality==. & jpnasquality==.
replace snpquality=. if SNPSubmit!=0
summarize snpquality
tab snpquality gender
tab discipline_area snpquality if gender=="F"
tab discipline_area snpquality if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic snpquality i.female $control if rank>0 & snpquality!=.
logistic snpquality i.female $control0 if rank>0 & snpquality!=.

tab ncsaquality gender
capture drop ncsaquality
generate ncsaquality=0
replace ncsaquality=1 if jncquality==1 | jsaquality==1
replace ncsaquality=. if jncquality==. & jsaquality==.
replace ncsaquality=. if NCSASubmit!=0
tab ncsaquality gender
tab discipline_area ncsaquality if gender=="F"
tab discipline_area ncsaquality if gender=="M"
by discipline_area, sort : logistic ncsaquality i.female $control if rank>0 & ncsaquality!=.
logistic ncsaquality i.female $control0 if rank>0 & ncsaquality!=.


capture drop nejmcquality
generate nejmcquality=0 if NEJMCSubmit==0
replace nejmcquality=1 if jnejmquality==1 | jcellquality==1
replace nejmcquality=. if jnejmquality==. & jcellquality==.
replace nejmcquality=. if NEJMCSubmit!=0
tab nejmcquality gender
tab discipline_area nejmcquality if gender=="F"
tab discipline_area nejmcquality if gender=="M"
by discipline_area, sort : logistic nejmcquality i.female $control if rank>0 & nejmcquality!=.
logistic nejmcquality i.female $control0 if rank>0 & nejmcquality!=.

***** reason2: out of scope****
tab SNPSubmit gender if SNPSubmit!=9 & SNPSubmit==0
capture drop snpscope
generate snpscope=0
replace snpscope=1 if jsciscope==1 | jnatscope==1 | jpnasscope==1
replace snpscope=. if jsciscope==. & jnatscope==. & jpnasscope==.
replace snpscope=. if SNPSubmit!=0
summarize snpscope
tab snpscope gender
tab discipline_area snpscope if gender=="F"
tab discipline_area snpscope if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic snpscope i.female$control if rank>0 & snpscope!=.
logistic snpscope i.female $control0 if rank>0 & snpscope!=.

tab ncsascope gender
capture drop ncsascope
generate ncsascope=0
replace ncsascope=1 if jncscope==1 | jsascope==1
replace ncsascope=. if jncscope==. & jsascope==.
replace ncsascope=. if NCSASubmit!=0
tab ncsascope gender
tab discipline_area ncsascope if gender=="F"
tab discipline_area ncsascope if gender=="M"
by discipline_area, sort : logistic ncsascope i.female $control if rank>0 & ncsascope!=.
logistic ncsascope i.female $control0 if rank>0 & ncsascope!=.


capture drop nejmcscope
generate nejmcscope=0 if NEJMCSubmit==0
replace nejmcscope=1 if jnejmscope==1 | jcellscope==1
replace nejmcscope=. if jnejmscope==. & jcellscope==.
replace nejmcscope=. if NEJMCSubmit!=0
tab nejmcscope gender
tab discipline_area nejmcscope if gender=="F"
tab discipline_area nejmcscope if gender=="M"
by discipline_area, sort : logistic nejmcscope i.female $control if rank>0 & nejmcscope!=.
logistic nejmcscope i.female $control0 if rank>0 & nejmcscope!=.



***** reason3: not groundbreaking or sufficiently novel****
tab SNPSubmit gender if SNPSubmit!=9 & SNPSubmit==0
capture drop snpnovel
generate snpnovel=0
replace snpnovel=1 if jscinovel==1 | jnatnovel==1 | jpnasnovel==1
replace snpnovel=. if jscinovel==. & jnatnovel==. & jpnasnovel==.
replace snpnovel=. if SNPSubmit!=0
summarize snpnovel
tab snpnovel gender
tab discipline_area snpnovel if gender=="F"
tab discipline_area snpnovel if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic snpnovel i.female $control if rank>0 & snpnovel!=.
logistic snpnovel i.female $control0 if rank>0 & snpnovel!=.

tab ncsanovel gender
capture drop ncsanovel
generate ncsanovel=0
replace ncsanovel=1 if jncnovel==1 | jsanovel==1
replace ncsanovel=. if jncnovel==. & jsanovel==.
replace ncsanovel=. if NCSASubmit!=0
tab ncsanovel gender
tab discipline_area ncsanovel if gender=="F"
tab discipline_area ncsanovel if gender=="M"
by discipline_area, sort : logistic ncsanovel i.female $control if rank>0 & ncsanovel!=.
logistic ncsanovel i.female $control0 if rank>0 & ncsanovel!=.


capture drop nejmcnovel
generate nejmcnovel=0 if NEJMCSubmit==0
replace nejmcnovel=1 if jnejmnovel==1 | jcellnovel==1
replace nejmcnovel=. if jnejmnovel==. & jcellnovel==.
replace nejmcnovel=. if NEJMCSubmit!=0
tab nejmcnovel gender
tab discipline_area nejmcnovel if gender=="F"
tab discipline_area nejmcnovel if gender=="M"
by discipline_area, sort : logistic nejmcnovel i.female $control if rank>0 & nejmcnovel!=.
logistic nejmcnovel i.female $control0 if rank>0 & nejmcnovel!=.


***** reason4: fit better in specialized journals****
tab SNPSubmit gender if SNPSubmit!=9 & SNPSubmit==0
capture drop snpspclzd
generate snpspclzd=0
replace snpspclzd=1 if jscispclzd==1 | jnatspclzd==1 | jpnasspclzd==1
replace snpspclzd=. if jscispclzd==. & jnatspclzd==. & jpnasspclzd==.
replace snpspclzd=. if SNPSubmit!=0
summarize snpspclzd
tab snpspclzd gender
tab discipline_area snpspclzd if gender=="F"
tab discipline_area snpspclzd if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic snpspclzd i.female $control if rank>0 & snpspclzd!=.
logistic snpspclzd i.female $control0 if rank>0 & snpspclzd!=.

tab ncsaspclzd gender
capture drop ncsaspclzd
generate ncsaspclzd=0
replace ncsaspclzd=1 if jncspclzd==1 | jsaspclzd==1
replace ncsaspclzd=. if jncspclzd==. & jsaspclzd==.
replace ncsaspclzd=. if NCSASubmit!=0
tab ncsaspclzd gender
tab discipline_area ncsaspclzd if gender=="F"
tab discipline_area ncsaspclzd if gender=="M"
by discipline_area, sort : logistic ncsaspclzd i.female i.rank if rank>0 & ncsaspclzd!=.
logistic ncsaspclzd i.female $control0 if rank>0 & ncsaspclzd!=.


capture drop nejmcspclzd
generate nejmcspclzd=0 if NEJMCSubmit==0
replace nejmcspclzd=1 if jnejmspclzd==1 | jcellspclzd==1
replace nejmcspclzd=. if jnejmspclzd==. & jcellspclzd==.
replace nejmcspclzd=. if NEJMCSubmit!=0
tab nejmcspclzd gender
tab discipline_area nejmcspclzd if gender=="F"
tab discipline_area nejmcspclzd if gender=="M"
by discipline_area, sort : logistic nejmcspclzd i.female $control if rank>0 & nejmcspclzd!=.
logistic nejmcspclzd i.female $control0 if rank>0 & nejmcspclzd!=.

***** reason5: Work would reach a wider audience in another journal****
tab SNPSubmit gender if SNPSubmit!=9 & SNPSubmit==0
capture drop snpaudience
generate snpaudience=0
replace snpaudience=1 if jsciaudience==1 | jnataudience==1 | jpnasaudience==1
replace snpaudience=. if jsciaudience==. & jnataudience==. & jpnasaudience==.
replace snpaudience=. if SNPSubmit!=0
summarize snpaudience
tab snpaudience gender
tab discipline_area snpaudience if gender=="F"
tab discipline_area snpaudience if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic snpaudience i.female $control if rank>0 & snpaudience!=.
logistic snpaudience i.female $control0 if rank>0 & snpaudience!=.

tab ncsaaudience gender
capture drop ncsaaudience
generate ncsaaudience=0
replace ncsaaudience=1 if jncaudience==1 | jsaaudience==1
replace ncsaaudience=. if jncaudience==. & jsaaudience==.
replace ncsaaudience=. if NCSASubmit!=0
tab ncsaaudience gender
tab discipline_area ncsaaudience if gender=="F"
tab discipline_area ncsaaudience if gender=="M"
by discipline_area, sort : logistic ncsaaudience i.female $control if rank>0 & ncsaaudience!=.
logistic ncsaaudience i.female $control0 if rank>0 & ncsaaudience!=.


capture drop nejmcaudience
generate nejmcaudience=0 if NEJMCSubmit==0
replace nejmcaudience=1 if jnejmaudience==1 | jcellaudience==1
replace nejmcaudience=. if jnejmaudience==. & jcellaudience==.
replace nejmcaudience=. if NEJMCSubmit!=0
tab nejmcaudience gender
tab discipline_area nejmcaudience if gender=="F"
tab discipline_area nejmcaudience if gender=="M"
by discipline_area, sort : logistic nejmcaudience i.female $control if rank>0 & nejmcaudience!=.
logistic nejmcaudience i.female $control0 if rank>0 & nejmcaudience!=.


***** reason6: Co-authors wished to submit the manuscript elsewhere****

tab SNPSubmit gender if SNPSubmit!=9 & SNPSubmit==0
capture drop snpelsewhere
generate snpelsewhere=0
replace snpelsewhere=1 if jscielsewhere==1 | jnatelsewhere==1 | jpnaselsewhere==1
replace snpelsewhere=. if jscielsewhere==. & jnatelsewhere==. & jpnaselsewhere==.
replace snpelsewhere=. if SNPSubmit!=0
summarize snpelsewhere
tab snpelsewhere gender
tab discipline_area snpelsewhere if gender=="F"
tab discipline_area snpelsewhere if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic snpelsewhere i.female $control if rank>0 & snpelsewhere!=.
logistic snpelsewhere i.female $control0 if rank>0 & snpelsewhere!=.

tab ncsaelsewhere gender
capture drop ncsaelsewhere
generate ncsaelsewhere=0
replace ncsaelsewhere=1 if jncelsewhere==1 | jsaelsewhere==1
replace ncsaelsewhere=. if jncelsewhere==. & jsaelsewhere==.
replace ncsaelsewhere=. if NCSASubmit!=0
tab ncsaelsewhere gender
tab discipline_area ncsaelsewhere if gender=="F"
tab discipline_area ncsaelsewhere if gender=="M"
by discipline_area, sort : logistic ncsaelsewhere i.female $control if rank>0 & ncsaelsewhere!=.
logistic ncsaelsewhere i.female $control0 if rank>0 & ncsaelsewhere!=.

capture drop nejmcelsewhere
generate nejmcelsewhere=0 if NEJMCSubmit==0
replace nejmcelsewhere=1 if jnejmelsewhere==1 | jcellelsewhere==1
replace nejmcelsewhere=. if jnejmelsewhere==. & jcellelsewhere==.
replace nejmcelsewhere=. if NEJMCSubmit!=0
tab nejmcelsewhere gender
tab discipline_area nejmcelsewhere if gender=="F"
tab discipline_area nejmcelsewhere if gender=="M"
by discipline_area, sort : logistic nejmcelsewhere i.female $control if rank>0 & nejmcelsewhere!=.
logistic nejmcelsewhere i.female $control0 if rank>0 & nejmcelsewhere!=.



***** reason7: advised not to do so****
tab SNPSubmit gender if SNPSubmit!=9 & SNPSubmit==0
capture drop snpadvised
generate snpadvised=0
replace snpadvised=1 if jsciadvised==1 | jnatadvised==1 | jpnasadvised==1
replace snpadvised=. if jsciadvised==. & jnatadvised==. & jpnasadvised==.
replace snpadvised=. if SNPSubmit!=0
summarize snpadvised
tab snpadvised gender
tab discipline_area snpadvised if gender=="F"
tab discipline_area snpadvised if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic snpadvised i.female $control if rank>0 & snpadvised!=.
logistic snpadvised i.female $control0 if rank>0 & snpadvised!=.

tab ncsaadvised gender
capture drop ncsaadvised
generate ncsaadvised=0
replace ncsaadvised=1 if jncadvised==1 | jsaadvised==1
replace ncsaadvised=. if jncadvised==. & jsaadvised==.
replace ncsaadvised=. if NCSASubmit!=0
tab ncsaadvised gender
tab discipline_area ncsaadvised if gender=="F"
tab discipline_area ncsaadvised if gender=="M"
by discipline_area, sort : logistic ncsaadvised i.female $control if rank>0 & ncsaadvised!=.
logistic ncsaadvised i.female $control0 if rank>0 & ncsaadvised!=.


capture drop nejmcadvised
generate nejmcadvised=0 if NEJMCSubmit==0
replace nejmcadvised=1 if jnejmadvised==1 | jcelladvised==1
replace nejmcadvised=. if jnejmadvised==. & jcelladvised==.
replace nejmcadvised=. if NEJMCSubmit!=0
tab nejmcadvised gender
tab discipline_area nejmcadvised if gender=="F"
tab discipline_area nejmcadvised if gender=="M"
by discipline_area, sort : logistic nejmcadvised i.female $control if rank>0 & nejmcadvised!=.
logistic nejmcadvised i.female $control0 if rank>0 & nejmcadvised!=.


***** reason8: unaware of the journal****
**** not enough sample ***
tab SNPSubmit gender if SNPSubmit!=9 & SNPSubmit==0
capture drop snpunaware
generate snpunaware=0
replace snpunaware=1 if jsciunaware==1 | jnatunaware==1 | jpnasunaware==1
replace snpunaware=. if jsciunaware==. & jnatunaware==. & jpnasunaware==.
replace snpunaware=. if SNPSubmit!=0
summarize snpunaware
tab snpunaware gender
tab discipline_area snpunaware if gender=="F"
tab discipline_area snpunaware if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic snpunaware i.female $control if rank>0 & snpunaware!=.
logistic snpunaware i.female $control0 if rank>0 & snpunaware!=.

tab ncsaunaware gender
capture drop ncsaunaware
generate ncsaunaware=0
replace ncsaunaware=1 if jncunaware==1 | jsaunaware==1
replace ncsaunaware=. if jncunaware==. & jsaunaware==.
replace ncsaunaware=. if NCSASubmit!=0
tab ncsaunaware gender
tab discipline_area ncsaunaware if gender=="F"
tab discipline_area ncsaunaware if gender=="M"
by discipline_area, sort : logistic ncsaunaware i.female $control if rank>0 & ncsaunaware!=.
logistic ncsaunaware i.female $control0 if rank>0 & ncsaunaware!=.


capture drop nejmcunaware
generate nejmcunaware=0 if NEJMCSubmit==0
replace nejmcunaware=1 if jnejmunaware==1 | jcellunaware==1
replace nejmcunaware=. if jnejmunaware==. & jcellunaware==.
replace nejmcunaware=. if NEJMCSubmit!=0
tab nejmcunaware gender
tab discipline_area nejmcunaware if gender=="F"
tab discipline_area nejmcunaware if gender=="M"
by discipline_area, sort : logistic nejmcunaware i.female $control if rank>0 & nejmcunaware!=.
logistic nejmcunaware i.female $control0 if rank>0 & nejmcunaware!=.

***************************************For author's most highly cited paper *************************************************

**** Did you ever consider submitting your mostly highly cited manuscript to journals other than the currently one?****
tab discipline_area ymconsider if ymconsider!=9 & gender=="M"
by discipline_area, sort : logistic ymconsider i.female i.rank if ymconsider !=9 & ymconsider !=. & rank !=0
logistic ymconsider i.female i.rank i.discipline if ymconsider !=9 & ymconsider !=. & rank !=0

**** Did you ever consider submitting your mostly highly cited manuscript to Top journals? (SCI, NAT, PNAS, NC, SA, NEJM, CELL)****
summarize ymsciconsider ymnatconsider ympnasconsider ymncconsider ymsaconsider ymnejmconsider ymcellconsider
**did you consider submitting to SNP****
tab ymsnpconsider gender
capture drop ymsnpconsider 
generate ymsnpconsider=0
replace ymsnpconsider=1 if ymsciconsider==1| ymnatconsider==1|ympnasconsider==1
replace ymsnpconsider=. if ymsciconsider==. & ymnatconsider==. & ympnasconsider==.
replace ymsnpconsider=. if ymsciconsider==9 & ymnatconsider==9 & ympnasconsider==9
replace ymsnpconsider=. if ymsciconsider==9 & ymnatconsider==9 & ympnasconsider==.
replace ymsnpconsider=. if ymsciconsider==9 & ymnatconsider==. & ympnasconsider==.
replace ymsnpconsider=. if ymsciconsider==. & ymnatconsider==9 & ympnasconsider==9
replace ymsnpconsider=. if ymsciconsider==. & ymnatconsider==. & ympnasconsider==9
replace ymsnpconsider=. if ymsciconsider==9 & ymnatconsider==. & ympnasconsider==9
replace ymsnpconsider=. if ymsciconsider==9 & ymnatconsider==9 & ympnasconsider==.
tab ymsnpconsider gender
tab discipline_area ymsnpconsider if gender=="F"
tab discipline_area ymsnpconsider if gender=="M"
by discipline_area, sort : logistic ymsnpconsider i.female $control if ymsnpconsider !=9 & ymsnpconsider !=. & rank !=0
logistic ymsnpconsider i.female $control0 if ymsnpconsider !=9 & ymsnpconsider !=. & rank !=0

**did you consider submitting to NCSA?***
capture drop ymncsaconsider 
generate ymncsaconsider=0
replace ymncsaconsider=1 if ymncconsider==1| ymsaconsider==1
replace ymncsaconsider=. if ymsaconsider==. & ymsaconsider==. 
replace ymncsaconsider=. if ymsaconsider==9 & ymsaconsider==9 
replace ymncsaconsider=. if ymsaconsider==9 & ymsaconsider==. 
replace ymncsaconsider=. if ymsaconsider==. & ymsaconsider==0
tab ymncsaconsider gender
tab discipline_area ymncsaconsider if gender=="F"
tab discipline_area ymncsaconsider if gender=="M"
by discipline_area, sort : logistic ymncsaconsider i.female $control if ymncsaconsider !=9 & ymncsaconsider !=. & rank !=0
logistic ymncsaconsider i.female $control0 if ymncsaconsider !=9 & ymncsaconsider !=. & rank !=0


**did you consider submitting to NEJMCELL?***
tab ymnejmcconsider gender
capture drop ymnejmcconsider 
generate ymnejmcconsider=0
replace ymnejmcconsider=1 if ymnejmconsider==1| ymcellconsider==1
replace ymnejmcconsider=. if ymnejmconsider==. & ymcellconsider==. 
replace ymnejmcconsider=. if ymnejmconsider==9 & ymcellconsider==9 
replace ymnejmcconsider=. if ymnejmconsider==9 & ymcellconsider==. 
replace ymnejmcconsider=. if ymnejmconsider==. & ymcellconsider==9 
tab ymnejmcconsider gender
tab discipline_area ymnejmcconsider if gender=="F"
tab discipline_area ymnejmcconsider if gender=="M"
by discipline_area, sort : logistic ymnejmcconsider i.female $control if ymnejmcconsider !=9 & ymnejmcconsider !=. & rank !=0
logistic ymnejmcconsider i.female $control0 if ymnejmcconsider !=9 & ymnejmcconsider !=. & rank !=0


**********Highly cited paper submitted to SNP, NCSA, NEJMC**********
*submit to science nature and pnas
summarize ymscisubmit ymnatsubmit ympnassubmit
capture drop ymsnpsubmit
generate ymsnpsubmit=0
replace ymsnpsubmit=1 if ymscisubmit==1|ymnatsubmit==1|ympnassubmit==1
replace ymsnpsubmit=. if ymscisubmit==9 & ymnatsubmit==9 & ympnassubmit==9
replace ymsnpsubmit=. if ymscisubmit==. & ymnatsubmit==. & ympnassubmit==.
replace ymsnpsubmit=. if ymscisubmit==. & ymnatsubmit==9 & ympnassubmit==9
replace ymsnpsubmit=. if ymscisubmit==. & ymnatsubmit==. & ympnassubmit==9
replace ymsnpsubmit=. if ymscisubmit==9 & ymnatsubmit==. & ympnassubmit==.
replace ymsnpsubmit=. if ymscisubmit==9 & ymnatsubmit==9 & ympnassubmit==.
replace ymsnpsubmit=. if ymscisubmit==. & ymnatsubmit==9 & ympnassubmit==.
tabulate ymsnpsubmit female
tab discipline_area ymsnpsubmit if gender=="F"
tab discipline_area ymsnpsubmit if gender=="M"

by discipline_area, sort : logistic ymsnpsubmit i.female $control if ymsnpsubmit !=9 & rank !=0
by discipline_area, sort : logistic ymsnpsubmit i.female if ymsnpsubmit !=9 & rank !=0
logistic ymsnpsubmit i.female $control0 if ymsnpsubmit !=9 & rank !=0

*submitted to nature comms and science advances
tabulate ymncsasubmit female
capture drop ymncsasubmit
generate ymncsasubmit=0
replace ymncsasubmit=1 if ymncsubmit==1|ymsasubmit==1
replace ymncsasubmit=9 if ymncsubmit==9 & ymsasubmit==9
replace ymncsasubmit=9 if ymncsubmit==. & ymsasubmit==.
replace ymncsasubmit=9 if ymncsubmit==. & ymsasubmit==9
replace ymncsasubmit=9 if ymncsubmit==9 & ymsasubmit==.
tabulate ymncsasubmit female
tab discipline_area ymncsasubmit if gender=="F"
tab discipline_area ymncsasubmit if gender=="M"
by discipline_area, sort : logistic ymncsasubmit i.female $control if ymncsasubmit !=9& rank !=0
logistic ymncsasubmit i.female $control0 if ymncsasubmit !=9& rank !=0

*submitted to nejm and cell
tabulate ymnejmcsubmit female
capture drop ymnejmcsubmit
generate ymnejmcsubmit=0
replace ymnejmcsubmit=1 if ymnejmsubmit==1|ymcellsubmit==1
replace ymnejmcsubmit=. if ymnejmsubmit==9 & ymcellsubmit==9
replace ymnejmcsubmit=. if ymnejmsubmit==. & ymcellsubmit==.
replace ymnejmcsubmit=. if ymnejmsubmit==. & ymcellsubmit==9
replace ymnejmcsubmit=. if ymnejmsubmit==9 & ymcellsubmit==.
tabulate ymnejmcsubmit female
tab discipline_area ymnejmcsubmit if gender=="F"
tab discipline_area ymnejmcsubmit if gender=="M"
by discipline_area, sort : logistic ymnejmcsubmit i.female $control if ymnejmcsubmit !=9& rank !=0
logistic ymnejmcsubmit i.female $control0 if ymnejmcsubmit !=9& rank !=0


**********Highly cited paper submitted to SNP, NCSA, NEJMC and sent out for peer review**********

*Create new variables: submitted to top journals and sent out for peer review
*Q: Was your manuscript <Title of the respondent's most highly cited paper> sent out for peer-review before being rejected by the journals listed in the table below?


*submitted and sent out for peer review by SNP science nature and pnas
tabulate ymsnppeerreview female if discipline_area=="MS"
tabulate ymsnppeerreview gender
capture drop ymsnppeerreview
generate ymsnppeerreview=0
replace ymsnppeerreview=1 if ymscipeerreview==1|ymnatpeerreview==1|ympnaspeerreview==1
replace ymsnppeerreview=. if ymscipeerreview==9 & ymnatpeerreview==9 & ympnaspeerreview==9
replace ymsnppeerreview=. if ymscipeerreview==9 & ymnatpeerreview==. & ympnaspeerreview==.
replace ymsnppeerreview=. if ymscipeerreview==. & ymnatpeerreview==9 & ympnaspeerreview==.
replace ymsnppeerreview=. if ymscipeerreview==. & ymnatpeerreview==. & ympnaspeerreview==.9
replace ymsnppeerreview=. if ymscipeerreview==9 & ymnatpeerreview==9 & ympnaspeerreview==.
replace ymsnppeerreview=. if ymscipeerreview==. & ymnatpeerreview==9 & ympnaspeerreview==9
replace ymsnppeerreview=. if ymscipeerreview==9 & ymnatpeerreview==. & ympnaspeerreview==9
replace ymsnppeerreview=. if ymscipeerreview==. & ymnatpeerreview==. & ympnaspeerreview==.
tabulate ymsnppeerreview gender
tab discipline_area ymsnppeerreview if gender=="F"
tab discipline_area ymsnppeerreview if gender=="M"
by discipline_area, sort : logistic ymsnppeerreview i.female $control if ymsnppeerreview !=. & rank !=0 & ymsnpsubmit==1
logistic ymsnppeerreview i.female $control0 if ymsnppeerreview !=. & rank !=0 & ymsnpsubmit==1


*submitted and sent out for peer review in nature comm and science advances
tabulate ymncsapeerreview gender
capture drop ymncsapeerreview
generate ymncsapeerreview=0
replace ymncsapeerreview=1 if ymncpeerreview==1|ymsapeerreview==1
replace ymncsapeerreview=. if ymncpeerreview==9 & ymsapeerreview==9
replace ymncsapeerreview=. if ymncpeerreview==. & ymsapeerreview==.
replace ymncsapeerreview=. if ymncpeerreview==. & ymsapeerreview==9
replace ymncsapeerreview=. if ymncpeerreview==9 & ymsapeerreview==.
tabulate ymncsapeerreview gender
tab discipline_area ymncsapeerreview if gender=="F"
tab discipline_area ymncsapeerreview if gender=="M"
by discipline_area, sort : logistic ymncsapeerreview i.female $control if ymncsapeerreview !=. & rank !=0 & ymncsasubmit==1
logistic ymncsapeerreview i.female $control0 if ymncsapeerreview !=. & rank !=0 & ymncsasubmit==1



*submitted and sent out for peer review in nejm and cell
tabulate ymnejmcpeerreview gender
capture drop ymnejmcpeerreview
generate ymnejmcpeerreview=0
replace ymnejmcpeerreview=1 if ymnejmpeerreview==1|ymcellpeerreview==1
replace ymnejmcpeerreview=. if ymnejmpeerreview==9 & ymcellpeerreview==9
replace ymnejmcpeerreview=. if ymnejmpeerreview==. & ymcellpeerreview==.
replace ymnejmcpeerreview=. if ymnejmpeerreview==. & ymcellpeerreview==9
replace ymnejmcpeerreview=. if ymnejmpeerreview==9 & ymcellpeerreview==.
tabulate ymnejmcpeerreview gender
tab discipline_area ymnejmcpeerreview if gender=="F"
tab discipline_area ymnejmcpeerreview if gender=="M"
by discipline_area, sort : logistic ymnejmcpeerreview i.female $control if ymnejmcpeerreview !=. & rank !=0 & ymnejmcsubmit==1
logistic ymnejmcpeerreview i.female $control0 if ymnejmcpeerreview !=. & rank !=0 & ymnejmcsubmit==1


*************Reasons why you did not consider submitting your most highlly cited papers to SNP, NCSA, NEJMC*****************
*********Reason 1: not of high enough quality******
summarize ymsciquality ymnatquality ympnasquality ymncquality ymsaquality ymnejmquality ymcellquality
capture drop ymsnpquality
generate ymsnpquality=0
replace ymsnpquality=1 if ymsciquality==1 | ymnatquality==1 | ympnasquality==1
replace ymsnpquality=. if ymsciquality==. & ymnatquality==. & ympnasquality==.
replace ymsnpquality=. if ymsnpconsider!=0
tab ymsnpquality gender
tab discipline_area ymsnpquality if gender=="F"
tab discipline_area ymsnpquality if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymsnpquality i.female $control if rank>0 & ymsnpquality!=.
logistic ymsnpquality i.female $control0 if rank>0 & ymsnpquality!=.


tab ymncsaquality gender
capture drop ymncsaquality
generate ymncsaquality=0
replace ymncsaquality=1 if ymncquality==1 | ymsaquality==1 
replace ymncsaquality=. if ymncquality==. & ymsaquality==.
replace ymncsaquality=. if ymncsaconsider!=0
tab ymncsaquality gender
tab discipline_area ymncsaquality if gender=="F"
tab discipline_area ymncsaquality if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymncsaquality i.female $control if rank>0 & ymncsaquality!=.
logistic ymncsaquality i.female $control0 if rank>0 & ymncsaquality!=.


capture drop ymnejmcquality
generate ymnejmcquality=0
replace ymnejmcquality=1 if ymnejmquality==1 | ymcellquality==1
replace ymnejmcquality=. if ymnejmquality==9 & ymcellquality==9
replace ymnejmcquality=. if ymnejmquality==. & ymcellquality==.
replace ymnejmcquality=. if ymnejmcconsider!=0
tab ymnejmcquality gender
tab discipline_area ymnejmcquality if gender=="F"
tab discipline_area ymnejmcquality if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymnejmcquality i.female $control if rank>0 & ymnejmcquality!=.
logistic ymnejmcquality i.female $control0 if rank>0 & ymnejmcquality!=.



*********Reason 2: out of scope******
capture drop ymsnpscope
generate ymsnpscope=0
replace ymsnpscope=1 if ymsciscope==1 | ymnatscope==1 | ympnasscope==1
replace ymsnpscope=. if ymsciscope==. & ymnatscope==. & ympnasscope==.
replace ymsnpscope=. if ymsnpconsider!=0
tab ymsnpscope gender
tab discipline_area ymsnpscope if gender=="F"
tab discipline_area ymsnpscope if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymsnpscope i.female $control if rank>0 & ymsnpscope!=.
logistic ymsnpscope i.female $control0 if rank>0 & ymsnpscope!=.


tab ymncsascope gender
capture drop ymncsascope
generate ymncsascope=0
replace ymncsascope=1 if ymncscope==1 | ymsascope==1 
replace ymncsascope=. if ymncscope==. & ymsascope==.
replace ymncsascope=. if ymncsaconsider!=0
tab ymncsascope gender
tab discipline_area ymncsascope if gender=="F"
tab discipline_area ymncsascope if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymncsascope i.female $control if rank>0 & ymncsascope!=.
logistic ymncsascope i.female $control0 if rank>0 & ymncsascope!=.


capture drop ymnejmcscope
generate ymnejmcscope=0
replace ymnejmcscope=1 if ymnejmscope==1 | ymcellscope==1
replace ymnejmcscope=. if ymnejmscope==9 & ymcellscope==9
replace ymnejmcscope=. if ymnejmscope==. & ymcellscope==.
replace ymnejmcscope=. if ymnejmcconsider!=0
tab ymnejmcscope gender
tab discipline_area ymnejmcscope if gender=="F"
tab discipline_area ymnejmcscope if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymnejmcscope i.female $control if rank>0 & ymnejmcscope!=.
logistic ymnejmcscope i.female $control0 if rank>0 & ymnejmcscope!=.

*********Reason 3: not groundbreaking or sufficienty novel******
capture drop ymsnpnovel
generate ymsnpnovel=0
replace ymsnpnovel=1 if ymscinovel==1 | ymnatnovel==1 | ympnasnovel==1
replace ymsnpnovel=. if ymscinovel==. & ymnatnovel==. & ympnasnovel==.
replace ymsnpnovel=. if ymsnpconsider!=0
tab ymsnpnovel gender
tab discipline_area ymsnpnovel if gender=="F"
tab discipline_area ymsnpnovel if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymsnpnovel i.female $control if rank>0 & ymsnpnovel!=.
logistic ymsnpnovel i.female $control0 if rank>0 & ymsnpnovel!=.


tab ymncsanovel gender
capture drop ymncsanovel
generate ymncsanovel=0
replace ymncsanovel=1 if ymncnovel==1 | ymsanovel==1 
replace ymncsanovel=. if ymncnovel==. & ymsanovel==.
replace ymncsanovel=. if ymncsaconsider!=0
tab ymncsanovel gender
tab discipline_area ymncsanovel if gender=="F"
tab discipline_area ymncsanovel if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymncsanovel i.female $control if rank>0 & ymncsanovel!=.
logistic ymncsanovel i.female $control0 if rank>0 & ymncsanovel!=.


capture drop ymnejmcnovel
generate ymnejmcnovel=0
replace ymnejmcnovel=1 if ymnejmnovel==1 | ymcellnovel==1
replace ymnejmcnovel=. if ymnejmnovel==9 & ymcellnovel==9
replace ymnejmcnovel=. if ymnejmnovel==. & ymcellnovel==.
replace ymnejmcnovel=. if ymnejmcconsider!=0
tab ymnejmcnovel gender
tab discipline_area ymnejmcnovel if gender=="F"
tab discipline_area ymnejmcnovel if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymnejmcnovel i.female $control if rank>0 & ymnejmcnovel!=.
logistic ymnejmcnovel i.female $control0 if rank>0 & ymnejmcnovel!=.

***********************Reason 4： fit better in a specialized journal***********
capture drop ymsnpspclzd
generate ymsnpspclzd=0
replace ymsnpspclzd=1 if ymscispclzd==1 | ymnatspclzd==1 | ympnasspclzd==1
replace ymsnpspclzd=. if ymscispclzd==. & ymnatspclzd==. & ympnasspclzd==.
replace ymsnpspclzd=. if ymsnpconsider!=0
tab ymsnpspclzd gender
tab discipline_area ymsnpspclzd if gender=="F"
tab discipline_area ymsnpspclzd if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymsnpspclzd i.female $control if rank>0 & ymsnpspclzd!=.
logistic ymsnpspclzd i.female $control0 if rank>0 & ymsnpspclzd!=.


tab ymncsaspclzd gender
capture drop ymncsaspclzd
generate ymncsaspclzd=0
replace ymncsaspclzd=1 if ymncspclzd==1 | ymsaspclzd==1 
replace ymncsaspclzd=. if ymncspclzd==. & ymsaspclzd==.
replace ymncsaspclzd=. if ymncsaconsider!=0
tab ymncsaspclzd gender
tab discipline_area ymncsaspclzd if gender=="F"
tab discipline_area ymncsaspclzd if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymncsaspclzd i.female $control if rank>0 & ymncsaspclzd!=.
logistic ymncsaspclzd i.female $control0 if rank>0 & ymncsaspclzd!=.


capture drop ymnejmcspclzd
generate ymnejmcspclzd=0
replace ymnejmcspclzd=1 if ymnejmspclzd==1 | ymcellspclzd==1
replace ymnejmcspclzd=. if ymnejmspclzd==9 & ymcellspclzd==9
replace ymnejmcspclzd=. if ymnejmspclzd==. & ymcellspclzd==.
replace ymnejmcspclzd=. if ymnejmcconsider!=0
tab ymnejmcspclzd gender
tab discipline_area ymnejmcspclzd if gender=="F"
tab discipline_area ymnejmcspclzd if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymnejmcspclzd i.female $control if rank>0 & ymnejmcspclzd!=.
logistic ymnejmcspclzd i.female $control0 if rank>0 & ymnejmcspclzd!=.



**************Reason 5: wider audience ***************
capture drop ymsnpaudience
generate ymsnpaudience=0
replace ymsnpaudience=1 if ymsciaudience==1 | ymnataudience==1 | ympnasaudience==1
replace ymsnpaudience=. if ymsciaudience==. & ymnataudience==. & ympnasaudience==.
replace ymsnpaudience=. if ymsnpconsider!=0
tab ymsnpaudience gender
tab discipline_area ymsnpaudience if gender=="F"
tab discipline_area ymsnpaudience if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymsnpaudience i.female $control if rank>0 & ymsnpaudience!=.
logistic ymsnpaudience i.female $control0 if rank>0 & ymsnpaudience!=.


tab ymncsaaudience gender
capture drop ymncsaaudience
generate ymncsaaudience=0
replace ymncsaaudience=1 if ymncaudience==1 | ymsaaudience==1 
replace ymncsaaudience=. if ymncaudience==. & ymsaaudience==.
replace ymncsaaudience=. if ymncsaconsider!=0
tab ymncsaaudience gender
tab discipline_area ymncsaaudience if gender=="F"
tab discipline_area ymncsaaudience if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymncsaaudience i.female $control if rank>0 & ymncsaaudience!=.
logistic ymncsaaudience i.female $control0 if rank>0 & ymncsaaudience!=.


capture drop ymnejmcaudience
generate ymnejmcaudience=0
replace ymnejmcaudience=1 if ymnejmaudience==1 | ymcellaudience==1
replace ymnejmcaudience=. if ymnejmaudience==9 & ymcellaudience==9
replace ymnejmcaudience=. if ymnejmaudience==. & ymcellaudience==.
replace ymnejmcaudience=. if ymnejmcconsider!=0
tab ymnejmcaudience gender
tab discipline_area ymnejmcaudience if gender=="F"
tab discipline_area ymnejmcaudience if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymnejmcaudience i.female $control if rank>0 & ymnejmcaudience!=.
logistic ymnejmcaudience i.female $control0 if rank>0 & ymnejmcaudience!=.





*********************Reason 6: fits better elsewhere****
capture drop ymsnpelsewhere
generate ymsnpelsewhere=0
replace ymsnpelsewhere=1 if ymscielsewhere==1 | ymnatelsewhere==1 | ympnaselsewhere==1
replace ymsnpelsewhere=. if ymscielsewhere==. & ymnatelsewhere==. & ympnaselsewhere==.
replace ymsnpelsewhere=. if ymsnpconsider!=0
tab ymsnpelsewhere gender
tab discipline_area ymsnpelsewhere if gender=="F"
tab discipline_area ymsnpelsewhere if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymsnpelsewhere i.female $control if rank>0 & ymsnpelsewhere!=.
logistic ymsnpelsewhere i.female $control0 if rank>0 & ymsnpelsewhere!=.


tab ymncsaelsewhere gender
capture drop ymncsaelsewhere
generate ymncsaelsewhere=0
replace ymncsaelsewhere=1 if ymncelsewhere==1 | ymsaelsewhere==1 
replace ymncsaelsewhere=. if ymncelsewhere==. & ymsaelsewhere==.
replace ymncsaelsewhere=. if ymncsaconsider!=0
tab ymncsaelsewhere gender
tab discipline_area ymncsaelsewhere if gender=="F"
tab discipline_area ymncsaelsewhere if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymncsaelsewhere i.female $control if rank>0 & ymncsaelsewhere!=.
logistic ymncsaelsewhere i.female $control0 if rank>0 & ymncsaelsewhere!=.


capture drop ymnejmcelsewhere
generate ymnejmcelsewhere=0
replace ymnejmcelsewhere=1 if ymnejmelsewhere==1 | ymcellelsewhere==1
replace ymnejmcelsewhere=. if ymnejmelsewhere==9 & ymcellelsewhere==9
replace ymnejmcelsewhere=. if ymnejmelsewhere==. & ymcellelsewhere==.
replace ymnejmcelsewhere=. if ymnejmcconsider!=0
tab ymnejmcelsewhere gender
tab discipline_area ymnejmcelsewhere if gender=="F"
tab discipline_area ymnejmcelsewhere if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymnejmcelsewhere i.female $control if rank>0 & ymnejmcelsewhere!=.
logistic ymnejmcelsewhere i.female $control0 if rank>0 & ymnejmcelsewhere!=.



*****************Reason 7: advised not to do so***************
capture drop ymsnpadvise
generate ymsnpadvise=0
replace ymsnpadvise=1 if ymsciadvise==1 | ymnatadvise==1 | ympnasadvise==1
replace ymsnpadvise=. if ymsciadvise==. & ymnatadvise==. & ympnasadvise==.
replace ymsnpadvise=. if ymsnpconsider!=0
tab ymsnpadvise gender
tab discipline_area ymsnpadvise if gender=="F"
tab discipline_area ymsnpadvise if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymsnpadvise i.female $control if rank>0 & ymsnpadvise!=.
logistic ymsnpadvise i.female $control0 if rank>0 & ymsnpadvise!=.


tab ymncsaadvise gender
capture drop ymncsaadvise
generate ymncsaadvise=0
replace ymncsaadvise=1 if ymncadvise==1 | ymsaadvise==1 
replace ymncsaadvise=. if ymncadvise==. & ymsaadvise==.
replace ymncsaadvise=. if ymncsaconsider!=0
tab ymncsaadvise gender
tab discipline_area ymncsaadvise if gender=="F"
tab discipline_area ymncsaadvise if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymncsaadvise i.female $control if rank>0 & ymncsaadvise!=.
logistic ymncsaadvise i.female $control0 if rank>0 & ymncsaadvise!=.


capture drop ymnejmcadvise
generate ymnejmcadvise=0
replace ymnejmcadvise=1 if ymnejmadvise==1 | ymcelladvise==1
replace ymnejmcadvise=. if ymnejmadvise==9 & ymcelladvise==9
replace ymnejmcadvise=. if ymnejmadvise==. & ymcelladvise==.
replace ymnejmcadvise=. if ymnejmcconsider!=0
tab ymnejmcadvise gender
tab discipline_area ymnejmcadvise if gender=="F"
tab discipline_area ymnejmcadvise if gender=="M"
**Logistic regression analysis on whether gender is related to NCSASubmit
**only those junior, senior and non-acadmic are considered
by discipline_area, sort : logistic ymnejmcadvise i.female $control if rank>0 & ymnejmcadvise!=.
logistic ymnejmcadvise i.female $control0 if rank>0 & ymnejmcadvise!=.


***************Q: COMPARED to my peers, I feel that the quality of my research is.*******
*** 1-5, Poor - excellent 
tab research gender
by discipline_area gender, sort: summarize research if research!=9 & research!=. & rank!=3
by discipline_area gender, sort: summarize research if research==4 | research==5 & rank!=3
by gender, sort: summarize research if research!=9 & research!=.& rank!=3
by gender, sort: summarize research if research==3

by gender, sort: tab discipline_area research if research!=9 & rank!=0 & rank!=3

*****ordinal logistic regression 
by discipline_area, sort : ologit research i.female $control if rank>0 & research!=9 & rank!=3, or
ologit research i.female $control0 if rank>0 & research!=9 & rank!=3, or
by discipline_area, sort : regress research i.female $control if rank>0 & research!=9 & rank!=3, or

by discipline_area, sort : ologit research i.female $control if rank!=0 & research!=9 & rank!=3, or
by discipline, sort : ologit research i.female $control if rank!=0 & research!=9&rank!=3, or





