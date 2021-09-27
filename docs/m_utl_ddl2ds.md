# File Reference: m_utl_ddl2ds.sas

### Utilities

##### Utility macro to import a DDL file to create a SAS dataset.

***

### Description
This program executes an DDL file to create a SAS dataset. The macro is able to handle parameterized custom library rerefence name (libref), custom dataset name (table) and dataset encryption (creds) using the PRM macro call values.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-04-04 00:00:00

### Version
* 20.1.04

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_file | Specifies the name and location of the external DDL file with SAS extension. The default value for IN_FILE is: \_NONE\_. |
| Input | in_enc | Optional. Specifies the original encoding value of the IN_FILE source file. |
| Input | prm_flg | Boolean [Y/N] parameter to specify wether the input DDL contains the identical libref, table name, and credentials as required or set to parameterize this information by using macro variables instead. If PRM_FLG=Y, the library name, table name and optional credentials are replaced by the PRM_LIB, PRM_TBL, and PRM_CREDS values. The default value is: N. |
| Input | prm_lib | Optional. Parameter to specify a value for the custom macro variable LIBREF in the DDL file. |
| Input | prm_tbl | Optional. Parameter to specify a value for the custom macro variable TABLE in the DDL file. |
| Input | prm_creds | Optional. Parameter to specify a value for the custom macro variable CREDS in the DDL file. The following parameter value syntax is to be respected to work properly: encrypt=aes encryptkey= |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Output SAS dataset based on the DDL file.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_ddl2ds(?)
```

##### Example 2: Step 1 - Create a Data Definition Language file for table class:
```sas
filename class "%sysfunc(getoption(WORK))/ddl_class.sas";

data _null_;
   file class;
   put 'proc sql noprint feedback stimer;';
   put '   create table WORK.class  (';
   put '      Name      VARCHAR(8)';
   put '    , Sex       VARCHAR(1)';
   put '    , Age       NUMERIC(8)';
   put '    , Height    NUMERIC(8)';
   put '    , Weight    NUMERIC(8)';
   put '      );';
   put '   create index Name on WORK.class (Name);';
   put 'quit;';
run;

data _null_;
   infile class;
   input;
   put _infile_;
run;
```

##### Example 2: Step 2 - Import the Data Definition Language file to create class:
```sas
%m_utl_ddl2ds(
   in_file = %str(%sysfunc(getoption(WORK))/ddl_class.sas)
 , print   = Y
 , debug   = Y
   );
```

##### Example 3: Step 1 - Create a Data Definition Language file for table class:
```sas
filename class "%sysfunc(getoption(WORK))/ddl_class.sas";

data _null_;
   file class;
   put 'proc sql noprint feedback stimer;';
   put '   create table &libref..class  (';
   put '      Name      VARCHAR(8)';
   put '    , Sex       VARCHAR(1)';
   put '    , Age       NUMERIC(8)';
   put '    , Height    NUMERIC(8)';
   put '    , Weight    NUMERIC(8)';
   put '      );';
   put '   create index Name on &libref..class (Name);';
   put 'quit;';
run;

data _null_;
   infile class;
   input;
   put _infile_;
run;
```

##### Example 3: Step 2 - Import the Data Definition Language file to create class:
```sas
%m_utl_ddl2ds(
   in_file = %str(%sysfunc(getoption(WORK))/ddl_class.sas)
 , prm_flg = Y
 , prm_lib = WORK
 , print   = Y
 , debug   = Y
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
*This document was generated on 27.09.2021 at 15:28:27  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
