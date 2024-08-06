![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_chk_installation.sas

### Utilities

##### Utility macro to check if Toolbox installation was successful.

***

### Description
The macro checks if the installation of the Utility Macros Toolbox was successful. The following checks are performed:

- (1-PRM) Check if Toolbox global parameters exists
- (2-VAL) Check if global parameter values are set
- (3-DIR) Check if Toolbox directories exists
- (4-CSV) Check if run_parameter_ctrl.csv file exists
- (5-PRM) Check if configuration parameters exists
- (6-PRM) Check if user specific parameters exists
- (7-VAL) Check if user parameter values are set
- (8-LIB) Check if user specific libraries exists



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-08-03 00:00:00

### Version
* 24.1.08

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | print | Boolean [Y/N] parameter to generate the output by a SAS proc report step with style HtmlBlue. The default value for PRINT is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Installation information in the Result output.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_chk_installation(?)
```

##### Example 2: Change a blank delimited list into a comma separated list:
```sas
%m_utl_chk_installation(
   print = Y
 , debug = Y
   );

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
*This document was generated on 2024.08.03 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
