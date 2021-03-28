![../misc/images/doc_banner.png](../misc/images/doc_banner.png)
# 
# File Reference: m_utl_ds2xpt.sas

### Utilities

##### Utility macro to export a SAS dataset to a XPT transport file.

***

### Description
This program converts a SAS dataset into a SAS transport (XPT) file. This is a method to transport datasets independently from one operating system or host to another or different system.

##### *Note:*
*Note that if the data set is V5 compliant, all variable names will be upcased when stored in the V5 transport file. This is consistent with the XPORT engine. If the SAS dataset name contains over 8 characters, or if any variable name exceeds 8 characters, or has any characters that are not letters, digits, or underscore, or if any character variable exceeds length 200, then a V5 transport file cannot be created. If AUTO is in effect then V8 format will be assumed in such cases. If any format or informat name exceeds a length of 8 characters, then V9 format will be assumed in such cases.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-04-04 00:00:00

### Version
* 20.1.04

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | base_ds | Full LIBNAME.TABLENAME name of the SAS dataset. The default value is: \_NONE\_. |
| Input | xpt_file | Specifies the name of the XPT transport file and path to which the file is to be written. If the file that you specify does not exist, then it will be created for you. The default value for XPT_FILE is: \_NONE\_. |
| Input | format | Indicator [V5/V8/V9/AUTO] parameter to specify the format of the transport file. Valid values are: V5 (for V5 transport), V8 (for V8 extended transport), V9 (for V9 extended transport) or AUTO (format is determined by BASE_DS data). The default value for FORMAT is: AUTO. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Output XPT transport file.

### Calls
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_ds2xpt(?)
```

##### Example 2: Create a XPT transport file from SASHELP.class:
```sas
%m_utl_ds2xpt(
   base_ds  = SASHELP.class
 , xpt_file = %str(%sysfunc(getoption(WORK))/class.xpt)
 , format   = AUTO
 , debug    = Y
   );

filename class "%sysfunc(getoption(WORK))/class.xpt";

data _null_;
   infile class;
   input;
   put _infile_;
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
*This document was generated on 28.03.2021 at 09:55:13  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.03)*
