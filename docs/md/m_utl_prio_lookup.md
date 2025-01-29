[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_prio_lookup.sas

### Utilities

##### Utility macro to perform hash table lookups by column priority.

***

### Description
The macro reads a given lookup table MAP_TBL, and split the mapping entries by a) the number of given key combinations, and b) by priority given by a designated priority column in the mappng table. The number of combination lookup tables is defined by 2**k, where k is the number of key columns.



##### *Note:*
*The combinations are written in their binary representation using the SAS binary format binaryw. where w is set to k. E.g. for k=3, combinations=000 111 110 101 100 011 010 001. This list is then reordered by importance, counting the '1', into the following list: 111 110 101 011 100 010 001 000. The entries from the mapping table will be splitted over smaller tables using the ranked binary list as marker for the given specified key columns per entry. A key column is specified when its value is unequal to the NULL parameter value (e.g. # or n.r.). After splitting the mapping table, the smaller tables are then defined and included as hash tables, using the following order: acsending priority value. Important is that the priority value in the MAP_TBL must be set using the following logic: the higher the priority, the lower its value. Also note that the mapping table must contain an entry for a default value if no key combination match can be made and that this entry contains the highest priority value, otherwise no value (missing) is returned.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-01-30 00:00:00

### Version
* 24.1.01

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | src_tbl | Full LIBNAME.TABLENAME name of the source SAS dataset or databse table containing the KEYS columns. The default value is: \_NONE\_. |
| Input | map_tbl | Full LIBNAME.TABLENAME name of the mapping SAS dataset or databse table containing all of the KEYS/COLS columns. The default value is: \_NONE\_. |
| Input | trg_tbl | Full LIBNAME.TABLENAME name of the target SAS dataset containing all the SRC_TBL columns and mapped COLS columns from the given MAP_TBL. The default value is: \_NONE\_. |
| Input | mode | Indicator [H/S] to specify the mapping method. The mapping method used is either H for hash object lookups, or S for PROC SQL join mapping. The default value for MODE is: H. |
| Input | prio | Specifies the priority column name for the hash objects. The column must exist in the MAP_TBL. |
| Input | keys | Specifies the input key variables for the hash object. Key variables are separated by a blank character. |
| Input | cols | Specifies the output data variables for the hash object. Data variables are separated by a blank character. The default value for COLS is: _ALL_. |
| Input | null | Specifies the key column value in the MAP_TBL representing the not applicable entry status. The default value for NULL is: #. |
| Input | print | [Y/N]. Boolean parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Output target table with the mapped columns.

### Calls
* [m_utl_get_col_type.sas](m_utl_get_col_type.md)
* [m_utl_hash_define.sas](m_utl_hash_define.md)
* [m_utl_list_operation.sas](m_utl_list_operation.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_sort_elems.sas](m_utl_sort_elems.md)
* [m_utl_varlist.sas](m_utl_varlist.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_prio_lookup(?)
```

##### Example 2: Step 1 - Create an example source table:
```sas
data WORK.counterparty_data;
   input
      cpy_id      : $char5.
      cpy_type    : $char30.
      method_cd   : $char15.
      version_cd  : $char4.
      ;
datalines;
10001     Sovereign     100         301
10002     Sovereign     100         201
10003     Sovereign     300         201
10004     Country       300         999
10005     Retail        7           1
20001     Corporate     921         500
20002     Corporate     TRS_EUR     7
30001     Goverment     800         444
30002     Goverment     801         402
30003     Financial     300         301
;
run;

```

##### Example 2: Step 2 - Create an mapping table (priority: CHAR):
```sas
data WORK.map_asset_class;
   input
      priority     : $char2.
      cpy_type     : $char30.
      method_cd    : $char15.
      version_cd   : $char4.
      asset_class  : $char30.
      ;
   datalines;
1    #                 TRS_EUR   #     Transfer_EUR
4    #                 100       #     Sovereign
9    #                 300       201   SubSovereign
11   #                 300       301   Financial
12   #                 300       #     Sovereign
18   #                 1         #     NonFinancial
19   #                 921       #     NonFinancial
40   Fin.Institution   999       #     Financial
45   Goverment         999       #     Sovereign
46   #                 999       #     NonFinancial
47   Fin.Institution   #         #     Financial
52   Goverment         #         #     Sovereign
53   #                 #         #     NonFinancial
;
run;

```

##### Example 2: Step 3 - Perform priority hash lookup:
```sas
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_map
 , prio    = %str(priority)
 , keys    = %str(cpy_type method_cd version_cd)
 , cols    = %str(asset_class)
 , null    = %str(#)
 , print   = Y
 , debug   = Y
   );

```

##### Example 3: Perform lookup again different order:
```sas
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_map
 , prio    = %str(priority)
 , keys    = %str(method_cd version_cd cpy_type)
 , cols    = %str(asset_class)
 , debug   = Y
   );

proc print data=WORK.counterparty_map;
   title 'Ex.3 Perform lookup with different Key order';
   footnote 'Keys: method_cd version_cd cpy_type';
   footnote2 'Cols: asset_class';
run; title; footnote; footnote2;

```

##### Example 4: Perform lookup again different order:
```sas
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_map
 , prio    = %str(priority)
 , keys    = %str(method_cd cpy_type version_cd)
 , cols    = %str(asset_class)
 , debug   = Y
   );

