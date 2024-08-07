![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_ds2txt.sas

### Utilities

##### Utility macro to export a SAS dataset into a delimited TXT file.

***

### Description
This program converts a SAS dataset into a comma or tab separated file using SAS proc export DLM/TAB engine with the TXT extension.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-04-24 00:00:00

### Version
* 24.1.04

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | base_ds | Full LIBNAME.TABLENAME name of the SAS dataset. The default value is: \_NONE\_. |
| Input | txt_file | Specifies the name of the delimited file and path where the formatted output is to be written. If the specified file or path does not exist, then it is created for you. The default value is: \_NONE\_. |
| Input | engine | Indicator [DLM/TAB] parameter to specify the that is to be used for the comma separated file. The default value is: DLM. |
| Input | newfile | Parameter to specify when exporting a SAS dataset to an existing delimited file, whether to delete the delimited file and load the data to a new file. Y specifies that the export procedure deletes the specified delimited file, if it exists. Loads the SAS dataset to new delimited file. N specifies that the export procedure loads the SAS dataset to an existing delimited file. If the file does not exist a delimited file is created, and the SAS dataset is loaded. The default value is: N. |
| Input | replace | Boolean [Y/N] to decide whether the new output replaces the information that is currently in the specified file. The default value is: Y. |
| Input | labels | Boolean [Y/N] parameter to indicate whether to use the variable labels that are defined in the the dataset as your column headings. Case where a variable does not have a SAS label, then the the name of the variable is used instead. The default value is: N. |
| Input | sepchar | Specifies the two-character hexadecimal code for the separator character. The default value is 3B which stands for semi-colon. Other values values are 09 (tab), 20 (space), 2C (comma), or 3A (colon) as the separator character. The default value for SEPCHAR is: 3B. |
| Input | password | Specifies the that is needed to access a password-protected dataset. This argument is required if the dataset has READ or PW password. There is no need to specify this argument if the dataset has only WRITE or ALTER passwords set. |
| Input | varlist | Specifies the variables that are to be included in the file and the order in which they should be included. To include all of the variables in the data set, do not specify this argument. If you want to include only a subset of all the variables, then list each variable name and use single blank spaces to separate the variables. Do not use a comma in the list of variable names. |
| Input | where | Specifies a valid WHERE clause that selects observations from the SAS dataset. Using this argument subsets your data based on the criteria that you supply for where-expression. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Output TXT file.

### Calls
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_delete_file.sas](m_utl_delete_file.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_ds2txt(?)
```

##### Example 2: Create a new TXT file from SASHELP.class:
```sas
%m_utl_ds2txt(
   base_ds  = SASHELP.class
 , txt_file = %str(%sysfunc(getoption(WORK))/class.txt)
 , engine   = DLM
 , debug    = Y
   );
```

##### Example 3: Create a TXT file from SASHELP.class with variable selection:
```sas
%m_utl_ds2txt(
   base_ds  = SASHELP.class
 , txt_file = %str(%sysfunc(getoption(WORK))/class.txt)
 , replace  = Y
 , labels   = Y
 , varlist  = %str(Name Sex Age)
 , debug    = Y
   );
```

##### Example 4: Create a TXT file with a tab as delimiter from SASHELP.class:
```sas
%m_utl_ds2txt(
   base_ds  = SASHELP.class
 , txt_file = %str(%sysfunc(getoption(WORK))/class.txt)
 , newfile  = Y
 , engine   = TAB
 , debug    = Y
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
*This document was generated on 2024.04.24 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
