# NETS Data Curation

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.22018941.svg)](https://doi.org/10.5281/zenodo.22018941)

Stata template code for generating neighborhood-level business counts from the
National Establishment Time Series (NETS) database,
by SIC industry category and geography (census tract or ZCTA).

This code supports data curation work for the
[National Neighborhood Data Archive (NaNDA)](https://nanda.isr.umich.edu/).

## About the NETS database

The National Establishment Time Series (NETS) is a proprietary longitudinal
database of United States business establishments, produced by Walls &
Associates from archival Dun & Bradstreet (D&B) establishment data. It
provides annual records on establishment location, industry (SIC
classification), and employment from 1990 onward; the vintage used for NaNDA
datasets runs through 2022.

NETS is licensed commercially and has **no public website**. The canonical
technical reference is Walls (2007), [National Establishment Time-Series
Database: Data Overview](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1022962)
(SSRN); an independent assessment is Barnatchez, Crane & Decker (2017),
[An Assessment of the NETS Database](https://www.federalreserve.gov/econres/feds/files/2017110pap.pdf)
(Federal Reserve FEDS working paper). Access inquiries go to Walls &
Associates directly; there is no self-service portal.

## What the template does

`run_make_TEMPLATE_sic4_sic6_sic8_category_GEO_counts_vDATE.do` is a driver
script. For each user-defined business category (a named set of 8-digit SIC
codes), it calls a subroutine that builds establishment counts per geographic
unit per year, then merges all category files into a single combined dataset
with one row per geography-year.

**Note:** The subroutine it calls
(`make_NETS_sic4_sic6_sic8_category_[GEO]_counts_sub.do`) and the NETS source
data are **not** included in this repository. NETS is a licensed, proprietary
database; you must have your own access to the data and the accompanying
subroutine for this driver to run.

## Usage

1. Copy the template and rename it following the pattern
   `run_make_[CATGROUP]_sic4_sic6_sic8_category_[GEO]_counts_v[DATE].do`.
2. Fill in the CONFIG block:

   | Local         | What goes there                                        |
   |---------------|--------------------------------------------------------|
   | `versiondate` | Run date, `YYYYMMDD`                                   |
   | `geo`         | Geography: `tract10`, `tract20`, `zcta10`, or `zcta20` |
   | `geoid`       | Matching ID variable, e.g. `tract_fips10`              |
   | `catgroup`    | Short name for the category group (used in filenames)  |
   | `script_dir`  | Directory containing your .do files                    |
   | `outdir`      | Directory for combined count output                    |

3. Duplicate the category block once per business category, setting `myname`
   (variable suffix), `mylabel` (human-readable label), and `sic8s`
   (space-separated 8-digit SIC codes).
4. Run the script. Logs are written to `script_dir`; the merged dataset is
   saved to `outdir`.

### Label escaping

Category labels are passed as arguments to a subroutine, so commas and
parentheses will break parsing. Use the placeholders documented in the
template header: `(comma)`, `(and)`, `(lp)`, and `(rp)`.

## Requirements

- Stata
- The `fsum` package (`ssc install fsum`)
- Licensed access to NETS data and the counts subroutine

## Attribution

Based on a template by Philippa Clarke (pjclarke); adapted and maintained by
Will Clary.


## NaNDA datasets built from NETS

The following published NaNDA datasets are derived from NETS. Each provides
counts and densities of the named establishment type per census tract and/or
ZCTA per year. Full titles follow the pattern "National Neighborhood Data
Archive (NaNDA): [name], United States".

| Dataset | DOI | Description |
|---|---|---|
| Arts, Entertainment, and Leisure Establishments, 1990-2022 | [10.3886/E209163](https://doi.org/10.3886/E209163) | Theaters, museums, galleries, amusement venues, and similar establishments |
| Civic, Social, and Religious Organizations, 1990-2022 | [10.3886/E207966](https://doi.org/10.3886/E207966) | Churches, mosques, synagogues, veterans/youth organizations, and civic groups |
| Dollar Stores, 1990-2022 | [10.3886/E209324](https://doi.org/10.3886/E209324) | Dollar and variety stores |
| Eating and Drinking Places, 1990-2022 | [10.3886/E208751](https://doi.org/10.3886/E208751) | Restaurants, bars, coffee shops, and fast food |
| Education and Training Services by Census Tract, 2003-2017 | [10.3886/E127681](https://doi.org/10.3886/E127681) | Schools, colleges, and specialized instruction services (earlier series) |
| Education and Training Services by ZCTA, 2003-2017 | [10.3886/E127682](https://doi.org/10.3886/E127682) | Schools, colleges, and specialized instruction services (earlier series) |
| Essential Businesses, 2020 | [10.3886/ICPSR301419.v1](https://doi.org/10.3886/ICPSR301419.v1) | Businesses and employees deemed essential under CISA COVID-19 guidance |
| Grocery and Food Stores, 1990-2022 | [10.3886/E209313](https://doi.org/10.3886/E209313) | Grocery stores, supermarkets, and specialty food stores |
| Healthcare Services, 1990-2022 | [10.3886/E209050](https://doi.org/10.3886/E209050) | Physician offices, dentists, clinics, and other health care establishments |
| Law Enforcement, 1990-2022 | [10.3886/E208684](https://doi.org/10.3886/E208684) | Police and other law enforcement establishments |
| Liquor, Tobacco, Cannabis, Vape, and Convenience Stores, 1990-2022 | [10.3886/E208907](https://doi.org/10.3886/E208907) | Outlets selling age-restricted products and convenience goods |
| Ophthalmologists, 1990-2021 | [10.3886/E222263](https://doi.org/10.3886/E222263) | Ophthalmology practices |
| Personal Care Services and Laundry, 1990-2022 | [10.3886/E208906](https://doi.org/10.3886/E208906) | Salons, barbers, laundromats, and dry cleaners |
| Post Offices and Banks, 1990-2021 | [10.3886/E208366](https://doi.org/10.3886/E208366) | Post offices and bank branches |
| Recreational Establishments, 1990-2022 | [10.3886/E209164](https://doi.org/10.3886/E209164) | Gyms, sports facilities, and other recreation venues |
| Retail Establishments, 1990-2022 | [10.3886/E208682](https://doi.org/10.3886/E208682) | Retail stores across major categories |
| Social Services, 1990-2022 | [10.3886/E208207](https://doi.org/10.3886/E208207) | Community centers, child/youth/elder services, day care, and counseling services |
| Training and Vocation Schools, 1990-2022 | [10.3886/ICPSR302343.v1](https://doi.org/10.3886/ICPSR302343.v1) | Vocational and trade schools and training establishments |

## Citation

Archived on Zenodo. Cite all versions with the concept DOI
[10.5281/zenodo.22018941](https://doi.org/10.5281/zenodo.22018941), or a
specific release by its version DOI (v1.0.0:
[10.5281/zenodo.22018942](https://doi.org/10.5281/zenodo.22018942)). See
CITATION.cff for the citation format.

## License

Code in this repository is released under the [MIT License](LICENSE). This
license covers the code only — it does not grant any rights to NETS data.
