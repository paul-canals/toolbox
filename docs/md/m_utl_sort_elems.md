![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_sort_elems.sas

### Utilities

##### Utility macro to sort words by a delimiter in a text string.

***

### Description
The macro reads a text string with a list of words as input, to be sorted alphabetically using the SORTC function call. With the MODE parameter value the sort order can be set to either Ascending or Descending on the result text string. The result list can be quoted by quoting each word within the text string and is separated by a delimiter which can be a blank or a comma.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-28 00:00:00

### Version
* 23.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | list | Character string containing a of words. The default value for LIST is: \_NONE\_. |
| Input | mode | Indicator [A/D] to specify the sort order of the words in the result text string. The sorting is either performed in A:Ascending or D:Descending order. The default value for MODE is: A. |
| Input | quoted | Boolean [Y/N] parameter to specify if each word in the output text string should to be quoted. The default value for QUOTED is: N. |
| Input | in_dlm | Indicator [BLANK/COMMA] to select the input delimiter type. The default value is: BLANK. |
| Input | out_dlm | Indicator [BLANK/COMMA] to select the output delimiter type. The default value is: BLANK. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Sorted list of words or numbers.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_sort_elems(?)
```

##### Example 2: Sort all words in the text string (blank):
```sas
%let list =
   %m_utl_sort_elems(
      list    = %str(Judy Joyce Jane Alice Janet Chris)
    , debug   = Y
      );

data WORK.result;
   length example 8 list $50.;
   example = 2;
   list = "Judy Joyce Jane Alice Janet Chris";
   output;
   example = 2;
   list = "&list.";
   output;
run;

proc print data=WORK.result;
run;

```

##### Example 3: Sort all words in the text string (comma):
```sas
%let list =
   %m_utl_sort_elems(
      list    = %str(Judy Joyce Jane Alice Janet Chris)
    , out_dlm = COMMA
    , debug   = Y
      );

data WORK.result;
   length example 8 list $50.;
   example = 3;
   list = "Judy Joyce Jane Alice Janet Chris";
   output;
   example = 3;
   list = "&list.";
   output;
run;

proc print data=WORK.result;
run;

```

##### Example 4: Sort all words in the text string (quoted):
```sas
%let list =
   %m_utl_sort_elems(
      list    = %str(Judy, Joyce, Jane, Alice, Janet, Chris)
    , quoted  = Y
    , in_dlm  = C
    , debug   = Y
      );

data WORK.result;
   length example 8 list $50.;
   example = 4;
   list = "Judy, Joyce, Jane, Alice, Janet, Chris";
   output;
   example = 4;
   list = "&list.";
   output;
run;

proc print data=WORK.result;
run;

```

##### Example 5: Sort all words in the text string (quoted,comma):
```sas
%let list =
   %m_utl_sort_elems(
      list    = %str(Judy, Joyce, Jane, Alice, Janet, Chris)
    , quoted  = Y
    , in_dlm  = C
    , out_dlm = C
    , debug   = Y
      );

data WORK.result;
   length example 8 list $50.;
   example = 5;
   list = "Judy, Joyce, Jane, Alice, Janet, Chris";
   output;
   example = 5;
   list = "&list.";
   output;
run;

proc print data=WORK.result;
run;

```

##### Example 6: Sort all numbers in the text string (comma):
```sas
%let str = %str(10 9 8 1 3 2 4 7 5 6);

data WORK.result;
   length example 8 list $50.;
   example = 6;
   list = "&str.";
   output;
   example = 6;
   list = "%m_utl_sort_elems(list=&str.,in_dlm=B,out_dlm=C)";
   output;
run;

proc print data=WORK.result;
run;

```

##### Example 7: Sort the text string in descending order (blank):
```sas
%let str = %str(10 9 8 1 3 2 4 7 5 6);

data WORK.result;
   length example 8 list $50.;
   example = 7;
   list = "&str.";
   output;
   example = 7;
   list = "%m_utl_sort_elems(list=&str.,in_dlm=B,mode=D)";
   output;
run;

proc print data=WORK.result;
run;

```

### Copyright
Copyright 2008-2023 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 12.02.2024 at 06:37:24  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
