# Backlog

## Documentation

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 | 21.1.03 | Done | Create a macro [m_hdr_crt_md_file.sas](docs/md/m_hdr_crt_md_file.md) for documentation in MD format functionality |
| 2 | 21.1.03 | Done | Create a macro [m_hdr_crt_pdf_file.sas](docs/md/m_hdr_crt_pdf_file.md) for documentation in PDF format functionality |
| 3 | 21.1.03 | Done | Create a macro [m_hdr_crt_rtf_file.sas](docs/md/m_hdr_crt_rtf_file.md) for documentation in RTF format functionality |
| 4 | 21.1.03 | Done | Change macro [m_hdr_crt_rtf_file.sas](docs/md/m_hdr_crt_rtf_file.md) for documentation in RTF format like PDF layout |
| 5 | 21.1.03 | Done | Consolidated Toolbox macro [m_hdr_crt_pdf_file.sas](docs/md/m_hdr_crt_pdf_file.md) documenation for PDF format |
| 6 | 24.1.06 | Done | Consolidated Toolbox macro [m_hdr_crt_rtf_file.sas](docs/md/m_hdr_crt_rtf_file.md) documenation for RTF format |
| 7 | 24.1.06 | Done | Create a cover page for consolidated Toolbox macro documenation for PDF and RTF format |
| 8 |  | Open | Add an option to include macro code as content of paragraph "Coding" to the output documentation file |

## Installation

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 | 21.1.10 | Done | USR_INFO library | USR_INFO library should be set to a temporary library in session WORK |
| 2 |  | Open | The installation of the Toolbox macros should be done by running an installation script that generates the autoexec.sas, and runs all the checks which are currently handled by the m_utl_chk_installation.sas macro. When the script is complete, the m_utl_chk_installation.sas macro should be marked "obsolete" |

## Scripts

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 | 23.1.10 | Done | Add script [run_functs_comilation.sas](source/sas/misc/scripts/run_functs_compilation.sas) to compile the user defined functions in a function container |
| 2 | 23.1.10 | Done | Add script [run_functs_documentation.sas](source/sas/misc/scripts/run_functs_documentation.sas) to create the user defined function documentation |

## Testing Framework

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 |  | Open | Design data model containing Test-Cases, Test-Units, Test-Sets, Test-Generation, Test-Runs, and Summary result information |
| 2 |  | Open | Design Test-Set filter for (Syntax check, Header structure check, Header help information check, Program usage checks). A Test-Unit filter is defined by the implicit relation between Test-Set and Test-Unit |
| 3 |  | Open | Implement Test-Set type code values are: HEADER, HELP, SYNTAX, USAGE. The test-set type code column name is: SET_CD |
| 4 |  | Open | An existing Test-Set should be reused for different / or more Test-Units / Test-Cases over time (Test type filter) |
| 5 |  | Open | The list of Test-Cases for a Test-Unit can change over time, but using the exsiting entry for Test-Unit |
| 6 |  | Open | Introduction of Test-Generation-ID (GEN_ID) to be used to select the most actual Test-Units / Test-Cases |

## Utility Macros

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 | 21.1.10 | Done | Create a macro [m_utl_get_mvar_info.sas](docs/md/m_utl_get_mvar_info.md) that contains a list of all registered global macro variables and their values |
| 2 | 21.1.10 | Done | Create a macro [m_utl_get_java_info.sas](docs/md/m_utl_get_java_info.md) that collects the Java environment information from the server machine or client system |
| 3 | 21.1.11 | Done | Create a macro [m_utl_get_curdir.sas](docs/md/m_utl_get_curdir.md) to obtain the current macro working directory using a filename reference and pathname function |
| 4 | 21.1.11 | Done | Create a macro [m_utl_set_curdir.sas](docs/md/m_utl_set_curdir.md) to change the current macro working directory using a filename reference, pathname and dlgcdir functions |
| 5 | 23.1.03 | Done | Create a macro [m_utl_sort_elems.sas](docs/md/m_utl_sort_elems.md) to sort all words in a text string using the SAS SORTC function and by input and output delimiter  |
| 6 | 23.1.07 | Done | Create a macro [m_utl_get_auto_info.sas](docs/md/m_utl_get_auto_info.md) that contains a list of all SAS autocall libraries with their corresponding paths |
| 7 | 23.1.11 | Done | Create a macro [m_utl_prio_lookup.sas](docs/md/m_utl_prio_lookup.md) to perform hash table lookups by column mapping table priority for efficient mapping table usage |
| 8 | 23.1.11 | Done | Create a macro [m_utl_get_engine.sas](docs/md/m_utl_get_engine.md) that returns the engine name of a given SAS library including database management system type engines |
| 9 | 23.1.11 | Done | Finalise the integration of [m_utl_print_mtrace.sas](docs/md/m_utl_print_mtrace.md) for all Toolbox macros to enforce macro trace options in SAS log |
| 10 | 24.1.01 | Done | Create a macro [m_utl_chk_boolean.sas](docs/md/m_utl_chk_boolean.md) that checks and converts a given boolean attribute flag value |
| 11 | 24.1.02 | Done | Create a macro [m_utl_map_tables.sas](docs/md/m_utl_map_tables.md) that reads a given source table and target table to collect column information in order to map columns tables |
| 12 | 24.1.04 | Done | Create a macro [m_utl_get_col_number.sas](docs/md/m_utl_get_col_number.md) that returns the column number attribute value from a table or dataset |
| 13 | 24.1.04 | Done | Create a macro [m_utl_get_col_label.sas](docs/md/m_utl_get_col_label.md) that returns the column label attribute value from a table or dataset |
| 14 | 24.1.05 | Done | Create a macro [m_utl_fmtinfo.sas](docs/md/m_utl_fmtinfo.md) that returns if a given SAS format or informat value is valid |

## Validation

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 | 24.1.02 | Done | Implement further DQ Rules filter functionality when using the rules list |
| 2 | 24.1.02 | Done | Performance Optimisation and general improvements when using custom rules |
| 3 | 24.1.05 | Done | Create a macro [m_val_run_profiling.sas](docs/md/m_val_run_profiling.md) to perform data profiling on an input table |
| 4 |  | Open | Create a data lineage script using PROC SCAPROC and m_utl_print_mtrace.sas |
| 5 |  | Open | Create a macro m_val_chk_replace.sas to find and replace missing or invalid values |
