# clang-builder
Builds a speedy clang++ on RHEL 7

clang++ was very slow on our servers - something to do with searching lots of places for library files. 

this script builds a fresh version, which compiles code speedily on RHEL 7. Note this is no longer an issue with RHEL 8, so this script is deprecated, but still might be useful to someone on an older version of RHEL. 

update the relevant variables at the top of build_clang.sh, and run!
