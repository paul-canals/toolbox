![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_ods_trace.sas

### Utilities

##### Utility macro toggle or suppress ODS object information output.

***

### Description
This program can be used to activate or deactivate the Output Delivery System trace information in the log output. It writes to the SAS log destination a record of each output object that is created, or suppresses the writing of this record. SAS ODS produces an output object by combining data from the data component with a table template. The trace record provides information about the data component, the table template, and the output object.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-02-05 00:00:00

### Version
* 20.1.02

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | mode | Indicator [ON/OFF] to activate or deactivate the ODS output The default value for MODE is : OFF. |
| Input | label | Boolean [Y/N] to activate or deactivate the path for the output object in the record. You can use a label path anywhere that you can use a path. This option is helpful for users who are running a localized version of SAS, because the labels are translated from English to the local language. The names and paths of output objects are not translated because they are part of the syntax of the Output Delivery System. The default value for LABEL is : N. |
| Input | listing | Boolean [Y/N] to write the trace record to the LISTING destination, so that each part of the trace record immediately precedes the output object that it describes. Setting this option causes the ODS LISTING output to be turned on when MODE=ON, and to be turned of when MODE=OFF. The default value for LISTING is : N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* SAS ODS trace information output activated or deactivated.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_ods_trace(?)
```

##### Example 2: Shows the names of the output objects that a procedure creates:
```sas
%m_utl_ods_trace(mode=ON, debug=N);

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
quit;

%m_utl_ods_trace(mode=OFF);
```

##### Example 3: Shows the names and lables of the output objects that a procedure creates:
```sas
%m_utl_ods_trace(mode=ON, label=Y, debug=N);

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
quit;

%m_utl_ods_trace(mode=OFF);
```

##### Example 4: Write the names and lables of the output objects to the LISTING output:
```sas
%m_utl_ods_trace(mode=ON, label=Y, listing=Y, debug=N);

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
quit;

%m_utl_ods_trace(mode=OFF);
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
*This document was generated on 26.09.2023 at 15:41:40  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
