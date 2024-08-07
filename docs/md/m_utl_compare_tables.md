![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_compare_tables.sas

### Utilities

##### Utility macro to determine the differences between two datasets.

***

### Description
The macro compares two tables or SAS datasets, the base dataset TABLE1 and the comparison dataset TABLE2. The macro procedure determines both matching variables and records or observations. Matching variables are those having the same name and type. Matching observations are those having identical values for all specified IDCOLS variables or if IDCOLS parameter is not set, those columns that occur in the same position in the datasets. If matched observations by IDCOLS variables is set, then both SAS datasets or tables must be sorted by all IDCOLS variables.

 The SAS compare procedure uses the SYSINFO return code value for status messaging. The macro call parameters MVAR_RC and MVAR_MSG represents the return code and status message values. The SAS SYSINFO return codes are in fact binary numbers. These 16 differences can be viewed as 16 bit positions in a binary number of 16 digits: where "0" at a particular position means the difference is absent and "1" means the difference has been detected. The return code may the following status messages:

- 01 : Data set labels differ
- 02 : Data set types differ
- 03 : Variable has different informat
- 04 : Variable has different format
- 05 : Variable has different length
- 06 : Variable has different label
- 07 : BASE data set has observations not in COMP
- 08 : COMP data set has observations not in BASE
- 09 : BASE data set has BY group not in COMP
- 10 : COMP data set has BY group not in BASE
- 11 : BASE data set has variable not in COMP
- 12 : COMP data set has variable not in BASE
- 13 : A value comparison was unequal
- 14 : Conflicting variable types
- 15 : BY variables do not match
- 16 : Fatal error: comparison not done

 For example when the SYSINFO return code has value of 4224, the will translate to the binary value of: 0001000010000000 (13 digits \- 4096, and 8 digits \- 128), which represents the following two messages: "COMP data set has observations not in BASE" and "A value comparison was unequal".



##### *Note:*
*The use of PROC COMPARE in combination with SYSINFO return code is based on SAS Global Forum Paper (063-2012) by Joseph Hinson and Margaret Coughlin in which they presented a novel approach of interpreting SYSINFO codes using the SAS bitwise function called "bAND" or "bitwise AND" since SYSINFO codes are binary.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-08-01 00:00:00

### Version
* 24.1.08

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
| Input | method | Indicator [ABSOLUTE/EXACT/PERCENT] to specify the method used for the COMPARE procedure. The standard method is EXACT. If ABSOLUTE or PERCENT then the CRITERION option is used to determine data changes during the evaluation. The default value for METHOD is: EXACT. |
| Input | gamma | Optional. Parameter to specify the criterion for judging the equality of numeric values. The parameter value is only valid when METHOD parameter value is set to ABSOLUTE or PERCENT. |
| Input | idcols | A blank separated list of column names to be used to match observations between the base and comparison tables. If no id columns are given, both base and compare tables must have identical record entries (only column values are checked for differences). |
| Input | exclude | Optional. A blank separated list of columns to be excluded from the table comparison routine. |
| Input | stats | Boolean [Y/N] parameter to specify if an output table containing the comparison statistics is to be created. The default value is: N. |
| Input | nodups | Boolean [Y/N] parameter to specify if duplicate observations are ignored from the comparison. The default value for NODUPS is: Y. |
| Input | nomiss | Boolean [Y/N] parameter to specify if missing values in both the base and comparison tables are to be judged as equal to any value. If set N, a missing value is equal only to a missing value of the same kind. If set Y, a missing value is equal to ANY value. The default value for NOMISS is: N. |
| Output | mvar_rc | Name of the global macro variable containing the comaprison result return code (SYSINFO). The default value for MVAR_RC is: _comp_rc. |
| Output | mvar_msg | Name of the global macro variable containing the comparison detailed result message text. The default value for MVAR_TXT is: _comp_msg. |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Table comparison summary table.

### Calls
* [m_utl_chk_table_exist.sas](m_utl_chk_table_exist.md)
* [m_utl_get_col_code.sas](m_utl_get_col_code.md)
* [m_utl_get_col_format.sas](m_utl_get_col_format.md)
* [m_utl_get_col_type.sas](m_utl_get_col_type.md)
* [m_utl_hash_define.sas](m_utl_hash_define.md)
* [m_utl_list_operation.sas](m_utl_list_operation.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_varlist.sas](m_utl_varlist.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_compare_tables(?)
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
%m_utl_compare_tables(
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
%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = SASHELP.classfit
 , diff   = WORK.diff
 , print  = Y
 , debug  = N
   );
```

##### Example 4: Compare SASHELP.classfit against SASHELP.class:
```sas
%m_utl_compare_tables(
   base   = SASHELP.classfit
 , comp   = SASHELP.class
 , diff   = WORK.diff
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

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , diff   = WORK.diff
 , print  = Y
 , debug  = N
   );
```

##### Example 6: Compare SASHELP.class against WORK.class with IDCOLS=Name value:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = 19;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , idcols = Name
 , print  = Y
 , debug  = N
   );

%put &=_comp_rc.;
%put &=_comp_msg.;
```

##### Example 7: Compare SASHELP.class against WORK.class with IDCOLS value change:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = 19;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , idcols = Name Age
 , print  = Y
 , debug  = N
   );
```

##### Example 8: Summarize and compare SASHELP.prdsal3 against SASHELP.prdsal2:
```sas
proc sql noprint;
   create table WORK.prdsal2 as
   select country, state, prodtype, product, year, quarter, month
        , sum(actual) as actual, sum(predict) as predict
     from SASHELP.prdsal2 (drop=county monyr)
    group by country, state, prodtype, product
        , year, quarter, month
    order by year, quarter, month
   ;
quit;

proc sql noprint;
   create table WORK.prdsal3 as
   select country, state, prodtype, product, year, quarter, month
        , sum(actual) as actual, sum(predict) as predict
     from SASHELP.prdsal3 (drop=county date)
    group by country, state, prodtype, product
        , year, quarter, month
    order by year, quarter, month
   ;
quit;

%m_utl_compare_tables(
   base   = WORK.prdsal3
 , comp   = WORK.prdsal2
 , diff   = WORK.prdsal_grp_diff
 , idcols = Country State Prodtype Product Year Quarter Month
 , nodups = N
 , print  = Y
 , debug  = N
   );
```

##### Example 9: Compare SASHELP.prdsal3 against SASHELP.prdsal2 directly:
```sas
%m_utl_compare_tables(
   base   = SASHELP.prdsal3 (drop=date)
 , comp   = SASHELP.prdsal2 (drop=monyr)
 , diff   = WORK.prdsal_diff
 , idcols = Country State County Prodtype Product Year Quarter Month
 , nodups = Y
 , print  = Y
 , debug  = N
   );
```

##### Example 10: Compare SASHELP.class against WORK.class using METHOD=ABS:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Height = 59.000001;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , method = ABSOLUTE
 , gamma  = 0.000001
 , idcols = Name Age
 , print  = Y
 , debug  = N
   );
```

##### Example 11: Compare SASHELP.class against WORK.class using METHOD=PCT:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Height = 59.000001;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , method = PERCENT
 , gamma  = 0.000001
 , idcols = Name Age
 , print  = Y
 , debug  = N
   );
```

##### Example 12: Compare SASHELP.class against WORK.class using NOMISS=N:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = . ;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , idcols = Name
 , print  = Y
 , debug  = N
   );
```

##### Example 13: Compare SASHELP.class against WORK.class using NOMISS=Y:
```sas
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = . ;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , idcols = Name
 , nomiss = Y
 , print  = Y
 , debug  = N
   );
```

### Copyright
Copyright 2008-2024 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 2024.08.01 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
