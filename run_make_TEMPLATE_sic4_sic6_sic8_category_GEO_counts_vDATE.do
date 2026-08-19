/*******************************************************************************
* NETS SCRIPT TEMPLATE
* Based on pjclarke postofficesbanks template
*
* CONFIG VARIABLES REQUIRING UPDATE:
*   versiondate  - Format YYYYMMDD
*   geo          - Geography: tract10, tract20, zcta10, zcta20
*   geoid        - ID variable: tract_fips10, tract_fips20, zcta10, zcta20
*   catgroup     - Category group name for filenames
*   script_dir   - Path to your .do files
*   outdir       - Path for combined count output files
*
* CATEGORY BLOCKS REQUIRING UPDATE:
*   myname       - Variable suffix (short, no spaces)
*   mylabel      - Human-readable label
*   sic8s        - Space-separated SIC codes
*
* SAVE AS: run_make_[CATGROUP]_sic4_sic6_sic8_category_[GEO]_counts_v[DATE].do
*******************************************************************************/

* === CONFIG - CHECK VALUES ===
local versiondate "YYYYMMDD"
local geo "tract10"
local geoid "tract_fips10"
local catgroup "YOURCATGROUP"
local script_dir "PATH/TO/YOUR/SCRIPTS/"
local outdir "PATH/TO/YOUR/OUTPUT/`geo'/"


capture log close
log using "`script_dir'run_make_`catgroup'_sic4_sic6_sic8_category_`geo'_counts_v`versiondate'.log", replace

/*******************************************************************************
* === CATEGORY BLOCKS - UPDATE VALUES ===
* Copy block below for each category, update myname, mylabel, sic8s
*
*
* LABEL ESCAPING:
* Labels with special characters will cause parsing errors. Use these placeholders:
*   (comma)  →  replaced with ,
*   (and)    →  replaced with and
*   (lp)     →  replaced with (
*   (rp)     →  replaced with )
*
* Examples:
*   WRONG:  local mylabel "Instruction schools, camps, and services"
*   RIGHT:  local mylabel "Instruction schools (comma) camps (comma) (and) services"
*
*   WRONG:  local mylabel "Nursing facilities (eg, nursing home)"
*   RIGHT:  local mylabel "Nursing facilities (lp)eg (comma) nursing home(rp)"
*
* Labels with "and" but NO commas or parentheses do not need escaping.
*******************************************************************************/

* --- CATEGORY 1 ---
local myname "SUFFIX1"
local mylabel "Label 1"
local sic8s "00000000"
do "`script_dir'make_NETS_sic4_sic6_sic8_category_`geo'_counts_sub.do" `myname' `" `mylabel' "' `" `sic8s' "'
local mynames "`mynames' `myname'"
local allsic8s "`allsic8s' `sic8s'"

* --- CATEGORY 2 ---
local myname "SUFFIX2"
local mylabel "Label 2"
local sic8s "00000000"
do "`script_dir'make_NETS_sic4_sic6_sic8_category_`geo'_counts_sub.do" `myname' `" `mylabel' "' `" `sic8s' "'
local mynames "`mynames' `myname'"
local allsic8s "`allsic8s' `sic8s'"

* --- ADD MORE CATEGORIES AS NEEDED ---


* === MERGE OUTPUT - NO CHANGES BELOW ===

capture log close
log using "`script_dir'make_`geo'_`catgroup'_subset_v`versiondate'.log", replace

local outfile "`outdir'`geo'_`catgroup'_subset_`versiondate'"

local loop_no = 1
foreach myname of local mynames {
	local myfile "`outdir'combine_`myname'_`geo'_subset"
	if `loop_no' == 1 {
		use "`myfile'", clear
	}
	else {
		merge 1:1 `geoid' year using "`myfile'", keep(match master) nogen
	}
	local loop_no = `loop_no' + 1
}

label var year "Year"
fsum, format(20.4) label
codebook, notes
save "`outfile'", replace

capture log close
