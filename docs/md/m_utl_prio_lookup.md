![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_prio_lookup.sas

### Utilities

##### Utility macro to perform hash table lookups by column priority.

***

### Description
The macro reads a given lookup table MAP_TBL, and split the mapping entries by a) the number of given key combinations, and b) by priority given by a designated priority column in the mappng table. The number of combination lookup tables is defined by 2**k, where k is the number of key columns.

##### *Note:*
*The combinations are written in their binary representation using the SAS binary format binaryw. where w is set to k. E.g. for k=3, combinations=000 111 110 101 100 011 010 001. This list is then reordered by importance, counting the '1', into the following list: 111 110 101 011 100 010 001 000.
 The entries from the mapping table will be splitted over smaller tables using the ranked binary list as marker for the given specified key columns per entry. A key column is specified when it's value is unequal to the NULL parameter value (e.g. # or n.r.). After splitting the mapping table, the smaller tables are then defined and included as hash tables, using the following order: descending importance,
 and acsending priority value. This means that the priority column value in the MAP_TBL must be set using the following logic: the 'higher' the priority, the 'lower' it's value.
*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-21 00:00:00

### Version
* 23.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | src_tbl | Full LIBNAME.TABLENAME name of the source SAS dataset or databse table containing the KEYS columns. The default value is: _NONE. |
| Input | map_tbl | Full LIBNAME.TABLENAME name of the mapping SAS dataset or databse table containing all of the KEYS/COLS columns. The default value is: _NONE. |
| Input | trg_tbl | Full LIBNAME.TABLENAME name of the target SAS dataset containing all the SRC_TBL columns and mapped COLS columns from the given MAP_TBL. The default value is: _NONE. |
| Input | keys | Specifies the input key variables for the hash object. Key variables are separated by a blank character. |
| Input | cols | Specifies the output data variables for the hash object. Data variables are separated by a blank character. The default value for COLS is: _ALL_. |
| Input | prio | Specifies the priority column name for the hash objects. The column must exist in the MAP_TBL. |
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
      support_cd  : $char4.
      ;
datalines;
10001   Sovereign    100       301
10002   Sovereign    100       201
10003   Sovereign    300       201
10004   Country      300       999
10005   Retail       7         1
20001   Corporate    921       500
20002   Corporate    trf_eur   7
30001   Goverment    800       444
30002   Goverment    801       402
30003   Financial    300       301
;
run;

proc print data=WORK.counterparty_data noobs;
   title 'Counterparty Data';
run;

```

##### Example 2: Step 2 - Create an example mapping table:
```sas
data WORK.map_asset_class;
   input
      priority     : $char2.
      cpy_type     : $char30.
      method_cd    : $char15.
      support_cd   : $char4.
      asset_class  : $char30.
      ;
   datalines;
1    #                 trf_eur   #     Transfer_EUR
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

proc print data=WORK.map_asset_class noobs;
   title 'Map Asset Class Data';
run;

```

##### Example 2: Step 3 - Perform priority hash lookup:
```sas
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_mapped
 , keys    = %str(cpy_type method_cd support_cd)
 , cols    = %str(asset_class)
 , prio    = %str(priority)
 , null    = %str(#)
 , print   = Y
 , debug   = N
   );

```

##### Example 3: Perform lookup again different order:
```sas
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_mapped
 , keys    = %str(method_cd support_cd cpy_type)
 , cols    = %str(asset_class)
 , prio    = %str(priority)
 , debug   = N
   );

proc print data=WORK.counterparty_mapped;
run;

```

##### Example 4: Perform lookup again different order:
```sas
%m_utl_prio_lookup(
   src_tbl = WORK.counterparty_data
 , map_tbl = WORK.map_asset_class
 , trg_tbl = WORK.counterparty_mapped
 , keys    = %str(method_cd cpy_type support_cd)
 , cols    = %str(asset_class)
 , prio    = %str(priority)
 , debug   = N
   );

proc print data=WORK.counterparty_mapped;
run;

```

### Copyright
Copyright 2008-2023 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 21.10.2023 at 09:19:20  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
