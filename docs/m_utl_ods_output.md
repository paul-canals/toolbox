# File Reference: m_utl_ods_output.sas

### Utilities

##### Utility macro toggle or suppress ODS output during simulations.

***

### Description
This program can be used to suppress the ODS output without using the deprecated ODS CLOSE _ALL_ statement. Even though ODS is suppressed to the display destinations (such as HTML, PDF and LISTING), you can capture the statistics that result from each analysis by using an ODS OUTPUT statement, which saves an ODS table to a SAS data set. Other ways to save statistics include using an OUTPUT statement, an OUT= or OUTEST= dataset, and so forth. This macro is originally based on the %odson and %odsoff macro programs by Rick Wicklin, PhD (rick.wicklin@sas.com)

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
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* SAS ODS output activated or deactivated.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_ods_output(?)
```

##### Example 2: Simple example of supressing PROC PRINT output to SAS ODS:
```sas
%m_utl_ods_output(mode=OFF);

proc print data=SASHELP.class label;
run;

%m_utl_ods_output(mode=ON)
```

##### Example 3: Supress PROC REG output to SAS ODS but allow data output:
```sas
%m_utl_ods_output(mode=OFF);

ods trace on;

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
quit;

ods trace off;

%m_utl_ods_output(mode=ON)
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
*This document was generated on 30.10.2022 at 09:13:23  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
