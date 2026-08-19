# NETS Data Curation

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.22018941.svg)](https://doi.org/10.5281/zenodo.22018941)

Stata template code for generating neighborhood-level business counts from the
[National Establishment Time Series (NETS)](https://youreconomy.org/nets/) database,
by SIC industry category and geography (census tract or ZCTA).

This code supports data curation work for the
[National Neighborhood Data Archive (NaNDA)](https://nanda.isr.umich.edu/).

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

## Citation

Archived on Zenodo. Cite all versions with the concept DOI
[10.5281/zenodo.22018941](https://doi.org/10.5281/zenodo.22018941), or a
specific release by its version DOI (v1.0.0:
[10.5281/zenodo.22018942](https://doi.org/10.5281/zenodo.22018942)). See
CITATION.cff for the citation format.

## License

Code in this repository is released under the [MIT License](LICENSE). This
license covers the code only — it does not grant any rights to NETS data.
