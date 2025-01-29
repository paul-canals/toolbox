[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_val_run_validation.sas

### Validation

##### Validation macro to run checks on data using a control table.

***

### Description
The macro reads a list of validation rules from a SAS dataset or database table to perform validation checks on data listed in that table (CTL_TBL). The following validation rules can be used by this macro to perform the validation data checks:

- [C]ustom: data validation by using a custom validation rule
- [D]uplicate: data validation by checking for duplicate values
- [I]nvalid: data validation by checking for invalid values
- [M]issing: data validation by checking for missing values

 The following operators are allowed when using the custom data validation rule:

- \** : exponentiation
- \* : multiplication
- \/ : division
- \+ : addition
- \- : substraction
- \= : equal to
- \^= : not equal to
- \< : lesser than
- \> : greater than
- \<= : lesser than or equal to
- \>= : greater than or equal to
- \<> : max operator
- \>< : min operator
- and : and operator
- eq : equal to ( \= )
- ge : greater than or equal to ( \>= )
- gt : greater than ( \> )
- in : equal to one of a list
- le : lesser than or equal to ( \<= )
- lt : lesser than ( \< )
- ne : not equal to ( \^= )
- not : not operator
- or : or operator

 If the given expression syntax is invalid, the rule status value is set to 0, exceptions to \-1 and action set to ERROR.



##### *Note:*
*If the PRINT parameter value is set to Y, a SAS proc report step is used to print the profiling summary status on the result tab of SAS Enterprise Guide, SAS STP or SAS Studio.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)
* Dr. Simone Kossmann (simone.kossmann@web.de)

### Date
* 2024-12-12 00:00:00

### Version
* 24.1.12

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | ctl_tbl | Specifies the LIBNAME.TABLENAME of the parameter control SAS dataset or database table containing the list of validation rules. The default value for CTL_TBL is: \_NONE\_. |
| Input | exc_sum | Specifies the LIBNAME.TABLENAME of the target SAS dataset or database table in which the exception summary is stored. The default value is: \_NONE\_. |
| Input | exc_tbl | Specifies the LIBNAME.TABLENAME of the target SAS dataset or database table in which the exceptions are stored. The default value is: \_NONE\_. |
| Input | filter | Optional. Parameter value to specify a to be applied to the CTL_TBL containing the list of rules for validation selection. The filter is a blank separated list of RULE_GRP group names and is compared against group values in the CTL_TBL. |
| Input | replace | Boolean [Y/N] parameter value to specify if the summary information and found exceptions are to be appended into existing tables or if REPLACE is set to Y into a new summary and exception tables. The default value for REPLACE is: Y. |
| Input | g_value | Optional. Parameter to specify the high band value for which the validation result status color is set to green. The parameter depends on the PRINT value. The default value for G_VALUE is: 1.00. |
| Input | y_value | Optional. Parameter to specify the high band value for which the validation result status color is set to yellow. The parameter depends on the PRINT value. The default value for Y_VALUE is: 0.99. |
| Input | r_value | Optional. Parameter to specify the high band value for which the validation result status color is set to red. The parameter depends on the PRINT value. The default value for R_VALUE is: 0.50. |
| Input | print | Boolean [Y/N] parameter to generate the output by a SAS proc report step with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Validation result target tables.

### Calls
* [m_utl_chk_table_exist.sas](m_utl_chk_table_exist.md)
* [m_utl_hash_lookup.sas](m_utl_hash_lookup.md)
* [m_utl_list_operation.sas](m_utl_list_operation.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)
* [m_utl_varlist.sas](m_utl_varlist.md)
* [m_val_chk_custom.sas](m_val_chk_custom.md)
* [m_val_chk_duplicates.sas](m_val_chk_duplicates.md)
* [m_val_chk_invalid.sas](m_val_chk_invalid.md)
* [m_val_chk_missing.sas](m_val_chk_missing.md)

### Usage

##### Example 1: Show help information:
```sas
%m_val_run_validation(?)
```

