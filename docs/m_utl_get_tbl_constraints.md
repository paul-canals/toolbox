![../misc/images/doc_banner.png](../misc/images/doc_banner.png)
# 
# File Reference: m_utl_get_tbl_constraints.sas

### Utilities

##### Utility macro to obtain constraint information on a given table.

***

### Description
This macro works by using either the SAS dictionary tables or Oracle system tables for constraint information on the passed table and returns a list of constraints and their variables in the order in which those are listed by the constraint.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-23 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | libnm | Parameter to specify the SAS library reference. The default value for LIBNM is: _NONE. |
| Input | tblnm | Parameter to specify the SAS dataset or table. The default value for TBLNM is: \_NONE\_. |
| Input | creds | String containing the Oracle database credentials information. The following order of parameters is to be respected for the macro to work properly: user=, password=, path= |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Returns all column constraint information on a given table.

### Calls
* [m_utl_chk_table_exist.sas](m_utl_chk_table_exist.md)
* [m_utl_get_sashelp.sas](m_utl_get_sashelp.md)
* [m_utl_hash_lookup.sas](m_utl_hash_lookup.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_tbl_constraints(?)
```

##### For the next examples create a table with a primary key constraint:
```sas
proc sql noprint feedback stimer;
   CREATE TABLE WORK.BANKKONTO (
      MANDANT_ID           VARCHAR(8)     label='Mandant Identifier'
    , PARTNER_ID           NUMERIC(8)     label='Geschäftspartner Identifier'
    , KONTO_ID             NUMERIC(8)     label='Konto Identifier'
    , KONTO_WAEHRUNG_CD    VARCHAR(3)     label='Geschäftswährung'
    , KONTO_TYPE_CD        VARCHAR(32)    label='Konto Type Code'
    , SALDO_AMT            NUMERIC(8)     format=19.2 label='Saldo Betrag'
    , LOAD_DTTM            NUMERIC(20)    format=datetime20. label='Ladezeitstempel'
    , CONSTRAINT PRIM_KEY PRIMARY KEY (MANDANT_ID, KONTO_ID, LOAD_DTTM)
      );
quit;
```

##### Example 2: Obtain the constraint information from table bankkonto:
```sas
%m_utl_get_tbl_constraints(
   libnm = WORK
 , tblnm = bankkonto
 , print = Y
 , debug = Y
   );
```

### Copyright
Copyright 2008-2020 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 28.03.2021 at 09:55:54  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.03)*
