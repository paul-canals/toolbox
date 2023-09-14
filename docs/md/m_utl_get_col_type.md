![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_get_col_type.sas

### Utilities

##### Utility macro to obtain column type attribute from a table.

***

### Description
The macro is used to obtain the attribute type information from a given column in a table. The macro can be used to get the column type from within a data step, or standalone. The result information is directly given back from the macro.

##### *Note:*
*The SHOW_ERR parameter shows or suppresses possible warnings or errors in the log. The default for SHOW_ERR is value is N.*
*In case of encrypted SAS datasets, the ENCRYPTKEY= parameter must be provided as part of the CREDS credentials string.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-23 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | table | Full LIBNAME.TABLENAME name of the or SAS dataset to get the column attribute information. The default value is: \_NONE\_. |
| Input | table_dsid | Parameter representing the SAS dataset or table identifier. The parameter contains the value of the table identifier when the table was already opened before calling this macro. The default value for TABLE_DSID is: 0. |
| Input | creds | Optional. Specifies the ENCRYPTKEY= parameter value if DATASET involves an encrypted dataset. |
| Input | col_name | Parameter to specify the column attribute name. |
| Input | col | Alias of the COL_NAME= parameter. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Type [CHAR|DATE|DATETIME|NUM|TIME] for a given column.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_varlist.sas](m_utl_varlist.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_col_type(?)
```

##### Example 2: Obtain column type information for Name column of the SASHELP.class table:
```sas
data WORK.result;
   Table="SASHELP.class";
   Column='Name';
   Type="%m_utl_get_col_type(table=SASHELP.class,col=Name,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 3: Obtain column type information for Prodtype column of the SASHELP.prdsale table:
```sas
data WORK.result;
   Table="SASHELP.prdsale";
   Column='Prodtype';
   Type="%m_utl_get_col_type(table=SASHELP.prdsale,col=Prodtype,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 4: Obtain column type information for Invioce column of the SASHELP.cars table:
```sas
data WORK.result;
   Table="SASHELP.cars";
   Column='Invoice';
   Type="%m_utl_get_col_type(table=SASHELP.cars,col=Invoice,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
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
*This document was generated on 13.09.2023 at 15:26:22  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
