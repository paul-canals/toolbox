![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: f_demo_translation.sas

### Functions

##### Custom function to demonstrate how user defined functions work.

***

### Description
The function can be called in a datastep, and has one argument called TEXT. When the function is called with the text YES/NO, then the function returns SI/NO.

##### *Note:*
*To use this function and others, either the PROC FCMP procedure statement must be included when running this script, or called by the run_functs_compilation.sas script to create the function container under: /toolbox/source/sas/misc/scripts/.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-01 hh:mm:ss

### Version
* 23.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | word | Textual string to call the function. The default valid values are: [yes/no] |

### Returns
* The translation of the english words yes/no in spanish.

### Calls
* None

### Usage

##### Example 1: Translate yes into spanish
```sas
proc fcmp outlib=WORK.funcs.demo; ;
   function f_demo_translation(word $) $ 12;
      if lowcase(x) eq "yes" then return('Si');
      else return('No!');
   endsub;
quit;

options cmplib=WORK.functs;

data _null_;
   rc = f_demo_translation('yes');
   put rc=;
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
*This document was generated on 03.10.2023 at 07:37:45  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
