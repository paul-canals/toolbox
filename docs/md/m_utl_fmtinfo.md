[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_fmtinfo.sas

### Utilities

##### Utility macro to get information about a SAS format or informat.

***

### Description
The program checks and returns information about formats that are supplied by SAS. It cannot be used for user-defined formats that are created with the FORMAT procedure. The format type information specifies the type of information that is returned.

 Format-information can be one of the following values:

 CAT: returns the format category name
 CHK: returns if the given format value is valid
 TYPE: returns the format or informat type
 DESC: returns a short format or informat description
 MINW: the minimum width value of the format or informat
 MAXW: the maximum width value of the format or informat
 DEFW: the default width value of the format or informat
 MIND: the minimum number of decimal value digits
 MAXD: the maximum number of decimal value digits
 DEFD: the default number of decimal value digits

 This macro is originally based on the ut_fmt2type.sas macro program by Dave Prinsloo (dave.prinsloo@yahoo.com)



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-05-05 00:00:00

### Version
* 24.1.05

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | format | Input SAS or in name value to be checked. The default value is: \_NONE\_. |
| Input | type | Optional. Specifies the TYPE= parameter value indicator that specifies the type of information that is returned. The default value is CAT, and returns the format category. When CHK it returns VALID if the format width, decimal and type values are correct, or INVALID in case of invalid format value(s). When TYPE, the routine returns whether the format-name is a format, an informat, or both. When DESC, it returns a short description of the format or informat. When TYPE is MINW, MAXW, MIND, MAXD it returns the min or max format width or decimal value. The default value is: CAT. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Result inline checked format or informat type value.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_fmtinfo(?)
```

##### Example 2: Check the format category type value for DATE9.:
```sas
%let fmtcat =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = CAT
    , debug  = Y
      );

%put &=fmtcat.;

```

##### Example 3: Check the given format value is valid for DATE9.:
```sas
%let fmtcat =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = CHK
      );

%put &=fmtcat.;

```

##### Example 4: Check the format or informat type value for DATE9.:
```sas
%let fmttype =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = TYPE
      );

%put &=fmttype.;

```

##### Example 5: Check the format or informat description for DATE9.:
```sas
%let fmtdesc =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = DESC
      );

%put &=fmtdesc.;

```

##### Example 6: Check the default width information for DATE9.:
```sas
%let fmtdefw =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = DEFW
      );

%put &=fmtdefw.;

```

##### Example 7: Check the default decimal information for DATE9.:
```sas
%let fmtdefd =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = DEFD
      );

%put &=fmtdefd.;

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
*This document was generated on 2024.05.05 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
