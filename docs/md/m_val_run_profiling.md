![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_val_run_profiling.sas

### Validation

##### Validation macro to run data profiling checks on a given table.

***

### Description
The macro runs a series of data profiling analysis checks on a given source table (SRC_TBL). The performed analysis checks include Completeness, Uniqueness, Conformity and Consistency and overall Quality of the source table column data values, with additional information regarding data anomalies found.

 The profiling contains the following data quality dimensions:

- Completeness : missings, truncation
- Uniqueness : unique distinct values
- Conformity : accuracy, encoding, spacing
- Consistency : formatting, casing

 Completeness: Is defined as percentage of the data populated (not empty) in relation to the total records amount in the given table.

 Uniqueness: Checks the percentage of the unique column values against the frequency of the distinct column values in the table.

 Conformity: Checks the data column values to verify that they are stored, displayed and represented in an uniform format and accurate data type (numerical representation).

 Consistency: Checks the unformatted data column values to verify that the column format and data type are set correctly for the table.

 DQ-Quality: The overall quality of the data in each column is defined by determing the average (mean) ratio of the Completeness, Uniqueness, Conformity and Consistency dimension ratios.



##### *Note:*
*If the PRINT parameter value is set to Y, a SAS proc report step is used to print the validation summary status on the result tab of SAS Enterprise Guide or Stored Process Server.*

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
| Input | src_tbl | Specifies the LIBNAME.TABLENAME of the source SAS dataset or database table for which structure is analysed and a detailed profile will be created. The default value for SRC_TBL is: \_NONE\_. |
| Input | out_lib | Specifies the LIBNAME SAS library reference name for the result SAS datasets or database tables. The default value for OUT_LIB is: \_NONE\_. |
| Input | replace | Boolean [Y/N] parameter value to specify if the profile summary information and found anomalies shpould be appended into existing tables, or if REPLACE=Y into new summary and profile tables. The default value for REPLACE is: Y. |
| Input | g_value | Optional. Parameter to specify the treshhold for the high score value for which the profile result status color is set to green. The parameter value is depending on the PRINT=Y parameter value. The default value for G_VALUE is: 1.00. |
| Input | y_value | Optional. Parameter to specify the treshhold for the medium score value for which the profile result status color is set to green. The parameter value is depending on the PRINT=Y parameter value. The default value for Y_VALUE is: 0.75. |
| Input | r_value | Optional. Parameter to specify the treshhold for the low score value for which the profile result status color is set to green. The parameter value is depending on the PRINT=Y parameter value. The default value for R_VALUE is: 0.50. |
| Input | print | Boolean [Y/N] parameter to generate the output by a SAS proc report step with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Data profiling analysis result target tables.

### Calls
* [m_utl_chk_table_exist.sas](m_utl_chk_table_exist.md)
* [m_utl_finfo_size.sas](m_utl_finfo_size.md)
* [m_utl_get_attrc.sas](m_utl_get_attrc.md)
* [m_utl_get_attrn.sas](m_utl_get_attrn.md)
* [m_utl_get_pathname.sas](m_utl_get_pathname.md)
* [m_utl_hash_lookup.sas](m_utl_hash_lookup.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_table_size.sas](m_utl_table_size.md)
* [m_utl_varlist.sas](m_utl_varlist.md)

### Usage

##### Example 1: Show help information:
```sas
%m_val_run_profiling(?)
```

##### Example 2: Run data profiling checks on SASHELP.baseball table:
```sas
%m_val_run_profiling(
   src_tbl = SASHELP.baseball
 , out_lib = WORK
 , replace = Y
 , print   = Y
 , debug   = N
   );
```

##### Example 3: Run data profiling checks on SASHELP.classfit table:
```sas
%m_val_run_profiling(
   src_tbl = SASHELP.classfit
 , out_lib = WORK
 , replace = Y
 , print   = Y
 , debug   = N
   );
```

##### Example 4: Step 1 - Create and prepare a large table with index:
```sas
%macro doloop();
   %local i;
   %do i=1 %to 44;
      %if &i. eq 1 %then %do;
         data WORK.prdsale (label='Product Sales');
            set SASHELP.prdsal2;
            if country eq 'Canada' then country = '  Canada';
            if state eq 'British Columbia' then state = 'British Columbiaüöä';
            if state eq 'North Carolina' then state = 'North  Carolina';
            if year eq 1997 then year = 11997;
         run;
      %end;
      %else %do;
         data WORK.prdsal2;
            set SASHELP.prdsal2;
            actual = actual + &i.;
            predict = predict + &i.;
         run;
         proc append base=WORK.prdsale data=WORK.prdsal2;
         quit;
      %end;
   %end;
   proc datasets library=WORK noprint;
      modify prdsale;
      index create region=(country state) / nomiss;
   quit;
%mend doloop;
%doloop;
```

##### Example 4: Step 2 - Run data profiling on the indexed table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.prdsale
 , print   = Y
 , debug   = N
   );