proc print data=WORK.counterparty_map;
   title 'Ex.4 Perform lookup with different Key order';
   footnote 'Keys: method_cd cpy_type version_cd';
   footnote2 'Cols: asset_class';
run; title; footnote; footnote2;

```

##### Example 5: Step 1 - Create an example source table:
```sas
data WORK.counterparty;
   input
      cpy_id      : $char5.
      cpy_type    : $char30.
      method_cd   : $char15.
      version_cd  : $char4.
      ;
datalines;
10001     Sovereign     100     301
10002     Sovereign     100     201
10003     Sovereign     300     201
10004     Country       300     999
10005     Retail        7       1
20001     Corporate     921     500
20002     Corporate     999     7
30001     Goverment     800     444
30002     Goverment     801     402
30003     Financial     300     301
;
run;

```

##### Example 5: Step 2 - Create an mapping table (priority: NUM):
```sas
data WORK.map_product_type;
   input
      priority
      cpy_type     : $char30.
      method_cd    : $char15.
      version_cd   : $char4.
      prod_type    : $char30.
      ;
   datalines;
4    #             100     #       Sovereign
9    #             300     201     SubSovereign
11   #             300     301     Financial
12   #             300     #       Sovereign
18   #             1       #       NonFinancial
19   #             800     #       Sovereign
20   #             999     #       NonFinancial
40   Financial     999     #       Financial
45   Goverment     999     #       Subsovereign
46   Goverment     #       402     Subsovereign
47   Financial     #       #       Financial
53   Goverment     #       #       Sovereign
55   #             #       #       NonFinancial
;
run;

```

##### Example 5: Step 3 - Perform priority hash lookup:
```sas
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty
 , map_tbl = WORK.map_product_type
 , trg_tbl = WORK.counterparty
 , prio    = %str(priority)
 , keys    = %str(cpy_type method_cd version_cd)
 , cols    = %str(prod_type)
 , print   = Y
 , debug   = Y
   );

```

##### Example 6: Step 1 - Create an example source table:
```sas
data WORK.counterparty;
   input
      cpy_id      : $char5.
      cpy_type    : $char30.
      method_cd   : $char15.
      version_cd  : $char4.
      ;
datalines;
10001     Sovereign     100     301
10002     Sovereign     100     201
10003     Sovereign     300     201
10004     Country       300     999
10005     Retail        1       7
20001     Corporate     921     500
20002     Corporate     999     7
30001     Goverment     800     444
30002     Goverment     801     402
30003     Financial     300     301
;
run;

proc print data=WORK.counterparty;
   title 'Ex.6 WORK.COUNTERPARTY (SRC)';
run; title; footnote;

```

##### Example 6: Step 2 - Create an mapping table (No default):
```sas
data WORK.map_product_type;
   input
      priority
      cpy_type     : $char30.
      method_cd    : $char15.
      version_cd   : $char4.
      prod_cluster : $char3.
      prod_type    : $char30.
      ;
   datalines;
1    #             100     #       SOV    Sovereign
2    #             300     201     SOV    SubSovereign
3    #             300     301     FIN    Financial
4    #             300     #       SOV    Sovereign
5    #             1       #       RET    NonFinancial
6    #             800     #       SOV    Sovereign
10   Financial     999     #       FIN    Financial
25   Goverment     999     #       SOV    Subsovereign
26   Goverment     #       402     SOV    Subsovereign
27   Goverment     #       #       SOV    Sovereign
35   Financial     #       #       FIN    Financial
;
run;

proc print data=WORK.map_product_type;
   title 'Ex.6 WORK.MAP_PRODUCT_TYPE (MAP)';
run; title; footnote;

```

##### Example 6: Step 3 - Perform priority lookup (No default):
```sas
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty
 , map_tbl = WORK.map_product_type
 , trg_tbl = WORK.counterparty_def
 , prio    = %str(priority)
 , keys    = %str(cpy_type method_cd version_cd)
 , cols    = _ALL_
 , print   = N
 , debug   = N
   );

proc print data=WORK.counterparty_def;
   title 'Ex.6 Perform lookup with no default';
   footnote 'Keys: cpy_type method_cd version_cd';
   footnote2 'Cols: _ALL_';
run; title; footnote; footnote2;

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
*This document was generated on 2024.01.30 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
