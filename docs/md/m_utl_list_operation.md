![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_list_operation.sas

### Utilities

##### Utility macro to perform list operation on sets of word lists.

***

### Description
The macro performs Union, Intersection, Difference operation on sets represented by word lists. When the argument operation is set to Union, the macro combines the Left and Right set items. When set to Intersection, only items listed in both sets are kept. When set to Difference only the items missing in the right set (compared to the left set) are kept. The output list can be modified by adding a comma delimiter between each result item. Left(A B) \/ right(B C) Operation: Union \-> result: A B C
 Left(A B) \/ right(B C) Operation: Intersection \-> result: B
 Left(A B) \/ right(B C) Operation: Difference \-> result: A
 This macro is originally based on the ut_list_operation.sas macro program by Dave Prinsloo (dave.prinsloo@yahoo.com)

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
| Input | leftlist | Character string containing the left word list. The default value is: \_NONE\_. |
| Input | rightlist | Character string containing the right word list. The default value is: \_NONE\_. |
| Input | operation | Indicator [Union/Intersection/Difference] to select the list operation type. The default value is: Union. |
| Input | left | Alias of the _leftlist_ parameter. |
| Input | right | Alias of the _rightlist_ parameter. |
| Input | op | Alias of the _operation_ parameter. |
| Input | in_dlm | Indicator [BLANK/COMMA] to select the input delimiter type. The default value is: BLANK. |
| Input | out_dlm | Indicator [BLANK/COMMA] to select the output delimiter type. The default value is: BLANK. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Result operation word list.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_list_operation(?)
```

##### Example 2: The Union between Left(A B) and Right(B C) list:
```sas
%let result=
   %m_utl_list_operation(
      left      = %str(A B)
    , right     = %str(B C)
    , operation = Union
    , in_dlm    = BLANK
    , out_dlm   = COMMA
    , debug     = Y
      );

%put The Union between Left(A B) and Right(B C) list is: (&result.);

```

##### Example 3: The Intersection between Left(A,B) and Right(B,C) list:
```sas
%let result=
   %m_utl_list_operation(
      left      = %str(A,B)
    , right     = %str(B,C)
    , operation = Intersection
    , in_dlm    = COMMA
    , out_dlm   = BLANK
    , debug     = Y
      );

%put The Intersection between Left(A,B) and Right(B,C) list is: (&result.);

```

##### Example 4: The Difference between Left(A B) and Right(B C) list:
```sas
%let result=
   %m_utl_list_operation(
      left      = %str(A B)
    , right     = %str(B C)
    , operation = Difference
    , debug     = Y
      );

%put The Difference between left(A B) and right(B C) list is: (&result.);

```

##### Example 5: The Difference between Left(/bic/A /bic/B) and Right(/bic/B) list:
```sas
%let result=
   %m_utl_list_operation(
      left      = %str('/bic/A'n '/bic/B'n)
    , right     = %str('/bic/B'n)
    , operation = Difference
    , debug     = Y
      );

%put The Difference between left(/bic/A /bic/B) and right(/bic/B) list is: (&result.);

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
*This document was generated on 26.09.2023 at 15:41:31  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