```

##### Example 4: Step 3 - Since we are done delete indexed table:
```sas
proc datasets lib=WORK nodetails nolist;
   delete prdsal: ;
quit;
```

##### Example 5: Step 1 - Create and prepare an indexed table:
```sas
data WORK.class (label='Indexed');
   set SASHELP.class;
run;

proc datasets library=WORK noprint;
   modify class;
   index create name / nomiss;
quit;
```

##### Example 5: Step 2 - Run data profiling checks on indexed table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.class
 , out_lib = WORK
 , replace = Y
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
```

##### Example 5: Step 3 - Since we are done delete indexxed table:
```sas
proc datasets lib=WORK nodetails nolist;
   delete class ;
quit;
```

##### Example 6: Step 1 - Create and prepare a table with constraint:
```sas
data WORK.class (label='Constraint');
   set SASHELP.class;
run;

proc datasets library=WORK noprint;
   modify class;
   ic create key = primary key(name);
quit;
```

##### Example 6: Step 2 - Run data profiling checks on constrained table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.class
 , out_lib = WORK
 , replace = N
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
```

##### Example 6: Step 3 - Since we are done delete constrained table:
```sas
proc datasets lib=WORK nodetails nolist;
   delete class ;
quit;
```

##### Example 7: Step 1 - Create and prepare a password protected table:
```sas
data WORK.class (pw=mypasswd label='Protected');
   set SASHELP.class;
run;
```

##### Example 7: Step 2 - Run data profiling checks on protected table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.class (pw=mypasswd)
 , out_lib = WORK
 , replace = N
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
```

##### Example 7: Step 3 - Since we are done delete protected table:
```sas
proc datasets lib=WORK nodetails noprint;
   delete class (alter=mypasswd);
quit;
```

##### Example 8: Step 1 - Create and prepare a password encrypted table:
```sas
data WORK.class (encrypt=aes encryptkey=mypasswd label='Encrypted');
   set SASHELP.class;
run;
```

##### Example 8: Step 2 - Run data profiling checks on encrypted table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.class (encryptkey=mypasswd)
 , out_lib = WORK
 , replace = N
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
```

##### Example 8: Step 3 - Since we are done delete encrypted table:
```sas
proc datasets lib=WORK nodetails noprint;
   delete class (alter=mypasswd);
quit;
```

##### Example 9: Step 1 - Create and prepare an audited table:
```sas
data WORK.class (alter=mypasswd label='Audited' compress=no);
   set SASHELP.class;
run;

proc datasets library=WORK nodetails nolist;
   audit class (alter=mypasswd);
   initiate;
run;
```

##### Example 9: Step 2 - Run data profiling checks on audited table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.class
 , out_lib = WORK
 , replace = N
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
```

##### Example 9: Step 3 - Since we are done delete audited table:
```sas
proc datasets lib=WORK nodetails noprint;
   delete class (alter=mypasswd);
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
*This document was generated on 2024.08.03 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
