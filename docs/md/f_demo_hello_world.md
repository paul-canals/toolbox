![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: f_demo_hello_world.sas

### Functions

##### Custom function to demonstrate how user defined functions work.

***

### Description
The function can be called in a datastep, and has one argument called TEXT. When the function is called with the text HELLO?, then the function returns HELLO-WORLD!.

##### *Note:*
*To use this function and others, either the PROC FCMP procedure statement must be included when running this script, or called by the run_functs_compilation.sas script to create the function container under: /toolbox/source/sas/misc/scripts/.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-01 00:00:00

### Version
* 23.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | text | Textual string to call the function. The default value is: Hello? |

### Returns
* The functions answer to the question who is there.

### Calls
* None

### Usage

##### Example 1: Show Hello reaction function
```sas
proc fcmp outlib=WORK.functs.demo;
   function f_demo_hello_world(text $) $ 100;
      if lowcase(text) eq 'hello?' then do;
         return(cat(compress(text,'?'),'-','World!'));
      end;
      else do;
         return('Who are you?');
      end;
   endsub;
quit;

options cmplib=WORK.functs;

data _null_;
   rc = f_demo_hello_world('Hello?');
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
*This document was generated on 12.02.2024 at 05:21:35  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
