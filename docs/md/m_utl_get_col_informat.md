[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_get_col_informat.sas

### Utilities

##### Utility macro to obtain column informat attribute from a table.

***

### Description
The macro is used to obtain the attribute informat information from a given column in a table. The macro can be used to get the column informat from within a data step, or standalone. The result information is directly given back from the macro.



##### *Note:*
*In case of encrypted or access protected SAS datasets, ALTER=, ENCRYPTKEY=, PW=, READ or WRITE= SAS dataset options must be provided through the CREDS credentials parameter string value.*
*The SHOW_ERR parameter shows or suppresses possible warnings or errors in the log. The default for SHOW_ERR is value is N.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-08-23 00:00:00

### Version
* 24.1.08

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | table | Full LIBNAME.TABLENAME name of the or SAS dataset to get the column attribute information. The default value is: \_NONE\_. |
| Input | table_dsid | Parameter representing the SAS dataset or table identifier. The parameter contains the value of the table identifier when the table was already opened before calling this macro. The default value for TABLE_DSID is: 0. |
| Input | creds | Optional. Specifies the ENCRYPTKEY= parameter value when TABLE involves an encrypted, or PW=, ALTER=, READ= or WRITE= for a protected dataset. |
| Input | col_name | Parameter to specify the column attribute name. |
| Input | col | Alias of the COL_NAME= parameter. |
| Input | decimals | Optional. Parameter to specify the number of decimal positions in case the numeric format could not be defined. The DECIMALS parameter is considered when the DEFAULT parameter is set to Y, and the DECIMALS value is greater than 0, otherwise the BEST32 format value is set. The default value for DECIMALS is: 0. |
| Input | dec | Alias of the DECIMALS= parameter. |
| Input | default | Boolean [Y/N] parameter to specify if a format value is to be set case the format could not be found. The default value is: N. |
| Input | def | Alias of the DEFAULT= parameter. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The informat value for a given column.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_varlist.sas](m_utl_varlist.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_col_informat(?)
```

##### Example 2: Obtain column informat information for Monyr column of the SASHELP.prdsal2 table:
```sas
data WORK.result;
   Example=2;
   Table="SASHELP.prdsal2";
   Column='Monyr';
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsal2,col=Monyr,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 3: Obtain column informat information for Prodtype column of the SASHELP.prdsale table:
```sas
data WORK.result;
   Example=3;
   Table="SASHELP.prdsale";
   Column='Prodtype';
   Default='N';
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Prodtype,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 4: Obtain column informat information for Prodtype column of the SASHELP.prdsale table:
```sas
data WORK.result;
   Example=4;
   Table="SASHELP.prdsale";
   Column='Prodtype';
   Default='Y';
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Prodtype,def=Y,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 5: Obtain column informat information for Actual column of the SASHELP.prdsale table:
```sas
data WORK.result;
   Example=5;
   Table="SASHELP.prdsale";
   Column='Actual';
   Default='N';
   Decimals=0;
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Actual,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 6: Obtain column informat information for Actual column of the SASHELP.prdsale table:
```sas
data WORK.result;
   Example=6;
   Table="SASHELP.prdsale";
   Column='Actual';
   Default='Y';
   Decimals=0;
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Actual,def=Y,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

```

##### Example 7: Obtain column informat information for Actual column of the SASHELP.prdsale table:
```sas
data WORK.result;
   Example=7;
   Table="SASHELP.prdsale";
   Column='Actual';
   Default='Y';
   Decimals=2;
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Actual,def=Y,dec=2,debug=Y)";
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
*This document was generated on 2024.08.23 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
