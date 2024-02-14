![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_chg_delimiter.sas

### Utilities

##### Utility macro to replace a delimited list with a new delimiter.

***

### Description
The macro replaces all specified delimiters from an input text string with a new specified delimiter string. If the IN_DLM parameter value contains multiple characters, then any instance of the detected character will be replaced by the specified OUT_DLM parameter value. If OUT_DLM contains multiple characters then all the characters will be used as one delimiter. If the OUT_DLM parameter value is a blank, then the macro works like the compress function. Furthermore the result list can be quoted by setting either single or double quotation marks. This macro is originally based on the ut_chg_dlm.sas macro program by Dave Prinsloo (dave.prinsloo@yahoo.com)

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-10-22 00:00:00

### Version
* 20.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | list | Character string containing a textual of words separated by any delimiter or delimiter combination. The default value for LIST is: \_NONE\_. |
| Input | in_dlm | Input list of one or more delimiters. The default value for IN_DLM is a _blank_. |
| Input | out_dlm | Output delimiter text string. The default value for OUT_DLM is a _comma_. |
| Input | quotes | Indicator [NO/YES/SINGLE] to select the output quoted list type. _YES_ adds double quotes, and _SINGLE_ adds single quotes around the complete result list. The default value is: NO. |
| Input | dlm | Alias of the IN_DLM= parameter. |
| Input | newdlm | Alias of the OUT_DLM= parameter. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Result delimited list.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_chg_delimiter(?)
```

##### Example 2: Change a blank delimited list into a comma separated list:
```sas
proc sql noprint;
   select Name
     into :girls separated by ' '
     from SASHELP.class
    where Sex='F'
   ;
quit;

%put &=girls.;

%let list=
   %m_utl_chg_delimiter(
      list   = %str(&girls.)
    , newdlm = %str(, )
    , debug  = Y
      );

%put &=list.;

```

##### Example 3: Change a blank delimited list into a single quoted and comma separated list:
```sas
proc sql noprint;
   select Name
     into :girls separated by ' '
     from SASHELP.class
    where Sex='F'
   ;
quit;

%put &=girls.;

%let list=
   %m_utl_chg_delimiter(
      list   = %str(&girls.)
    , newdlm = %str(', ')
    , quotes = SINGLE
    , debug  = Y
      );

%put &=list.;

proc print data=SASHELP.class(where=(Name in (&list.)));
run;

```

##### Example 4: Change a multi separated list into a single comma separated list:
```sas
%let list=
   %m_utl_chg_delimiter(
      list   = %str(James,Jeffrey#John Philip,Robert)
    , dlm    = %str(,# )
    , newdlm = %str(", ")
    , quotes = Y
    , debug  = Y
      );

%put &=list.;

proc print data=SASHELP.class(where=(Name in (&list.)));
run;

```

##### Example 5: Change a name-quotes comma separated list into a blank separated list:
```sas
data WORK.class;
   set SASHELP.class;
   rename
      name = 'Name (Student)'n
      sex  = 'Gender (F/M)'n
      age  = 'Age (Years)'n
      ;
run;

%let list=
   %m_utl_chg_delimiter(
      list   = %str('Name (Student)'n,'Gender (F/M)'n,'Age (Years)'n)
    , dlm    = %str(,)
    , newdlm = %str( )
    , quotes = N
    , debug  = Y
      );

%put &=list.;

proc print data=WORK.class (keep=&list.);
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
*This document was generated on 2020.10.22 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
