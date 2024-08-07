![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_get_attrc.sas

### Utilities

##### Utility macro to return a character attribute of a SAS dataset.

***

### Description
The macro can be used to obtain character attribute information of a SAS DATASET. The following is a list of valid character SAS dataset attribute names:

 CHARSET
 COMPRESS
 DATAREP
 ENCODING
 ENCRYPT
 ENGINE
 LABEL
 LIB
 MEM
 MODE
 MTYPE
 SORTEDBY
 SORTLVL
 SORTSEQ
 TYPE



##### *Note:*
*The SHOW_ERR parameter shows or suppresses possible warnings or errors in the log. The default for SHOW_ERR is value is N.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-04-13 00:00:00

### Version
* 24.1.04

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | table | Full qualified LIBNAME.TABLENAME name of the source database table or SAS dataset. The default value for TABLE is: \_NONE\_. |
| Input | table_id | Parameter representing the SAS dataset or table identifier. The parameter contains the value of the table identifier when the table was already opened before calling this macro. The default value for TABLE_ID is: 0. |
| Input | creds | Optional. Specifies the ENCRYPTKEY= parameter value when TABLE involves an encrypted, or PW=, ALTER=, READ= or WRITE= for a protected dataset. |
| Input | attr_nm | Parameter to specify the name of the SAS data set attribute whose character value is returned. If the value of ATTR_NM is invalid, a missing value is returned and optionally a warning or error message will be written in the SAS log. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Returns the result of the attrc value supplied.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_attrc(?)
```

##### Example 2: Get the library name of a SAS dataset:
```sas
%let libref =
   %m_utl_get_attrc(
      table   = SASHELP.class
    , attr_nm = LIB
    , debug   = Y
      );

%put &=libref.;

```

##### Example 3: Get the data type of a SAS dataset:
```sas
%let datatype =
   %m_utl_get_attrc(
      table   = SASHELP.class
    , attr_nm = TYPE
    , debug   = Y
      );

%put &=datatype.;

```

##### Example 4: Check if the SAS dataset is encrypted:
```sas
%let encrypted =
   %m_utl_get_attrc(
      table   = SASHELP.class
    , attr_nm = ENCRYPT
    , debug   = Y
      );

%put &=encrypted.;

data WORK.class (encrypt=aes encryptkey=passkey);
   set SASHELP.class;
run;

%let encrypted =
   %m_utl_get_attrc(
      table   = WORK.class (encryptkey=passkey)
    , attr_nm = ENCRYPT
    , debug   = Y
      );

%put &=encrypted.;

proc datasets lib=WORK nolist nowarn;
   delete class;
quit;

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
*This document was generated on 2024.04.13 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
