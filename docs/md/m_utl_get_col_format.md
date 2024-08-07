![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_get_col_format.sas

### Utilities

##### Utility macro to obtain column format attribute from a table.

***

### Description
The macro is used to obtain the attribute format information from a given column in a table. The macro can be used to get the column format from within a data step, or used standalone. The result information is directly given back from the macro.



##### *Note:*
*In case of encrypted or access protected SAS datasets, ALTER=, ENCRYPTKEY=, PW=, READ or WRITE= SAS dataset options must be provided through the CREDS credentials parameter string value.*
*The SHOW_ERR parameter shows or suppresses possible warnings or errors in the log. The default for SHOW_ERR is value is N.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-05-13 00:00:00

### Version
* 24.1.05

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | table | Full LIBNAME.TABLENAME name of the or SAS dataset to get the column attribute information. The default value for TABLE is: \_NONE\_. |
| Input | table_dsid | Parameter representing the SAS dataset or table identifier. The parameter contains the value of the table identifier when the table was already opened before calling this macro. The default value for TABLE_DSID is: 0. |
| Input | creds | Optional. Specifies the ENCRYPTKEY= parameter value when TABLE involves an encrypted, or PW=, ALTER=, READ= or WRITE= for a protected dataset. |
| Input | col_name | Parameter to specify the column attribute name. |
| Input | col | Alias of the COL_NAME= parameter. |
| Input | decimals | Parameter to specify the number of in case the numeric format could not be defined. The default value for DECIMALS is: 1. |
| Input | dec | Alias of the DECIMALS= parameter. |
| Input | default | Boolean [Y/N] parameter to specify if a format value is to be set case the format could not be found. The default value is: N. |
| Input | def | Alias of the DEFAULT= parameter. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The format value for a given column.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_varlist.sas](m_utl_varlist.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_col_format(?)
```

##### Example 2: Obtain column format information for Actual column of the SASHELP.prdsale table:
```sas
data WORK.result;
   Table="SASHELP.prdsale";
   Column='Actual';
   Format="%m_utl_get_col_format(table=SASHELP.prdsale,col=Actual,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 3: Obtain column format information for Prodtype column of the SASHELP.prdsale table:
```sas
data WORK.result;
   Table="SASHELP.prdsale";
   Column='Prodtype';
   Format="%m_utl_get_col_format(table=SASHELP.prdsale,col=Prodtype,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 4: Obtain column format information for Invioce column of the SASHELP.cars table:
```sas
data WORK.result;
   Table="SASHELP.cars";
   Column='Invoice';
   Format="%m_utl_get_col_format(table=SASHELP.cars,col=Invoice,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

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
*This document was generated on 2024.05.13 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
