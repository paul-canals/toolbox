![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_chg_special_chars.sas

### Utilities

##### Utility macro to replace special chars into normal characters.

***

### Description
This program works in mixed unicode environments. It replaces special characters inline into readeable charecters to avoid conversion errors. The macro can be executed in the context of either a macro call or it generates code to be executed in the context of a data step. This is controlled by the CONTEXT macro parameter. The valid values for CONTEXT are: MACRO or DATASTEP.
 At present the following characters are replaced by the routine:
 Ä \/ ä \-> Ae \/ ae
 Ö \/ ö \-> Oe \/ oe
 Ü \/ ü \-> Ue \/ ue
 ß \-> ss


### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-07 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_var | Input column name. This can be a data step attribute or a proc sql column definition. The default value is: \_NONE\_. |
| Input | context | Indicator [DATASTEP/MACRO] to select the in which the macro is to be run in. The default value is: MACRO. |
| Input | colnm | Alias of the IN_VAR parameter. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Column value string with special characters replaced

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_chg_special_chars(?)
```

##### Example 2: Replace special characters (SAS datastep context):
```sas
proc print data=SASHELP.class;
   where name = 'Janet';
run;

data WORK.class;
   set SASHELP.class;
   if name eq 'Janet'
      then name=tranwrd(name,'a','ä');
run;

proc print data=WORK.class;
   where name = 'Jänet';
run;

data WORK.class_replaced;
   set WORK.class;
   name=%m_utl_chg_special_chars(colnm=name,context=D,debug=Y);
run;

proc print data=WORK.class_replaced;
   where name = 'Jaenet';
run;
```

##### Example 3: Replace special characters (SAS macro context):
```sas
%let string = Jänet iß a female stüdent;

%let result=
   %m_utl_chg_special_chars(
      in_var  = &string.
    , context = M
    , debug   = Y
      );
%put &=result.;
```

##### Example 3: Replace special characters (SAS datastep context):
```sas
%let result=;
data _null_;
   string = "Jänet iß a female stüdent";
   call symput('result', %m_utl_chg_special_chars(colnm=string,context=M,debug=Y));
run;
%put &=result.;
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
*This document was generated on 13.09.2023 at 15:25:24  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
