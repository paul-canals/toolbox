# File Reference: m_utl_csv2ds.sas

### Utilities

##### Utility macro to import a CSV file into SAS datasets or tables.

***

### Description
This program converts an external comma separated file with an CSV extension into a SAS datasets or database table.

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
| Input | in_file | Specifies the name and location of the external comma separated file with CSV extension. The default value is: \_NONE\_. |
| Input | out_ds | Specifies the full LIBNAME.TABLENAME name of the output SAS dataset or database table. The default value is: \_NONE\_. |
| Input | engine | Indicator [CSV] parameter to specify the that is to be used to the comma separated file. The default and only valid value is: CSV. |
| Input | replace | Boolean [Y/N] to decide whether the output is to replace the information that is currently in the specified SAS dataset, or to be appended to the end of the already existing SAS dataset or table. The default value is: Y. |
| Input | getnames | Boolean [Y/N] to decide whether to import the first record of the CSV file containing the column names. The default value is: Y. |
| Input | datarow | Optional parameter to specify the first records containing the data information. This parameter is only valid if the GETNAMES parameter is set to N. The default value is: 2. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Output SAS dataset or database table

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_csv2ds(?)
```

##### Example 2: Step 1 - Export the CARS table to a CSV file named cars.csv:
```sas
proc export
   data=SASHELP.cars
   dbms=csv
   outfile="%sysfunc(getoption(WORK))/cars.csv"
   replace;
run;
```

##### Example 2: Step 2 - Import the cars.csv file into a SAS dataset:
```sas
%m_utl_csv2ds(
   in_file=%str(%sysfunc(getoption(WORK))/cars.csv)
 , out_ds  = WORK.cars
 , engine  = csv
 , replace = Y
 , debug   = Y
   );

proc print data=WORK.cars;
run;
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
*This document was generated on 27.09.2021 at 15:28:26  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
