/*!
 ******************************************************************************
 * \file       f_uc_xxx.sas
 * \ingroup    Functions
 * \brief      Custom function to <one-line description of the function>.
 * \details    The function <detailed description of the function>.  
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       yyyy-mm-dd hh:mm:ss
 * \version    YY.x
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  <name>      <description of the function parameter>
 * 
 * \return     <Describe what is returned by the function>
 * 
 * \usage
 * 
 * \calls
 *             + none
 * 
 * \example    Example 1: Show Hello reaction function
 * \code
 * 
 *             proc fcmp outlib=WORK.functions.ucfuncts;
 *                function f_uc_hello(text $) $ 100;
 *                   return(cat(compress(text,'?'),'-','World!'));
 *                endsub;
 *             quit;
 * 
 *             options cmplib=WORK.functions;
 * 
 *             data _null_;
 *                rc = f_uc_hello('Hello?');
 *                put rc;
 *             run;
 * 
 * \endcode
 * 
 * \copyright  Copyright 2008-2025 Paul Alexander Canals y Trocha.
 * 
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see <https://www.gnu.org/licenses/>.
 * 
 ******************************************************************************
 */
/*
proc fcmp outlib=WORK.functs.ucfuncts;
*/

   function f_uc_xxx(<name> [$]);


   endsub;

/*
quit;
*/
