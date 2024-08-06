[![misc/images/banner.png](misc/images/banner.png)](https://github.com/paul-canals/toolbox-dev)

# 
[![Release: v24.1.08](https://img.shields.io/badge/release-v24.1.08-orange.svg)](https://github.com/paul-canals/toolbox/releases/tag/24.1.08-final)
[![SAS Version: 9.4](https://img.shields.io/badge/sas-9.4-blue.svg)](https://www.sas.com)
[![License: GPL v3](https://img.shields.io/badge/license-GPLv3-green.svg)](https://www.gnu.org/licenses/gpl-3.0)

# Toolbox - Paul's SAS&reg; Utility Macros Toolbox

## Purpose

The Toolbox is a library of SAS&reg; macros that can be used to cover specific or generic (repeating) tasks when developing SAS&reg; software. It lets SAS&reg; Programmers and Developers collaborate easily to build general-purpose applications with unprecedented speed and agility.

These macros are the result of developing SAS&reg; software for more than fifteen years. It all started with collecting and saving code snippets in the early years. However soon after I got tired of searching for solutions of the same old problems over and over again, I started to build generic utility macros to cover basic functions that I could use every time and anywhere. So eventually at any project I started worked on, the first thing to do was to load my toolbox macros to the project site. Since then this soon became known as *Paul's SAS&reg; Utility Macros Toolbox*.

All macros and programs are documented in detail, using the [Doxygen](http://www.doxygen.org) program header structure format as the de facto standard tool for generating documentation from annotated sources. To simplify the effort to keep the documentation up-to-date, the Toolbox also includes macros to perform the documentation generation to [Markdown](https://en.wikipedia.org/wiki/Markdown) formatted files. The documentation in this repository is using these Markdown formatted files which can be found in the `/toolbox/docs` directory.

Contact me if you have any suggestions, questions or comments about the Toolbox, my email address is: [paul.canals@gmail.com](mailto:paul.canals@gmail.com), or connect with me on [LinkedIn](http://www.linkedin.com/in/paul-alexander-canals-y-trocha). 


## Requirements

the minimum system requirements to be able to use the SAS&reg; Toolbox macros are:

##### Server Requirements:

- Local SAS&reg; installation, or SAS&reg; BI Platform (v9.2 or later)

##### Client Requirements:

- SAS&reg; Enterprise Guide or any SAS&reg; code editor by choice.
- Having Git installed would be useful as code versioning tool.


## Getting Started

The installation of the Paul's SAS&reg; Utility Macros Toolbox is very straightforward and requires minimal SAS&reg; knowledge to perform. Just follow the following installations steps to get the Toolbox started within your SAS&reg; system environment. 

### Pre Installation Steps

The first thing to do is either to copy the release package, or clone the toolbox repository to a local (temporary) destination:

    git clone https://github.com/paul-canals/toolbox

Now we can continue with the Installation Steps.


### Installation Steps

1. Copy the `config` directory to your SAS&reg; Application Server. For this example, we copied ours to: `/pub/toolbox/config`

2. Copy the `docs` directory to your SAS&reg; Application Server. For this example, we copied ours to: `/pub/toolbox/docs`

3. Copy the `misc` directory to your SAS&reg; Application Server. For this example, we copied ours to: `/pub/toolbox/misc`

4. Copy the `source` directory to your SAS&reg; Application Server. For this example, we copied ours to: `/pub/toolbox/source`

5. Open the `/pub/toolbox/misc/scripts/autoexec.sas` file into the SAS&reg; editor of your choice, and edit the following entries:

      ```sas
      %let APPL_HOST = DEV;           /* Set to [PRD|TST|DEV] */
      %let APPL_META = GRP;           /* Acronym for SAS Metadata Server Usergroup */
      %let APPL_BASE = /pub/toolbox;  /* Root path to Toolbox files */
      ```

7. Save the changes made to the `/pub/toolbox/misc/scripts/autoexec.sas` file, and close it.

8. Register the `/pub/toolbox/misc/scripts/autoexec.sas` file into the `/SAS/Config/Levx/SASApp/sasapp_autoexec_usermods.sas` SAS&reg; autoexec file. Set this to be the body of the `/SAS/Config/Levx/SASApp/sasapp_autoexec_usermods.sas` SAS&reg; autoexec file:

      ```sas
      /* Toolbox, from wherever you placed it in step 1*/
      %include '/pub/toolbox/misc/scripts/autoexec.sas';
      ```

9. Save the changes made to the `/SAS/Config/Levx/SASApp/sasapp_autoexec_usermods.sas` file, and close it.

10. To check if the installation of the Toolbox library was successful, open SAS&reg; Enterprise Guide and log on to your SAS&reg; Application Server (using a server connection profile) and run the following code:

      ```sas
      %m_utl_chk_installation(
         print = Y
       , debug = N 
         );
      ```

11. The program should produce something like this output in the SAS&reg; Enterprise Guide *Result* tab:
    <details>
    <summary>
        <i>Expected result of the m_utl_chk_installation.sas macro execution</i>
    </summary>

    | Check | Status |
    | ----- | :----: |
    | Check if global parameter 'APPL_BASE' exists | OK |
    | Check if global parameter 'APPL_BSCR' exists | OK |
    | Check if global parameter 'APPL_CONF' exists | OK |
    | Check if global parameter 'APPL_DOCS' exists | OK |
    | Check if global parameter 'APPL_FUNC' exists | OK |
    | Check if global parameter 'APPL_HOST' exists | OK |
    | Check if global parameter 'APPL_LOGS' exists | OK |
    | Check if global parameter 'APPL_MCAT' exists | OK |
    | Check if global parameter 'APPL_META' exists | OK |
    | Check if global parameter 'APPL_MISC' exists | OK |
    | Check if global parameter 'APPL_NAME' exists | OK |
    | Check if global parameter 'APPL_PRGM' exists | OK |
    | Check if global parameter 'APPL_TEST' exists | OK |
    | Check if global parameter 'APPL_TMPL' exists | OK |
    | Check if global parameter 'APPL_UCMR' exists | OK |
    | Check if global parameter 'APPL_VERS' exists | OK |
    | Check if value for APPL_BASE is set: '/pub/toolbox' | OK |
    | Check if value for APPL_BSCR is set: '/pub/toolbox/source/sas/misc/scripts' | OK |
    | Check if value for APPL_CONF is set: '/pub/toolbox/config' | OK |
    | Check if value for APPL_DOCS is set: '/pub/toolbox/docs' | OK |
    | Check if value for APPL_FUNC is set: '/pub/toolbox/source/sas/functions' | OK |
    | Check if value for APPL_HOST is set: 'DEV' | OK |
    | Check if value for APPL_LOGS is set: '/pub/toolbox/misc/logs' | OK |
    | Check if value for APPL_MCAT is set: '/pub/toolbox/source/sas/catalogs' | OK |
    | Check if value for APPL_META is set: 'GRP' | OK |
    | Check if value for APPL_MISC is set: '/pub/toolbox/source/sas/misc' | OK |
    | Check if value for APPL_NAME is set: 'Toolbox' | OK |
    | Check if value for APPL_PRGM is set: '/pub/toolbox/source/sas/sasautos' | OK |
    | Check if value for APPL_TEST is set: '/pub/toolbox/source/sas/misc/tests' | OK |
    | Check if value for APPL_TMPL is set: '/pub/toolbox/source/sas/misc/templates' | OK |
    | Check if value for APPL_UCMR is set: '/pub/toolbox/source/sas/ucmacros' | OK |
    | Check if value for APPL_VERS is set: '23.01.09' | OK |
    | Check if directory '/pub/toolbox' exists | OK |
    | Check if directory '/pub/toolbox/config' exists | OK |
    | Check if directory '/pub/toolbox/docs' exists | OK |    
    | Check if directory '/pub/toolbox/misc/logs' exists | OK |
    | Check if directory '/pub/toolbox/source/sas/catalogs' exists | OK |
    | Check if directory '/pub/toolbox/source/sas/functions' exists | OK |
    | Check if directory '/pub/toolbox/source/sas/misc' exists | OK |
    | Check if directory '/pub/toolbox/source/sas/misc/scripts' exists | OK |
    | Check if directory '/pub/toolbox/source/sas/misc/templates' exists | OK |
    | Check if directory '/pub/toolbox/source/sas/misc/tests' exists | OK |
    | Check if directory '/pub/toolbox/source/sas/sasautos' exists | OK |
    | Check if directory '/pub/toolbox/source/sas/ucmacros' exists | OK |
    | Check if file '/pub/toolbox/config/run_parameter_ctrl.csv' exists | OK |
    | Check if configuration parameter 'M_DEBUG_MODE' exists | OK |
    | Check if configuration parameter 'M_DEFAULT_LOCALE' exists | OK |
    | Check if configuration parameter 'M_EMAIL_ADMIN' exists | OK |
    | Check if configuration parameter 'M_ERROR_LIMIT' exists | OK |
    | Check if configuration parameter 'M_FLG_NO' exists | OK |
    | Check if configuration parameter 'M_FLG_YES' exists | OK |
    | Check if configuration parameter 'M_HASH' exists | OK |
    | Check if configuration parameter 'M_JOB_LOG' exists | OK |
    | Check if configuration parameter 'M_JOB_MSG' exists | OK |
    | Check if configuration parameter 'M_JOB_RC' exists | OK |
    | Check if configuration parameter 'M_LOADING_DT' exists | OK |
    | Check if configuration parameter 'M_LOADING_DTTM' exists | OK |
    | Check if configuration parameter 'M_MYFOLDER' exists | OK |
    | Check if configuration parameter 'M_RUN_RC' exists | OK |
    | Check if configuration parameter 'M_VALID_MAX_DTTM' exists | OK |
    | Check if user specific parameter 'USER_DATA' exists | OK |
    | Check if user specific parameter 'USER_HOME' exists | OK |
    | Check if user specific parameter 'USER_INFO' exists | OK |
    | Check if user specific parameter 'USER_WORK' exists | OK |
    | Check if user specific library 'USR_DATA' exists | OK |
    | Check if user specific library 'USR_HOME' exists | OK |
    | Check if user specific library 'USR_INFO' exists | OK |
    | Check if user specific library 'USR_WORK' exists | OK |

    </details>

This is good enough for now. It is time now for some *Post Installation Steps*.


### Post Installation Steps

In order to compile all of the the toolbox macros into a SAS&reg; macro catalog, run the m_adm_compile_macros.sas (toolbox) program:

```sas
%m_adm_compile_macros(
   indir    = %str(/pub/toolbox/source/sas/sasautos)
 , outdir   = %str(/pub/toolbox/source/sas/catalogs)
 , print    = Y
 , debug    = Y
   );
```

After the program finishes, a new SAS&reg; macro catalog has been created (in our case) under `/pub/toolbox/misc/catalogs/sasmacr.sas7bcat`.

To view the contents of the SAS&reg; macro catalog run the m_utl_mstore_view.sas (toolbox) program:

```sas
%m_utl_mstore_view(
   indir    = %str(/pub/toolbox/source/sas/catalogs)
 , outds    = TEMP
 , print    = Y
 , debug    = Y
   );
```

Now that the compiled SAS&reg; macro catalog is created for the toolbox macros, we may include the catalog into the autoexec.sas program. Therefore, we have to change some entries to the following code block: 

```sas
 %*---------------------------------------------------------------------------;
 %* Include utility and custom macros to the SASAUTO macro library:           ;
 %*---------------------------------------------------------------------------;
 options sasautos=("&APPL_PRGM." %sysfunc(getoption(SASAUTOS)));
```

Since we want to register the toolbox macros by using the SAS&reg; macro catalog we created before under `/pub/toolbox/source/sas/catalogs/sasmacr.sas7bcat`, we need to make the following changes to the autoexec.sas program:

```sas
 %*---------------------------------------------------------------------------;
 %* Include utility and custom macros to the SASAUTO macro library:           ;
 %*---------------------------------------------------------------------------;
 *options sasautos=("&APPL_PRGM." %sysfunc(getoption(SASAUTOS)));
```

After making the changes to the autoexec.sas program, save the file and disconnect the connection from SAS&reg; Enterprise Guide to the SAS&reg; Application server. The new settings will take effect at the next logon.

## Software Modules

#### Admin
The `Admin` macros are used to administrate data interfaces in a secure way, and to create reports for administrative users on the status of the SAS&reg; Server environment. See the Toolbox macro documentation under `/toolbox/docs` for further detailed information and examples.

#### Custom
The `Custom` macros are standalone macros capable of working in environments without the need of having the SAS&reg; Toolbox Utility Macros installed on the client SAS&reg; system. See the Toolbox macro documentation under `/toolbox/docs` for further detailed information and examples.

#### Documentation
The `Documentation` macros are to verify and create automated program documentation using the Doxygen style formatted program header structure information. and saves the result in Markdown, PDF or RTF format. See the Toolbox macro documentation under `/toolbox/docs` for further detailed information and examples.

#### Functions
The `Functions` examples are used to demonstrate the PROC FCMP procedure to create user defined functions. See the toolbox function documentation under `/toolbox/docs` for further detailed information and examples.

#### Logging
The `Logging` macros are used to analyse execution results on SAS&reg; system. It reads the logs to obtain execution information and generates log analysis result reports. See the Toolbox macro documentation under `/toolbox/docs` for further detailed information and examples.
 
#### System
The `System` macros are used to control the client SAS&reg; system setup at logon. It supports reading SAS&reg; metadata to obtain user access information for database connections, setting user specific parameters and logging in a batch processing environment, and contains special programs to support and ease ETL-development. See the Toolbox macro documentation under `/toolbox/docs` for further detailed information and examples.

#### Testing
The `Testing` macros are used to document, create or execute test scripts. See the Toolbox macro documentation under `/toolbox/docs` for further detailed information and examples.

#### Utilities
The `Utilities` macros are generic and are used in many other SAS&reg; macro programs. These macros can be used as building blocks, and some can be used _inline_ in a SAS&reg; data step or SAS&reg; proc sql statement. See the Toolbox macro documentation under `/toolbox/docs` for further detailed information and examples.

#### Validation
The `Validation` macros are used for rule based data validation. They contain calls to generic utility macros. These macros can be used as building blocks for other macros or master program. See the Toolbox macro documentation under `/toolbox/docs` for further detailed information and examples.

## References
|Allianz|Deutsche Bank|ERGO|KfW DEG|Pfandbriefbank|Postbank|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[![Allianz](misc/images/logo-allianz.svg.png?h=25)](https://allianz.de)|[![Deutsche Bank](misc/images/logo-deutsche_bank.svg.png?h=25)](https://deutsche-bank.de)|[![ERGO](misc/images/logo-ergo.svg.png?h=25)](https://ergo.de)|[![KfW DEG](misc/images/logo-kfw_deg.svg.png?h=25)](https://deginvest.de)|[![Pfandbriefbank](misc/images/logo-pbb.svg.png?h=25)](https://pfandbriefbank.com)|[![Postbank](misc/images/logo-postbank.svg.png?h=25)](https://postbank.de)|

## Author
* [Paul Alexander Canals y Trocha](mailto:paul.canals@gmail.com)

## Contributors
* [Simone Koßmann](mailto:simone.kossmann@web.de)
* [Bruno Müller](mailto:bruno.mueller@sas.com)
* [Chris Hemedinger](mailto:chris.hemedinger@sas.com)
* [Dave Prinsloo](mailto:dave.prinsloo@yahoo.com)
* [Harry Droogendyk](mailto:harry@stratia.ca)
* [Michael Raithel](mailto:michaelraithel1@verizon.net)
* [Rick Wicklin, PhD](mailto:rick.wicklin@sas.com)
* [Tom Hoffman](mailto:trhoffman@sprynet.com)

## Other SAS Repositories

The following repositories are also worth checking out (alphabetically ordered):

* [chris-swenson/sasmacros](https://github.com/chris-swenson/sasmacros)
* [greg-wotton/sas-programs](https://github.com/greg-wootton/sas-programs)
* [KatjaGlassConsulting/SMILE-SmartSASMacros](https://github.com/KatjaGlassConsulting/SMILE-SmartSASMacros)
* [rogerjdeangelis](https://github.com/rogerjdeangelis)
* [SASJedi/sas-macros](https://github.com/SASJedi/sas-macros)
* [sasjs/core](https://github.com/sasjs/core)
* [sasjs/lint](https://github.com/sasjs/lint)
* [scottbass/sas](https://github.com/scottbass/SAS)
* [xieliaing/SAS](https://github.com/xieliaing/SAS)
* [yabwon/sas_packages](https://github.com/yabwon/SAS_PACKAGES)

## License Agreement

The software is provided under the *GNU General Public License (GPL), Version 3*. A copy of the license is provided as part of the Paul's SAS&reg; Utility Macros Toolbox.

For those not familiar with the GNU GPL, the license basically allows you to:

- Use any of the Toolbox software free at no charge.
- Distribute verbatim copies of the software in source or binary form.
- Sell verbatim copies of the software for a media fee, or sell support for the software.

What this license does ***not*** allow you to do is make changes or add features to any of the programs and then sell a binary distribution without source code. You must always provide source for any changes or additions to the software, and all code must be provided under the GPL as appropriate.
