![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_chk_reserved_words.sas

### Utilities

##### Utility macro containing a list of database reserved words.

***

### Description
The macro creates a list of databaase reserved words, which can be used inline to check column names before creating the table in the database. The macro was initially made to avoid column name errors against an Oracle Database.



##### *Note:*
*To avoid the SAS warning around the quoted string currently being processed has become longer than 262 characters try to set the noquotelenmax system option before calling the macro.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2022-10-18 00:00:00

### Version
* 22.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | global | Boolean [Y/N] Parameter to specify wether the result value is to be declared as a global macro variable. If set to N, the result is returned inline. The default value for GLOBAL is: N. |
| Output | varname | Name of the global macro variable containing the database reserved words list. The default value is: _reserved_words. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* An alphabetically ordered list of reserved words

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_chk_reserved_words(?)
```

##### Example 2: Create global macro variable M_RESERVED_WORDS containing the database reserved words list (global):
```sas
%m_utl_chk_reserved_words(
   global  = Y
 , varname = M_RESERVED_WORDS
 , debug   = Y
   );

%put &=M_RESERVED_WORDS.;

```

##### Example 3: Create a macro variable reserved_words containing the database reserved words list (inline):
```sas
%let reserved_words =
   %m_utl_chk_reserved_words(
    , debug   = Y
   );

%put &=reserved_words.;

```

### Copyright
Copyright 2008-2022 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 2022.10.18 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