##### Example 2: Step 1 - Create a validation control table:
```sas
data WORK.rules;
   length
      rule_id    8
      rule_grp   $32
      rule_type  $20
      library    $10
      table      $32
      columns    $1024
      range_min  $32
      range_max  $32
      value_list $1024
      expression $1024
      ;
   infile datalines4 dlm=';'
   missover;
   input
      rule_id
      rule_grp   $
      rule_type  $
      library    $
      table      $
      columns    $
      range_min  $
      range_max  $
      value_list $
      expression $
      ;
datalines4;
1; ;Missing;WORK;CARS;Make; ; ; ; ;
2; ;Missing;WORK;CARS;Model Type; ; ; ; ;
3; ;Duplicate;WORK;CARS;Make Model Type; ; ; ; ;
4; ;Invalid;WORK;CARS;Cylinders; ; ;4 6 8 10 12; ;
5; ;Invalid;WORK;CARS;Invoice;30000;50000; ; ;
6; ;Invalid;WORK;CARS;Invoice;30000; ; ; ;
7; ;Invalid;WORK;CARS;Invoice; ;50000; ; ;
8;Mobile;Custom;WORK;CARS; ; ; ; ;Invoice lt 50000;
9;Mobile;Custom;WORK;CARS; ; ; ; ;(substr(Make,1,1) ne "") and (Type ^= '');
10;Student;Missing;WORK;CLASS;Name Sex; ; ; ; ;
11;Student;Invalid;WORK;CLASS;Sex; ; ;F M; ;
12;Student;Invalid;WORK;CLASS;Age; ;18; ; ;
15;Fittness;Custom;WORK;CLASS; ; ; ; ;Name in (select Name from SASHELP.classfit where Name ne 'John'); ; ;
16;Fittness;Custom;WORK;CLASS; ; ; ; ;Height in (select Height from SASHELP.classfit where Height > 55); ; ;
17;Fittness;Custom;WORK;CLASS; ; ; ; ;Weight in (select Weight from SASHELP.classfit where Weight gt 70); ; ;
30; ;Missing;SASHELP;PRDSAL2;COUNTRY STATE; ; ; ; ;
31; ;Invalid;SASHELP;PRDSAL2;QUARTER;1;4; ; ;
32; ;Invalid;SASHELP;PRDSAL2;QUARTER; ; ;1 2 3 4; ;
33; ;Invalid;SASHELP;PRDSAL2;YEAR;1996;1998; ; ;
35; ;Custom;SASHELP;PRDSAL2; ; ; ; ;COUNTRY in (lookup COUNTRY from SASHELP.prdsal3 where COUNTY ne '');
;;;;
run;
```

##### Example 2: Step 2 - Prepare the SASHELP.cars table for missing values:
```sas
data WORK.cars;
   set SASHELP.cars;
   if mod(_N_,10) eq 0 then do;
      type = '';
      length = .;
   end;
run;
```

##### Example 2: Step 3 - Prepare the SASHELP.class table for invalid values:
```sas
data WORK.class / view=WORK.class;
   set SASHELP.class;
   if Name eq 'John' then Sex = '';
run;
```

##### Example 2: Step 4 - Run all of the listed valdiation checks:
```sas
%m_val_run_validation(
   ctl_tbl = WORK.rules
 , exc_sum = WORK.summary
 , exc_tbl = WORK.exceptions
 , print   = Y
 , debug   = N
   );

proc print data=WORK.exceptions (obs=10) label;
run;
```

##### Example 2: Step 5 - Run only filtered list of valdiation checks:
```sas
%m_val_run_validation(
   ctl_tbl = WORK.rules
 , exc_sum = WORK.summary
 , exc_tbl = WORK.exceptions
 , filter  = %str(Student Fittness)
 , replace = Y
 , print   = Y
 , debug   = N
   );

proc print data=WORK.exceptions (obs=10) label;
run;
```

##### Example 2: Step 6 - Since we are done delete modified tables:
```sas
proc datasets lib=WORK memtype=(DATA VIEW) nodetails noprint;
   delete cars class ;
quit;
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
*This document was generated on 2024.12.12 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
