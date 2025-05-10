import delimited "/Users/maggiewang/Downloads/voter_rationality_values_decfifteen.csv", rowrange(251) colrange(19) 

**coding of data**

replace q18_13 = q18_13 - 1
replace q18_12 = q18_12 - 1
replace q18_1 = q18_1 - 1

replace q19 = -1 if (q19 == 2)
replace q19 = 0 if (q19 == 3)
replace q19 = . if (q19 >= 4)

replace q20 = -1 if (q20 == 2)
replace q20 = 0 if (q20 == 3)
replace q20 = . if (q20 >= 4)

replace q21 = 0 if (q21 == 3)
replace q21 = -1 if (q21 == 2)
replace q21 = . if (q21 >= 4)

replace q23 = 0 if (q23 == 3)
replace q23 = -1 if (q23 == 2)
replace q23 = . if (q23 >= 4)

replace q24 = -1 if (q24 == 1)
replace q24 = 1 if (q24 == 2)
replace q24 = 0 if (q24 > 2 & q24 < 5)
replace q24 = . if (q24 == 5)

/*replace q25 = 0 if (q25 == 1)
replace q25 = 1 if (q25 == 2)
replace q25 = 0.25 if (q25 == 3)
replace q25 = 0.75 if (q25 == 4)
replace q25 = 0 if (q25 == 5 | q25 == 6)
replace q25 = . if (q25 > 6)*/

replace q25 = -1 if (q25 == 1)
replace q25 = 1 if (q25 == 2)
replace q25 = -0.5 if (q25 == 3)
replace q25 = 0.5 if (q25 == 4)
replace q25 = 0 if (q25 == 5 | q25 == 6)
replace q25 = . if (q25 > 6)

replace q25 = 1 if (q25_7_text == "已經獨立 不需宣布")

replace q26 = 0.5 if (q26 == 2)
replace q26 = 0 if (q26 == 3)
replace q26 = -0.5 if (q26 == 4)
replace q26 = -1 if (q26 == 5)
replace q26 = . if (q26 >= 6)

replace q27 = -1 if (q27 == 1)
replace q27 = 1 if (q27 == 2)
replace q27 = 0 if (q27 >=3 & q27 <= 6)
replace q27 = . if (q27 == 7)

replace q28 = 0.667 if (q28 == 2)
replace q28 = 0.333 if (q28 == 3)
replace q28 = 0 if (q28 >= 4)

/*replace q29 = 0.5 if (q29 == 2)
replace q29 = 0 if (q29 == 3)
replace q29 = . if (q29 == 4)
replace q29 = 0.75 if (q30 == 1)
replace q29 = 0.25 if (q30 == 2)*/

replace q29 = 0 if (q29 == 2)
replace q29 = -1 if (q29 == 3)
replace q29 = . if (q29 == 4)
replace q29 = 0.5 if (q30 == 1)
replace q29 = -0.5 if (q30 == 2)

replace q32 = 0.75 if (q32 == 2)
replace q32 = -0.5 if (q32 == 3)
replace q32 = -1 if (q32 == 4)
replace q32 = . if (q32 == 5)

/*replace q32 = 2 if (q32 == 1)
replace q32 = 1 if (q32 == 2)
replace q32 = 0 if (q32 == 3 | q32 == 4)
replace q32 = . if (q32 == 5)*/

replace q34 = q34_1_text
drop if missing(q34)
replace q34 = q34+1900 if (q34 < 100)

replace v60 = 1 if (v60 == 1 | v60 == 2)
replace v60 = 0 if (v60 == 4)
replace v60 = -1 if (v60 == 3)
replace v60 = . if (v60 == 5)

replace v61 = 1 if (v61 == 1 | v61 == 2)
replace v61 = 0 if (v61 == 4)
replace v61 = -1 if (v61 == 3)
replace v61 = . if (v61 == 5)

gen age = 2024-q34

gen pre1980 = 1 if (q34 < 1980)
replace pre1980 = 0 if (pre1980 == .)
gen post1980 = 1 if (q34 >= 1980)
replace post1980 = 0 if (post1980 == .)

replace q37 = 0 if (q37 == 4)
drop if q37 == 6

**generate labels**
lab var q5 "likelihood of vote candidate 1"
lab var q9 "likelihood of vote candidate 2"
lab var q8 "likelihood of vote candidate 3"
lab var q12 "likelihood of vote candidate 4"

lab var q10 "v1 candidate selection"
lab var q13 "v2 candidate selection"

rename q25 IU_issue

rename q18_12 qualifications

rename q18_1 econ_issue

rename q24 cons92

rename q18_13 similarity

rename q33 education

rename v65 income

rename q36_1 soc_class

rename q37 gender

**generate variables**
gen id = _n

//voting choice
gen vchoice = q13
replace vchoice = 3 if (vchoice == 1)
replace vchoice = 4 if (vchoice == 2)
replace vchoice = q10 if missing(vchoice)

gen votec1 = 1 if (q10 == 1) 
replace votec1 = 0 if (votec1 == .) 
gen votec2 = 1 if (q10 == 2) 
replace votec2 = 0 if (votec2 == .) 
gen votec3 = 1 if (q13 == 1) 
replace votec3 = 0 if (votec3 == .) 
gen votec4 = 1 if (q13 == 2) 
replace votec4 = 0 if (votec4 == .)

//voting intention
egen confvote = rowmean(q11 q14 q15)

