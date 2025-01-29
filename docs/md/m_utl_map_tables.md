[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_map_tables.sas

### Utilities

##### Utility macro to map and load data to a target table or dataset.

***

### Description
The macro reads the given source table SRC_TBL and target table TRG_TBL to collect the column information to be able to create a mapping between the source and target columns which exist in both source and target tables. The column mapping list can be filtered using the optional SRC_COLS and TRG_COLS parameters. If both the SRC_COLS and TRG_COLS parameters are set, mapping can be performed between source and target table columns with name differences. In this case the order of the columns listed in the SRC_COLS and TRG_COLS is as important as also the number of source and target table columns for the routine to create the correct mapping between source and target column pairs.



##### *Note:*
*The mapping engine is able to match source to target columns having different names. This is done by processing SRC_COLS and TRG_COLS sequentially. Before the mapping process starts a check is performed to verify the number of columns between source and target are equal (balanced).*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-06-08 00:00:00

### Version
* 24.1.06

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | src_tbl | Mandatory. Full LIBNAME.TABLENAME name of the source dataset or databse table to read from. The default value for SRC_TBL is: \_NONE\_. |
| Input | src_cols | Optional. A list of source table column names separated by a BLANK character. |
| Input | trg_tbl | Mandatory. Full LIBNAME.TABLENAME name of the target dataset or databse table to read from. The default value for TRG_TBL is: \_NONE\_. |
| Input | trg_cols | Optional. A list of target table column names separated by a BLANK character. |
| Input | out_tbl | Optional. Full LIBNAME.TABLENAME name of the output dataset or databse table in which the source data is to be loaded into. If omitted the OUT_TBL value is set to the mandatory TRG_TBL parameter value. |
| Input | print | [Y/N]. Boolean parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Loaded target table with data for the mapped columns.

### Calls
* [m_utl_get_col_code.sas](m_utl_get_col_code.md)
* [m_utl_hash_define.sas](m_utl_hash_define.md)
* [m_utl_list_operation.sas](m_utl_list_operation.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_sort_elems.sas](m_utl_sort_elems.md)
* [m_utl_varlist.sas](m_utl_varlist.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_map_tables(?)
```

##### Example 2: Copy all data from SASHELP.class to WORK.classfit:
```sas
data WORK.classfit;
   set SASHELP.classfit;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , print    = Y
 , debug    = Y
   );

```

##### Example 3: Copy data from selected columns of SASHELP.class to WORK.classfit:
```sas
data WORK.classfit;
   set SASHELP.classfit;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , src_cols = Name Sex Age
 , trg_tbl  = WORK.classfit
 , print    = Y
 , debug    = Y
   );

```

##### Example 4: Copy data from SASHELP.class to selected columns of WORK.classfit:
```sas
data WORK.classfit;
   set SASHELP.classfit;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , trg_cols = Name Sex Age
 , print    = Y
 , debug    = N
   );

```

##### Example 5: Copy all data from SASHELP.class to WORK.classfit:
```sas
data WORK.classfit (rename=(_Name=Name _Age=Age _Weight=Weight));
   attrib _Name length=$7. label='Name';
   attrib _Age length=$3. label='Age';
   attrib _Weight length=$8. label='Weight';
   set SASHELP.classfit;
   drop Name Age Weight;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , print    = Y
 , debug    = N
   );

```

##### Example 6: Copy data from SASHELP.class to selected columns of WORK.classfit:
```sas
data WORK.class;
   set SASHELP.class;
   if Name eq 'John' then weight = . ;
run;

data WORK.classfit (rename=(_Name=Name _Age=Age _Weight=Weight));
   attrib _Name length=$7. label='Name';
   attrib _Age length=$3. label='Age';
   attrib _Weight length=$8. label='Weight';
   set SASHELP.classfit;
   drop Name Age Weight;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , trg_cols = Name Sex Age Weight
 , print    = Y
 , debug    = N
   );

proc print data=WORK.classfit (keep=Name Sex Age Weight) label;
run;

```

##### Example 7: Copy data from selected columns of SASHELP.class to WORK.result:
```sas
data WORK.classfit (rename=(_Name=Name _Age=Age _Weight=Weight));
   attrib _Name length=$7. label='Name';
   attrib _Age length=$3. label='Age';
   attrib _Weight length=$8. label='Weight';
   set SASHELP.classfit;
   drop Name Age Weight;
   stop;
run;

proc datasets lib = WORK nolist nowarn memtype = (data view);
   delete result ;
quit;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , trg_cols = Name Sex Age Weight
 , out_tbl  = WORK.result
 , print    = Y
 , debug    = N
   );

proc print data=WORK.result label;
run;

```

##### Example 8: Copy data from SASHELP.air and map to column names of WORK.airline:
```sas
data WORK.airline(rename=(Air=Flights));
   set SASHELP.airline;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.air
 , src_cols = Date Air
 , trg_tbl  = WORK.airline
 , trg_cols = Date Flights
 , print    = Y
 , debug    = N
   );

proc print data=WORK.airline (keep=Date Flights obs=10);
run;

```

##### Example 9: Map and load data with column type and format change (Num->Char):
```sas
data WORK.prdsale;
   set SASHELP.prdsale;
   attrib DATE length=8 format=MONYY. informat=MONYY.;
   DATE = MONTH;
run;

data WORK.prdsal3 (rename=(_DATE=DATE));
   set SASHELP.prdsal3;
   attrib _DATE length=$4 format=$4.;
   _DATE = put(DATE, monyy.);
   drop DATE;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = WORK.prdsale
 , src_cols = ACTUAL COUNTRY DATE MONTH PREDICT PRODTYPE PRODUCT QUARTER YEAR
 , trg_tbl  = WORK.prdsal3
 , trg_cols = ACTUAL COUNTRY DATE MONTH PREDICT PRODTYPE PRODUCT QUARTER YEAR
 , out_tbl  = WORK.prdsal3
 , print    = Y
 , debug    = Y
   );

```

##### Example 10: Map and load data with column type and format change (Char->Num):
```sas
data WORK.prdsale;
   set SASHELP.prdsale;
   attrib DATE length=$5 format=$5.;
   DATE = put(MONTH, monyy.);
run;

proc datasets lib = WORK nolist nowarn memtype = (data view);
   delete result ;
quit;

%m_utl_map_tables(
   src_tbl  = WORK.prdsale
 , src_cols = ACTUAL COUNTRY DATE MONTH PREDICT PRODTYPE PRODUCT QUARTER YEAR
 , trg_tbl  = SASHELP.prdsal3
 , trg_cols = ACTUAL COUNTRY DATE MONTH PREDICT PRODTYPE PRODUCT QUARTER YEAR
 , out_tbl  = WORK.result
 , print    = Y
 , debug    = N
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
*This document was generated on 2024.06.08 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
