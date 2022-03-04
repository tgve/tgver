## Test environments
* local R installation, R 4.1.2
* win, linux and mac (on github-actions), various R
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 0 note

* This is a new release.

## First submission addressed
25-02-2022

* Changed license entry line to MIT + file LICENSE in DESCRIPTION
* Added trailing slash to the URL in the code

Check:
0 errors v | 0 warnings v | 0 notes v

## Second submission checks addressed
3rd March 2022

* All exported functions have now got \value in their `.Rd`s.
* No commented code in examples
* Removed dontrun and found examples that can run and should not be longer than < 5 secs
* instead of TGVE in LICENSE now states tgver authors which are all listed in the Authors@R object.

Check:
0 errors v | 0 warnings v | 0 notes v
