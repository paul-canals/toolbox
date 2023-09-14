![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_reg_table_meta.sas

### Utilities

##### Utility macro to register a table or view in SAS metadata.

***

### Description
This macro can be used to register a table or view in SAS metadata, using the PROC METALIB procedure. This creates and updates SAS metadata in the SAS Metadata Repository to match the given data source.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-01-25 00:00:00

### Version
* 21.1.01

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | libnm | Parameter to specify the metadata library name or library reference name. The library name is checked against the SAS metadata repository to verify its existance, and to obtain the libref value. The default value for LIBNM is: \_NONE\_. |
| Input | tblnm | Parameter to specify the given table or view to be registered in SAS metadata. The default value for TBLNM is: \_NONE\_. |
| Input | folder | Optional. Parameter to specify the given output meta folder path in which the table TBLNM is to be created to. If a value is omitted, the table definition will be created in the same folder as the specified LIBNM library definition. |
| Input | match | Boolean [Y/N] parameter to specify the report output contents. If MATCH is set to Y, than the report includes a list of tables whose metadata matches their data sources (that is, they require no metadata changes). By default, the report does not include a list of these matching tables, but it does include the number of matching tables. The default value for MATCH is: N. |
| Input | check | Boolean [Y/N] parameter to specify wether only to check which changes that your request would make to the metadata before you commit to making those changes. If set to Y, the summary will be printed by setting the PRINT argument to Y. The default value for CHECK is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* A dataset, table or view registered in SAS metadata.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_reg_table_meta(?)
```

##### For the next examples create a view in library SASApp - SASDATA:
```sas
data SASDATA.class /view=SASDATA.class;
   set SASHELP.class;
run;
```

##### Example 2: Check if the SAS view CLASS is registered in metadata:
```sas
%m_utl_reg_table_meta(
   libnm = SASApp - SASDATA
 , tblnm = class
 , match = Y
 , check = Y
 , debug = Y
   )
```

##### Example 3: Register the SAS view CLASS into user metadata folder:
```sas
%m_utl_reg_table_meta(
   libnm  = SASApp - SASDATA
 , tblnm  = class
 , folder = /User Folders/&sysuserid./My Folder
 , print  = Y
 , debug  = Y
   )

libname TMP meta liburi="SASLibrary?@name='SASAPP - SASDATA'";

proc print data=TMP.class label noobs;
run;

libname TMP clear;
```

### Copyright
Copyright 2008-2021 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 13.09.2023 at 15:27:12  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
