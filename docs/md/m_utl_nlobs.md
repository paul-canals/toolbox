![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_nlobs.sas

### Utilities

##### Utility macro to determine the number of records in a table.

***

### Description
The macro can be used anywhere in a SAS program including within a SAS procedure or SAS data step. If the table does not exist, it returns \-1. If the table exists, but cannot opened it returns 0. Different parameter names are allowed. This macro is originally based on the ut_nlobs.sas macro by Dave Prinsloo (dave.prinsloo@yahoo.com) and also the where statement inclusion by Roland Rashleigh-Berry.

##### *Note:*
*The SHOW_ERR parameter shows or suppresses possible warnings or errors in the log. The default value for SHOW_ERR is: N.
*
*In case of encrypted SAS datasets, the ENCRYPTKEY= parameter must be provided as part of the CREDS credentials string.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-04 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | dataset | Full LIBNAME.TABLENAME name of the table or SAS dataset to get the number of records from. The parameter can contain SAS data step style where statement between brackets. See example 3 below. The default value is: \_NONE\_. |
| Input | table | Alias of the dataset= parameter. |
| Input | data | Alias of the dataset= parameter. |
| Input | creds | Optional. Specifies the ENCRYPTKEY= parameter value if DATASET involves an encrypted dataset. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The number of non-deleted records in a given table

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_nlobs(?)
```

##### Example 2: Get number of records from an encrypted SAS dataset:
```sas
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

proc print data=WORK.class(encryptkey=aespasskey);
   where Sex='F';
run;

%let numobs=
   %m_utl_nlobs(
      dataset = WORK.class(where=(Sex='F'))
    , creds   = %str(encryptkey=aespasskey)
    , debug   = Y
      );

%put NUMOBS=&numobs.;

data WORK.nlobs;
   table='WORK.class';
   sex='F';
   nlobs=&numobs.;
run;

proc print data=WORK.nlobs noobs;
run;
```

##### Example 3: Get number of records from dataset with where statement:
```sas
data WORK.nlobs;
   table='SASHELP.class';
   age_over_13=
      %m_utl_nlobs(
         dataset = SASHELP.class(where=(Age > 13))
       , debug   = Y
         );
run;

proc print data=WORK.nlobs noobs;
run;
```

##### Example 4: Get number of records from a SAPBW table:
```sas
%let numobs=
   %m_utl_nlobs(
      table = SAPBW.T000
    , debug = Y
      );

%put NUMOBS=&numobs.;
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
*This document was generated on 26.09.2023 at 15:41:38  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
