# File Reference: m_utl_clr_table_lock.sas

### Utilities

##### Utility macro to clear an exclusive lock from a SAS dataset.

***

### Description
This macro can be used to clear an exclusive lock from a dataset, which is owned by the user running this program. The result value can be returned in a SAS macro variable. Valid lock status result values are:
 RESULT \= 1 \-> Table is now unlocked by you.
 RESULT \= 0 \-> Table could not be unlocked by you.


##### *Note:*
*SAS Problem Note 2859: LOCK statement or function with LIST or QUERY options might report locks incorrectly:
 http://support.sas.com/kb/2/859.html
*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-02-02 00:00:00

### Version
* 20.1.02

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | member | Full LIBNAME.TABLENAME name of the SAS Dataset to clear an exclusive access lock from. The default value for MEMBER is: \_NONE\_. |
| Input | timeout | The or wait time in amount of seconds. The default value for TIMEOUT is: 10. |
| Input | retry | The amount of time in seconds between tryouts The default value for RETRY is: 5. |
| Input | global_flg | Boolean [Y/N] Parameter to specify wether the result value is to be declared as a global macro variable. If set to N, the result is not returned outside this program. The default value is: N. |
| Output | mvar_name | Name of the global SAS macro variable containing the result value representing the lock status. The default value for MVAR_NAME is: _cleared. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Lock cleared from a SAS dataset

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_clr_table_lock(?)
```

##### Example 2: Clear a lock from a SAS dataset:
```sas
data WORK.class;
   set SASHELP.class;
run;

lock WORK.class;
%put &=SYSLCKRC.;

%m_utl_clr_table_lock(
   member     = WORK.class
 , timeout    = 10
 , retry      = 5
 , global_flg = Y
 , mvar_name  = cleared
 , show_err   = Y
 , debug      = Y
   )
%put &=cleared.;
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
*This document was generated on 27.09.2021 at 15:28:18  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
