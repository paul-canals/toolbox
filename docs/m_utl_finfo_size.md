# File Reference: m_utl_finfo_size.sas

### Utilities

##### Utility macro to obtain the file size in number of bytes.

***

### Description
The macro uses the SAS FINFO function to determine the size of an external file in bytes.

##### *Note:*
*The FINFO function returns the value of a system-dependent information item for an external file that was previously opened and assigned a file-id by the SAS FOPEN function. The FINFO function returns a blank if the value given for info-item is invalid. This can be the case when the system has an other locale than the SAS default english language. The m_utl_finfo_size.sas macro routine however will work system and language independent.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-07 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | file | Full qualified path and name. The default value is: \_NONE\_. |
| Input | fref | Optional. Name of the file reference. The default value is: MyFile. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Numerical value of the file size in bytes.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information
```sas
%m_utl_finfo_size(?)
```

##### Example 2: Get the file size from a SAS dataset:
```sas
data WORK.class;
   set SASHELP.class;
run;

%let filename=%sysfunc(getoption(WORK))/class.sas7bdat;

%let filesize=
   %m_utl_finfo_size(
      file  = &filename.
    , debug = Y
      );

%put Size of %scan(&filename,-1,/\) is &filesize. bytes;
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
*This document was generated on 30.10.2022 at 09:12:47  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
