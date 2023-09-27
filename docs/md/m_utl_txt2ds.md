![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_txt2ds.sas

### Utilities

##### Utility macro to import a delimited TXT file into a SAS dataset.

***

### Description
This program converts an external delimited file with a TXT extension into a SAS dataset or database table.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2022-11-08 00:00:00

### Version
* 22.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_file | Specifies the name and location of the external delimited file with a TXT extension. The default value is: \_NONE\_. |
| Input | out_ds | Specifies the full LIBNAME.TABLENAME name of the output SAS dataset or database table. The default value is: \_NONE\_. |
| Input | engine | Indicator [DLM/TAB] parameter to specify the that is to be used to import the delimited file. The default value is: DLM. |
| Input | replace | Boolean [Y/N] to decide whether the output is to replace the information that is currently in the specified SAS dataset, or to be appended to the end of the already existing SAS dataset or table. The default value is: Y. |
| Input | sepchar | Specifies the two-character hexadecimal code for the separator character. The default value is 3B which represents a semicolon. Other possible values are for example 2C which represents a comma, or 09 which represents a tab as the separator character. The default value is: 3B. |
| Input | getnames | Boolean [Y/N] to decide whether to import the first record of the delimited file containing the column names. The default value is: Y. |
| Input | datarow | Optional parameter to specify the first record containing the data information. This parameter is only valid if the GETNAMES parameter is set to N. The default value is: 2. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Output SAS dataset or database table.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_txt2ds(?)
```

##### Example 2: Step 1 - Export a SAS dataset into a semicolon delimited TXT file:
```sas
proc export
   data=SASHELP.cars
   outfile="%sysfunc(getoption(WORK))/cars.txt"
   dbms=dlm
   replace;
   delimiter='3B'x;
run;
```

##### Example 2: Step 2 - Import the semicolon delimited file into a SAS dataset:
```sas
%m_utl_txt2ds(
   in_file = %str(%sysfunc(getoption(WORK))/cars.txt)
 , out_ds  = WORK.cars
 , engine  = dlm
 , debug   = Y
   );

proc print data=WORK.cars;
run;
```

##### Example 3: Step 1 - Export a SAS dataset into a tab delimited TXT file:
```sas
proc export
   data=SASHELP.cars
   outfile="%sysfunc(getoption(WORK))/cars.txt"
   dbms=dlm
   replace;
   delimiter='09'x;
run;
```

##### Example 3: Step 2 - Import the tab delimited file into a SAS dataset:
```sas
%m_utl_txt2ds(
   in_file = %str(%sysfunc(getoption(WORK))/cars.txt)
 , out_ds  = WORK.cars
 , engine  = tab
 , debug   = Y
   );

proc print data=WORK.cars;
run;
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
*This document was generated on 26.09.2023 at 15:42:00  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
