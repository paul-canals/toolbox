![../misc/images/doc_banner.png](../misc/images/doc_banner.png)
# 
# File Reference: m_utl_print_file.sas

### Utilities

##### Utility macro to print a file to the SAS log output destination.

***

### Description
This program prints the contents of an external text file to the SAS log output destination (SAS Log). The file types are checked by comparing the file extension with a valid file type list. Currently the following file types are allowed: CSV, LOG or TXT.


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
| Input | txt_file | Specifies the file path and name of the txt file to be printed to the SAS log output destination The default value for TXT_FILE is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Text file printed to the SAS log output destination.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_print_file(?)
```

##### Example 2: Print text file class.txt to the SAS log output destination:
```sas
proc export data=SASHELP.class
   outfile="%sysfunc(getoption(WORK))/class.txt" dbms=tab replace;
   putnames=no;
run;

%m_utl_print_file(
   txt_file = %str(%sysfunc(getoption(WORK))/class.txt)
 , debug    = Y
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
*This document was generated on 28.03.2021 at 09:56:20  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.03)*
