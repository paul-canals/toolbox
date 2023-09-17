![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_get_attrn.sas

### Utilities

##### Utility macro to return a numerical attribute of a SAS dataset.

***

### Description
The macro can be used to obtain numerical attribute information of a SAS DATASET. The following is a list of valid numerical SAS dataset attribute names:
 ALTERPW
 ANOBS
 ANY
 ARAND
 ARWU
 AUDIT
 AUDIT_DATA
 AUDIT_BEFORE
 AUDIT_ERROR
 CRDTE
 ICONST
 INDEX
 ISINDEX
 ISSUBSET
 LRECL
 LRID
 MAXGEN
 MAXRC
 MODTE
 NDEL
 NEXTGEN
 NLOBS
 NLOBSF
 NOBS
 NVARS
 PW
 RADIX
 READPW
 REUSE
 TAPE
 VAROBS
 WHSTMT
 WRITEPW


##### *Note:*
*The SHOW_ERR parameter shows or suppresses possible warnings or errors in the log. The default is value is N.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-07 00:00:00

### Version
* 20.1.07

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | intable | Full qualified LIBNAME.TABLENAME name of the source database table or SAS dataset. The default value for INTABLE is: \_NONE\_. |
| Input | attr_nm | Parameter to specify the name of the SAS data set attribute whose numeric value is returned. If the value of ATTR_NM is invalid, a missing value is returned and optionally a warning or error message will be written in the SAS log. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Returns the result of the attrn value supplied.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_attrn(?)
```

##### Example 2: Get the number of observations in a SAS dataset (ignores WHERE statement):
```sas
%let numobs =
   %m_utl_get_attrn(
      intable = SASHELP.class (where=(Sex eq 'F'))
    , attr_nm = NLOBS
    , debug   = Y
      );

%put &=numobs.;

```

##### Example 3: Get the number of columns in a SAS dataset:
```sas
%let numcols =
   %m_utl_get_attrn(
      intable = SASHELP.class
    , attr_nm = NVARS
    , debug   = Y
      );

%put &=numcols.;

```

##### Example 4: Check if the SAS dataset is password protected:
```sas
%let pwdexist =
   %m_utl_get_attrn(
      intable = SASHELP.class
    , attr_nm = PW
    , debug   = Y
      );

%put &=pwdexist.;

data WORK.class (pw=password);
   set SASHELP.class;
run;

%let pwdexist =
   %m_utl_get_attrn(
      intable = WORK.class (pw=password)
    , attr_nm = PW
    , debug   = Y
      );

%put &=pwdexist.;

proc datasets lib=WORK nolist nowarn;
   modify class(pw=password/);
   delete class;
quit;

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
*This document was generated on 13.09.2023 at 19:03:07  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
