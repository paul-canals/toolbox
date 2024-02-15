![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_uc_binary_heart.sas

### Custom

##### Custom macro to create a valentines day binary heart graph card.

***

### Description
The macro generates a radom binary heart, similar to xkcd comic post (http://xkcd.com/99/), using parametric expression by Rick
 Wicklin (r=2-2*sin(t)+sin(t)#sqrt(abs(cos(t)))/(sin(t)+1.4)) at
 blogs.sas.com/content/iml/2011/02/14/a-parametric-view-of-love

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-02-14 00:00:00

### Version
* 24.1.02

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | to | Full name of the person the Heart is meant for. The default value for TO is: \_NONE\_. |
| Input | from | Full name of the person the heart is sent from. The default value for FROM is: \_NONE\_. |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value for DEBUG is: N. |

### Returns
* Binary shaped valentines day heart graph.

### Calls
* None

### Usage

##### Example 1: Show help information:
```sas
%m_uc_binary_heart(?)
```

##### Example 2: Create a binary valentines day heart for SAS:
```sas
%m_uc_binary_heart(
   to     = SAS
 , from   = Paul
 , print  = Y
 , debug  = N
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
*This document was generated on 2024.02.14 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
