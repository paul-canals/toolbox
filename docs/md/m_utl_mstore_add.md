![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_mstore_add.sas

### Utilities

##### Utility macro to compile a SAS macro into a SAS macro catalog.

***

### Description
This program compiles a given macro program into a SAS macro catalog using the store secure option. After macro compilation, it is not possible to recreate the original source statements. To be able to change the macro again, the code statments must be saved and documented outside the secured SAS macro catalog.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-03-20 00:00:00

### Version
* 24.1.03

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | infile | Specifies the name and location of the SAS macro file.The default value is: \_NONE\_. |
| Input | outdir | Specifies the full path to the output SAS macro catalog. The default value is: \_NONE\_. |
| Input | compile | Boolean [Y/N] to specify whether to the program macro into the given SAS macro catalog. The default value is: Y. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* SAS macro added to a SAS macro catalog.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_mstore_add(?)
```

##### Example 2: Step 1 - Create a simple SAS macro program:
```sas
filename test "%sysfunc(getoption(WORK))/test.sas";

data _null_;
   file test;
   put '%***************************************;';
   put '%* Test macro to print Hello World.     ;';
   put '%***************************************;';
   put '%macro test; ';
   put '   %*Simple comment ; ';
   put '   %put Hello World!; ';
   put '%mend test; ';
run;

%include "%sysfunc(getoption(WORK))/test.sas";
%test
```

##### Example 2: Step 2 - Add TEST.SAS to the macro catalog:
```sas
%m_utl_mstore_add(
   infile  = %sysfunc(getoption(WORK))/test.sas
 , outdir  = %sysfunc(getoption(WORK))/catalog
 , compile = Y
 , print   = Y
 , debug   = Y
   );
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
*This document was generated on 2024.03.20 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
