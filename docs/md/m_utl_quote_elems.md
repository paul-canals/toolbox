![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_quote_elems.sas

### Utilities

##### Utility macro to create a quoted and delimited list of words.

***

### Description
The macro reads a string with a list of words as input which can be delimited with a blank or comma. The list is transferred by quoting each word within the string and is separated by a delimiter. This output delimiter can be a blank or a comma. This macro is originally based on the ut_quote_elems.sas macro program by Dave Prinsloo (dave.prinsloo@yahoo.com)

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2022-10-22 00:00:00

### Version
* 22.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | list | Character string containing a of words. The default value is: \_NONE\_. |
| Input | in_dlm | Indicator [BLANK/COMMA] to select the input delimiter type. The default value is: BLANK. |
| Input | out_dlm | Indicator [BLANK/COMMA] to select the output delimiter type. The default value is: COMMA. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Quoted string of words or numbers.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_quote_elems(?)
```

##### Example 2: Select all female names from Class dataset:
```sas
%let list=
   %m_utl_quote_elems(
      list    = %str(Alice, Jane, Janet, Joyce, Judy)
    , in_dlm  = COMMA
    , out_dlm = COMMA
    , debug   = Y
      );

data WORK.class;
   set SASHELP.class;
   where Name in (&list.);
run;

proc print data=WORK.class;
run;

```

##### Example 3: Select all male names from Class dataset:
```sas
%let list=
   %m_utl_quote_elems(
      list    = %str(Alfred Henry Jeffrey James John)
    , in_dlm  = BLANK
    , out_dlm = COMMA
    , debug   = Y
      );

data WORK.class;
   set SASHELP.class;
   where Name in (&list.);
run;

proc print data=WORK.class;
run;

```

##### Example 4: Quote a list of numeric numbers:
```sas
%let list=
   %m_utl_quote_elems(
      list    = %str(1 2 3 4 5 6 7 8 9)
    , in_dlm  = BLANK
    , out_dlm = COMMA
    , debug   = Y
      );

%put &=list.;

```

##### Example 5: Quote a list of numeric numbers:
```sas
%let list=
   %m_utl_quote_elems(
      list    = %str(1, 2, 3, 4, 5, 6, 7, 8, 9)
    , in_dlm  = COMMA
    , out_dlm = BLANK
    , debug   = Y
      );

%put LIST=(&list.);

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
*This document was generated on 13.09.2023 at 15:27:09  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
