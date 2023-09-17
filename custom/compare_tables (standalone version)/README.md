![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_uc_compare_tables.sas

### Custom

##### Custom macro to determine the differences between two datasets.

***

### Description
The macro compares two tables or SAS datasets, the base dataset TABLE1 and the comparison dataset TABLE2. The macro procedure determines both matching variables and records or observations. Matching variables are those having the same name and type. Matching observations are those having identical values for all specified IDCOLS variables or if IDCOLS parameter is not set, those columns that occur in the same position in the datasets. If matched observations by IDCOLS variables is set, then both SAS datasets or tables must be sorted by all IDCOLS variables.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-04-11 00:00:00

### Version
* 21.1.04

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | table1 | Full LIBNAME.TABLENAME name of the input base table. The default value for TABLE1 is: \_NONE\_. |
| Input | where1 | Optional. Specifies a valid WHERE clause that selects observations from the TABLE1 SAS dataset. Using this argument subsets your data based on the criteria that you supply for the expression. |
| Input | base | Alias of the TABLE1= parameter. |
| Input | table2 | Full LIBNAME.TABLENAME name of the comparison table. The default value for TABLE2 is: \_NONE\_. |
| Input | where2 | Optional. Specifies a valid WHERE clause that selects observations from the TABLE2 SAS dataset. Using this argument subsets your data based on the criteria that you supply for the expression. |
| Input | comp | Alias of the TABLE2= parameter. |
| Input | outtbl | Full LIBNAME.TABLENAME name of the output diff table. The default value for OUTTBL is: \_NONE\_. |
| Input | diff | Alias of the OUTTBL= parameter. |
| Input | idcols | A blank separated list of column names to be used to match observations between the base and comparison tables. If no id columns are given, both base and compare tables must have identical record entries (only column values are checked for differences). |
| Input | exclude | Optional. A blank separated list of columns to be excluded from the table comparison routine. |
| Input | stats | Boolean [Y/N] parameter to specify if an output table containing the comparison statistics is to be created. The default value is: N. |
| Input | nodups | Boolean [Y/N] parameter to specify if duplicate observations are ignored from the comparison. The default value for NODUPS is: Y. |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Table comparison summary table.

### Calls
* None

### Usage

##### Example 1: Show help information:
```sas
%m_uc_compare_tables(?)
```

##### Example 2: Step 1 - Create a new comparison table WORK.class:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John'
      then Sex = 'F';
   if name eq 'Janet' then do;
      Height = 57.3;
      Weight = 99;
   end;
   if _n_ lt 18 then do;
      output;
      if name eq 'Henry' then do;
         name = 'Paul';
         output;
      end;
      if name eq 'Philip' then do;
         output;
      end;
   end;
run;
```

##### Example 2: Step 2 - Compare SASHELP.class against WORK.class:
```sas
%m_uc_compare_tables(
   base   = SASHELP.class (drop=Height)
 , comp   = WORK.class (drop=Height)
 , idcols = Name Age
 , stats  = N
 , print  = Y
 , debug  = Y
   );
```

##### Example 3: Compare SASHELP.class against SASHELP.classfit:
```sas
%m_uc_compare_tables(
   base   = SASHELP.class
 , comp   = SASHELP.classfit
 , diff   = WORK.diff
 , print  = Y
 , debug  = N
   );
```

##### Example 4: Compare SASHELP.classfit against SASHELP.class:
```sas
%m_uc_compare_tables(
   base   = SASHELP.classfit
 , comp   = SASHELP.class
 , diff   = WORK.diff
 , idcols = Name
 , print  = Y
 , debug  = N
   );
```

##### Example 5: Compare SASHELP.class against WORK.class without IDCOLS=:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then do;
      Name = 'Joan';
      Sex = 'F';
   end;
   if name eq 'Janet' then do;
      height = 57.3;
      weight = 99;
   end;
run;

%m_uc_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , print  = Y
 , debug  = N
   );
```

##### Example 6: Compare SASHELP.class against WORK.class with IDCOLS value change:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = 19;
run;

%m_uc_compare_tables(
   base   = SASHELP.class (drop=Height)
 , comp   = WORK.class (drop=Height)
 , idcols = Name Age
 , print  = Y
 , debug  = N
   );
```

##### Example 7: Summarize and compare SASHELP.prdsal3 against SASHELP.prdsal2:
```sas
proc sql noprint;
   create table WORK.prdsal2 as
   select country, state, county, prodtype, product, year, quarter
        , sum(actual) as actual, sum(predict) as predict
     from SASHELP.prdsal2 (drop=month monyr)
    group by country, state, county, prodtype
        , product, year, quarter
    order by year, quarter
   ;
quit;

proc sql noprint;
   create table WORK.prdsal3 as
   select country, state, county, prodtype, product, year, quarter
        , sum(actual) as actual, sum(predict) as predict
     from SASHELP.prdsal3 (drop=month date)
    group by country, state, county, prodtype
        , product, year, quarter
    order by year, quarter
   ;
quit;

%m_uc_compare_tables(
   base   = WORK.prdsal3
 , comp   = WORK.prdsal2
 , diff   = WORK.prdsal_grp_diff
 , idcols = Country State County Prodtype Product Year Quarter
 , print  = Y
 , debug  = N
   );
```

##### Example 8: Compare SASHELP.prdsal3 against SASHELP.prdsal2 directly:
```sas
%m_uc_compare_tables(
   base   = SASHELP.prdsal3 (drop=date)
 , comp   = SASHELP.prdsal2 (drop=monyr)
 , diff   = WORK.prdsal_diff
 , idcols = Country State County Prodtype Product Year Quarter
 , print  = N
 , debug  = N
   );

title "Attribute Summary (Differences) between SASHELP.prdsal3 and SASHELP.prdsal2";
proc print data=WORK.prdsal_diff (drop=_key_) label;
run;
title;
```

### Copyright
Copyright 2008-2021 Paul Alexander Canals y Trocha. 
 
This program is free software: you can redistribute it and/or modify 
it under the terms of the GNU General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
 
This program is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
GNU General Public License for more details. 
 
You should have received a copy of the GNU General Public License 
along with this program. If not, see <https://www.gnu.org/licenses/>. 


***
*This document was generated on 11.04.2021 at 21:10:52  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
