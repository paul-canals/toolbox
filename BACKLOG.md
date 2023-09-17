# Backlog

## Documentation

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 | 21.1.03 | Done | Create a macro [m_hdr_crt_md_file.md](docs/md/m_hdr_crt_md_file.md) for documentation in MD format functionality |
| 2 | 21.1.03 | Done | Create a macro [m_hdr_crt_pdf_file.md](docs/md/m_hdr_crt_pdf_file.md) for documentation in PDF format functionality |
| 3 | 21.1.03 | Done | Create a macro [m_hdr_crt_rtf_file.md](docs/md/m_hdr_crt_rtf_file.md) for documentation in RTF format functionality |
| 4 | 21.1.03 | Done | Change macro [m_hdr_crt_rtf_file.md](docs/md/m_hdr_crt_rtf_file.md) for documentation in RTF format to PDF layout |
| 5 | 21.1.03 | Done | Consolidated Toolbox macro [m_hdr_crt_pdf_file.md](docs/md/m_hdr_crt_pdf_file.md) documenation for PDF format |
| 6 |  | Open | Consolidated Toolbox macro [m_hdr_crt_rtf_file.md](docs/md/m_hdr_crt_rtf_file.md) documenation for RTF format |
| 7 |  | Open | Add an option to include macro code as content of paragraph "Coding" to the output documentation file |
    
## Installation

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 | 21.1.10 | Done | USR_INFO library | USR_INFO library should be set to a temporary library in session WORK |
| 2 |  | Open | The installation of the Toolbox macros should be done by running an installation script that generates the autoexec.sas, and runs all the checks which are currently handled by the m_utl_chk_installation.sas macro. When the script is complete, the m_utl_chk_installation.sas macro should be marked "obsolete" |

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
| 1 | 21.1.10 | Done | Create a macro [m_utl_get_mvar_info.md](docs/md/m_utl_get_mvar_info.md) that contains a list of all registered global macro variables and their values |
| 2 | 21.1.10 | Done | Create a macro [m_utl_get_java_info.md](docs/md/m_utl_get_java_info.md) that collects the Java environment information from the server machine or client system |
| 3 | 21.1.11 | Done | Create a macro [m_utl_get_currdir.md](docs/md/m_utl_get_currdir.md) to obtain the current macro working directory using a filename reference and pathname function |
| 4 | 21.1.11 | Done | Create a macro [m_utl_set_currdir.md](docs/md/m_utl_set_currdir.md) to change the current macro working directory using a filename reference, pathname and dlgcdir functions |
| 5 | 23.1.03 | Done | Create a macro [m_utl_sort_elems.md](docs/md/m_utl_sort_elems.md) to sort all words in a text string using the SAS SORTC function and by input and output delimiter  |
| 6 | 23.1.07 | Done | Create a macro [m_utl_get_auto_info.md](docs/md/m_utl_get_auto_info.md) that contains a list of all SAS autocall libraries with their corresponding paths |

## Validation

| Item | Assigned | State | Description |
| :--: | :------: | :---: | ----------- |
| 1 |  | Open | Implement further DQ Rules filter functionality when using the rules list |
| 2 |  | Open | Performance Optimisation and general improvements when using custom rules |
