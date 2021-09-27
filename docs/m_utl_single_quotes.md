# File Reference: m_utl_single_quotes.sas

### UTILITY

##### Utility macro to add single quotes around a textual string.

***

### Description
The macro takes a string or SAS macro variable as input and then transfers it by adding single quotes around it. This macro is originally based on the ut_single_quote.sas macro program by Dave Prinsloo (dave.prinsloo@yahoo.com)

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-07 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | text | Input character string or SAS macro variable. The default value is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Quoted string of words or numbers.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_single_quotes(?)
```

##### Example 2: Select entry for Alice from Class dataset:
```sas
%let text=
   %m_utl_single_quotes(
      text  = Alice
    , debug = Y
      );

data WORK.class;
   set SASHELP.class;
   where Name eq &text.;
run;

proc print data=WORK.class;
run;

```

##### Example 3: Select all male names from Class dataset:
```sas
%let male=%quote(M);

data WORK.class;
   set SASHELP.class;
   where Sex eq %m_utl_single_quotes(text=&male.);
run;

proc print data=WORK.class;
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
*This document was generated on 27.09.2021 at 15:29:22  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