gen vi1 = confvote * q5
gen vi2 = confvote * q9
gen vi3 = confvote * q8
gen vi4 = confvote * q12

gen v1_3 = vi1 
replace v1_3 = vi3 if missing(v1_3)

gen v2_4 = vi2
replace v2_4 = vi4 if missing(v2_4)

//IU issue stance x salience
gen IU = IU_issue * cons92

//economic context
egen econcontx = rowmean(q19 q20)

//personal economic context
egen p_econcontx = rowmean(q21 q23)

//party identification
gen party_id = q27 * q28 

//national identity
gen nationalism = q29 * q32 * q18_11

//ethnic identity
egen ethnic = rowmean(v60 v61)


//model?
/*
drop if missing(post1980) | missing(qualifications) | missing(nationalism) | missing(vchoice) | missing(nationalism) | missing(party_id)| missing(p_econcontx) | missing(IU)| missing(econ_issue)*/

//gsem regression	 
/*gsem (post1980 -> econcontx education income gender soc_class, family(gaussian)) ///
	 (post1980 -> party_id education income gender soc_class, family(gaussian)) ///
	 (post1980 -> similarity education income gender soc_class, family(gaussian)) ///
	 (post1980 -> nationalism education income gender soc_class, family(gaussian)) ///
	 (econcontx -> econ_issue education income gender soc_class, family(gaussian)) ///
	 (nationalism -> econ_issue education income gender soc_class, family(gaussian)) ///
     (party_id -> votec1 education income gender soc_class, family(binomial)) ///
	 (party_id -> votec2 education income gender soc_class, family(binomial)) ///
	 (party_id -> votec3 education income gender soc_class, family(binomial)) ///
	 (party_id -> votec4 education income gender soc_class, family(binomial)) ///
	 (party_id -> IU education income gender soc_class, family(binomial)) ///
     (IU -> votec2 education income gender soc_class, family(binomial)) ///
     (IU -> votec3 education income gender soc_class, family(binomial)) ///
	 (similarity -> votec1 education income gender soc_class, family(binomial)) ///
	 (similarity -> votec4 education income gender soc_class, family(binomial)) ///
     (econ_issue -> votec2 education income gender soc_class, family(binomial)) ///
     (econ_issue -> votec3 education income gender soc_class, family(binomial)), ///
     nocapslatent*/

gsem (post1980 -> nationalism education income gender soc_class, family(gaussian) link(identity)) ///
	 (post1980 -> party_id education income gender soc_class, family(gaussian) link(identity)) ///
	 (post1980 -> econcontx education income gender soc_class, family(gaussian) link(identity)) ///
	 (post1980 -> similarity education income gender soc_class, family(gaussian) link(identity)) ///
	 (nationalism -> IU_issue education income gender soc_class, family(gaussian) link(identity)) ///
	 (nationalism -> econ_issue education income gender soc_class, family(gaussian) link(identity)) ///
	 (party_id -> IU_issue education income gender soc_class, family(gaussian) link(identity)) ///
	 (party_id -> votec1 education income gender soc_class, family(binomial) link(logit)) ///
	 (party_id -> votec2 education income gender soc_class, family(binomial) link(logit)) ///
	 (party_id -> votec3 education income gender soc_class, family(binomial) link(logit)) ///
	 (party_id -> votec4 education income gender soc_class, family(binomial) link(logit)) ///
	 (econcontx -> econ_issue education income gender soc_class, family(gaussian) link(identity)) ///
	 (similarity -> votec1 education income gender soc_class, family(binomial) link(logit)) ///
	 (similarity -> votec4 education income gender soc_class, family(binomial) link(logit)) ///
	 (IU_issue -> votec2 education income gender soc_class, family(binomial) link(logit)) ///
	 (IU_issue -> votec3 education income gender soc_class, family(binomial) link(logit)) ///
	 (econ_issue -> votec2 education income gender soc_class, family(binomial) link(logit)) ///
	 (econ_issue -> votec3 education income gender soc_class, family(binomial) link(logit)), ///
	 cov( e.party_id*e.nationalism) nocapslatent

	 
//direct, indirect effects
nlcom (_b[party_id:post1980] * _b[votec1:party_id])
nlcom (_b[party_id:post1980] * _b[votec2:party_id])
nlcom (_b[party_id:post1980] * _b[votec3:party_id])
nlcom (_b[party_id:post1980] * _b[votec4:party_id])
nlcom (_b[party_id:post1980] * _b[IU_issue:party_id] * _b[votec2:IU_issue])
nlcom (_b[party_id:post1980] * _b[IU_issue:party_id] * _b[votec3:IU_issue])
nlcom (_b[nationalism:post1980] * _b[IU_issue:nationalism] * _b[votec3:IU_issue])
nlcom (_b[nationalism:post1980] * _b[IU_issue:nationalism] * _b[votec2:IU_issue])
nlcom (_b[nationalism:post1980] * _b[econ_issue:nationalism] * _b[votec2:econ_issue])
nlcom (_b[nationalism:post1980] * _b[econ_issue:nationalism] * _b[votec3:econ_issue])
nlcom (_b[econcontx:post1980] * _b[econ_issue:econcontx] * _b[votec2:econ_issue])
nlcom (_b[econcontx:post1980] * _b[econ_issue:econcontx] * _b[votec3:econ_issue])
nlcom (_b[similarity:post1980] * _b[votec1:similarity])
nlcom (_b[similarity:post1980] * _b[votec4:similarity])







