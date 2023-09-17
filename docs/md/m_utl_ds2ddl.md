![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_ds2ddl.sas

### Utilities

##### Utility macro to create a Data Definition Language DDL script.

***

### Description
This macro obtains all column, index and constraint information from a given dataset to be used to generate a Data Definition Language (DDL) file. The DDL file contains a SAS proc sql step to create a new instance of the given source dataset.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-01-27 00:00:00

### Version
* 21.1.01

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | libnm | Parameter to specify the SAS library reference. The default value for LIBNM is: _NONE. |
| Input | tblnm | Parameter to specify the SAS dataset or table. The default value for TBLNM is: \_NONE\_. |
| Input | ddl_file | Specifies the full path and name of the DDL file where the formatted output is written to. If the file that you specify does not exist, then it will be created for you. The default value for DDL_FILE is: \_NONE\_. |
| Input | prm_flg | Boolean [Y/N] parameter to specify wether the output DDL contains the identical libref, table name, and credentials as the input source table or to parameterize this information by using SAS macro variables instead. If PRM_FLG=Y, the libref, table name and optional credentials are replaced by the PRM_LIB, PRM_TBL, and PRM_CREDS values. The default value is: N. |
| Input | prm_lib | Optional. Parameter to specify the output DDL SAS library reference name or the SAS macro variable name value (e.g. &libref.). |
| Input | prm_tbl | Optional. Parameter to specify the output DDL SAS dataset name or the SAS macro variable name value (e.g. &table.). |
| Input | prm_creds | Optional. String containing the output DDL SAS encryption key value information. The following parameter syntax is to be respected to work properly: encrypt=aes encryptkey= Alternatively a SAS macro variable name value can be used (e.g. &creds.). |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Returns all column index information on a given table.

### Calls
* [m_utl_chk_table_exist.sas](m_utl_chk_table_exist.md)
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_get_sashelp.sas](m_utl_get_sashelp.md)
* [m_utl_get_tbl_columns.sas](m_utl_get_tbl_columns.md)
* [m_utl_get_tbl_constraints.sas](m_utl_get_tbl_constraints.md)
* [m_utl_get_tbl_indexes.sas](m_utl_get_tbl_indexes.md)
* [m_utl_hash_lookup.sas](m_utl_hash_lookup.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_ds2ddl(?)
```

##### For the next examples create a table with a couple of indexes:
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
   CREATE UNIQUE INDEX PARTNER_ID ON WORK.BANKKONTO (PARTNER_ID);
   CREATE INDEX IDX_BANKKONTO ON WORK.BANKKONTO (KONTO_ID, LOAD_DTTM);
quit;
```

##### Example 2: Create a Data Definition Language file for table bankkonto:
```sas
%m_utl_ds2ddl(
   libnm    = WORK
 , tblnm    = bankkonto
 , ddl_file = %sysfunc(getoption(WORK))/bankkonto_work.sas
 , print    = Y
 , debug    = Y
   );
```

##### Example 3: Create a DDL file for table bankkonto with libref parameter:
```sas
%m_utl_ds2ddl(
   libnm    = WORK
 , tblnm    = bankkonto
 , ddl_file = %sysfunc(getoption(WORK))/bankkonto_libref.sas
 , prm_flg  = Y
 , prm_lib  = %nrstr(&libref.)
 , print    = Y
 , debug    = Y
   );
```

##### Example 4: Create a DDL file for table bankkonto with creds parameter:
```sas
%m_utl_ds2ddl(
   libnm     = WORK
 , tblnm     = bankkonto
 , ddl_file  = %sysfunc(getoption(WORK))/bankkonto_creds.sas
 , prm_flg   = Y
 , prm_lib   = %nrstr(&libref.)
 , prm_creds = %nrstr(&creds.)
 , print     = Y
 , debug     = Y
   );
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
*This document was generated on 13.09.2023 at 19:02:55  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
