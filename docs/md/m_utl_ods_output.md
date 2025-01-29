[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_ods_output.sas

### Utilities

##### Utility macro to suppress ODS result output during simulations.

***

### Description
This program can be used to toggle the ODS result output and the default ODS destination between Off and Set. The routine includes the correct use of ODS RESULT, GRAPHICS and also the ODS _ALL_ CLOSE statement for SAS Enterprise Guide and Studio. Even though ODS no result is send to the display destinations, you can capture the statistics that result from each analysis by using an ODS OUTPUT statement, which saves an ODS table to a SAS data set. Other ways to save statistics include using an OUTPUT statement, an OUT= or OUTEST= dataset, and so forth.

 Valid values for ODS output MODE are:

- O or Off
- R or Reset
- S or Set
- V or View

 This macro is originally based on the %odson and %odsoff macro programs by Rick Wicklin, PhD (rick.wicklin@sas.com) and Allen E. Bingham idea to use SASHELP.vdest entries to enable a reset to the original ODS destinations listed in the SASHELP.vdest SAS dictionary table.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-11-30 00:00:00

### Version
* 24.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | mode | Indicator [OFF/RESET/SET] to toggle between off, on and reset the ODS and GRAPHICS result output. The default value for MODE is : OFF. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* SAS ODS result output activated or deactivated.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

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

%m_utl_ods_output(mode=SET);
```

##### Example 3: Supress PROC REG output to SAS ODS but allow data output:
```sas
%m_utl_ods_output(mode=OFF);

ods trace on;

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
   ods output close;
quit;

ods trace off;

%m_utl_ods_output(mode=SET);
```

##### Example 4: Supress and reset nested ODS output using tokens:
```sas
%m_utl_ods_output(mode=VIEW);

ods html;
ods pdf;

%m_utl_ods_output(mode=OFF);

%m_utl_ods_output(mode=VIEW);

ods html close;
ods pdf close;

%m_utl_ods_output(mode=OFF);

%m_utl_ods_output(mode=VIEW);

proc means data=SASHELP.class;
run;

%m_utl_ods_output(mode=SET);

%m_utl_ods_output(mode=RESET);

proc means data=SASHELP.class;
run;

%m_utl_ods_output(mode=VIEW);
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
*This document was generated on 2024.11.30 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
