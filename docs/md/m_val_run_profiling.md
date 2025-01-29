[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_val_run_profiling.sas

### Validation

##### Validation macro to run data profiling checks on a given table.

***

### Description
The macro runs a series of data profiling analysis checks on a given source table (SRC_TBL). The performed analysis checks Completeness, Uniqueness, Timeliness, Conformity, Consistency, and overall Quality of the source table column data values, with additional information regarding data anomalies found.

 The profiling contains the following data quality dimensions:

- Completeness : missings, truncation
- Uniqueness : unique distinct values
- Timeliness : actuality of the data
- Conformity : anomaly, accuracy, encoding, spacing
- Consistency : formatting, casing

 Completeness: Is defined as percentage of the data populated (not empty) in relation to the total records amount in the given table.

 Uniqueness: Checks the percentage of the unique column values against the frequency of the distinct column values in the table.

 Timeliness: Checks the degree to which data represents reality against against the required point in time (actuality of the data).

 Conformity: Checks the data column values to verify that they are stored, displayed and represented in an uniform format and data type, including anomaly analysis (numerical representation).

 Consistency: Checks the unformatted data column values to verify that the column format and data type are set correctly for the table.

 DQ-Quality: The overall quality of the data in each column is defined by determing the average (mean) ratio of the Completeness, Uniqueness, Timeliness, Conformity and Consistency dimension ratios.



##### *Note:*
*If the PRINT parameter value is set to Y, a SAS proc report step is used to print the profiling summary status on the result tab of SAS Enterprise Guide, SAS STP or SAS Studio.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2025-01-25 00:00:00

### Version
* 25.1.01

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
| Input | t_colmn | Parameter to specify the SRC_TBL column name or table attribute on which the timeliness dimension ratio is calculated. The value can be any column of SRC_TBL table, containing a DATE or DATETIME format. The default value for T_COLMN is: moddate. |
| Input | t_value | Optional. Parameter to specify the treshhold for calculating the timeliness dimension ratio. The value represents the maximum amount of days for which the timeliness ratio is 100 percent actual. The default value for T_VALUE is: 90. |
| Input | d_round | Optional. Parameter to specify the rounding of numerical values before calcualting the loss of accuracy (Ndif) on decimal level. The loss can be observed on numerical columns without formats containing decimal values, and also on columns with formats where the precision value is not set correctly. The default value is: N. |
| Input | q_plot | Indicator [ALL/BOX/HIS/NONE] parameter value to specify which type of plot is to be generated using SAS proc sgpanel. In case Q_PLOT=BOX, a vertical Whisker-Box-Plot is created, in case Q_PLOT=HIS, a vertical barchart in combination with a normal distribution density plot is created for each numerical variable in SRC_TBL table. In case Q_PLOT=ALL, both BOX and HIS plots are created, and if Q_PLOT=NONE, plot output is suppressed. The parameter is only valid in combination with parameter PRINT=Y. The default value for Q_PLOT is: NONE. |
| Input | q_mode | Indicator [GINI/IQR/MAD/STD] parameter value to specify the data outlier analysis method to conduct. IQR - Tukeys Interquartile-Range - is the default method which uses Q_TUKEY fence as factor to compute the IQR length from lower (Q1) and upper (Q3) as fences or boundaries. The GINI - Gini mean difference - uses the standard deviation for Gini mean difference in combination with Q_SIGMA=3 to compute the length from lower and upper to mean. The MAD- Median Absolute Distance - uses the standard deviation for median absolute distance in combination with Q_SIGMA=3 to compute the length from lower and upper to median. The STD- The Standard Deviation from Mean - uses the Q_SIGMA 3-sigma rule to compute the length from the lower and upper cut-off boundaries to mean. For all methods, numerical variable values are standardised and centered using a robust z-score computation method, in order to center the data around the median(=0) and scaled with a median absolute distance (MAD) value of 1. The default value for Q_MODE is: IQR. |
| Input | q_wght | Boolean [Y/N] parameter to specify if the data scoring and outlier analysis result is weighted using the frequency of values as adjustment. The default value for Q_WGHT is: Y. |
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
* [m_utl_list_operation.sas](m_utl_list_operation.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)
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
 , d_round = Y
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
 , q_plot  = ALL
 , q_wght  = Y
 , print   = Y
 , debug   = Y
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

##### Example 10: Step 1 - Create and prepare an actual table:
```sas
data WORK.class;
   set SASHELP.class;
   attrib Repdat length=8 format=ddmmyyp10.;
   repdat = today();
run;
```

##### Example 10: Step 2 - Run data profiling checks on actual table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.class
 , print   = Y
 , debug   = N
   );
```

##### Example 10: Step 3 - Run data profiling checks on actual table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.class
 , t_colmn = Repdat
 , print   = Y
 , debug   = N
   );
```

##### Example 10: Step 4 - Since we are done delete actual table:
```sas
proc datasets lib=WORK nodetails noprint;
   delete class;
quit;
```

##### Example 11: Step 1 - Create and prepare an actual table:
```sas
data WORK.heart;
   set SASHELP.heart;
   attrib Repdat length=8 format=ddmmyyp10.;
   repdat = today();
run;
```

##### Example 11: Step 2 - Run IQR outlier checks on actual table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.heart
 , t_colmn = Repdat
 , q_plot  = ALL
 , q_mode  = IQR
 , q_wght  = N
 , print   = Y
 , debug   = Y
   );
```

##### Example 11: Step 3 - Run MAD outlier checks on actual table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.heart
 , t_colmn = Repdat
 , q_plot  = HIS
 , q_mode  = MAD
 , q_wght  = Y
 , print   = Y
 , debug   = N
   );
```

##### Example 11: Step 4 - Run GINI outlier checks on actual table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.heart
 , t_colmn = Repdat
 , q_plot  = HIS
 , q_mode  = GINI
 , q_wght  = Y
 , print   = Y
 , debug   = N
   );
```

##### Example 11: Step 5 - Run STD outlier checks on actual table:
```sas
%m_val_run_profiling(
   src_tbl = WORK.heart
 , t_colmn = Repdat
 , q_plot  = HIS
 , q_mode  = STD
 , q_wght  = Y
 , print   = Y
 , debug   = N
   );
```

##### Example 11: Step 6 - Since we are done delete actual table:
```sas
proc datasets lib=WORK nodetails noprint;
   delete heart;
quit;
```

### Copyright
Copyright 2008-2025 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 2025.01.25 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
