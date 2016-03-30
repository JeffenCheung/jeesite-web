@echo off
rem author thinkgem@163.com
echo Compressor JS and CSS?
pause
cd %~dp0

:restart_hit

rem call compressor\compressor.bat bootstrap\bsie\css\bootstrap-ie6.css
rem call compressor\compressor.bat bootstrap\bsie\js\bootstrap-ie.js
rem call compressor\compressor.bat common
rem call compressor\compressor.bat jquery-plugin
rem call compressor\compressor.bat jquery-select2\3.4\select2.css
rem call compressor\compressor.bat jquery-select2\3.4\select2.js
rem call compressor\compressor.bat jquery-jbox\2.3\Skins\Bootstrap\jbox.css
rem call compressor\compressor.bat jquery-jbox\2.3\jquery.jBox-2.3.js
rem call compressor\compressor.bat jquery-validation\1.11.0\jquery.validate.css
rem call compressor\compressor.bat jquery-validation\1.11.0\jquery.validate.js
rem call compressor\compressor.bat jquery-ztree\3.5.12\css\zTreeStyle\zTreeStyle.css
rem call compressor\compressor.bat jerichotab\css\jquery.jerichotab.css
rem call compressor\compressor.bat jerichotab\js\jquery.jerichotab.js
rem call compressor\compressor.bat treeTable\themes\vsStyle\treeTable.css
rem call compressor\compressor.bat treeTable\jquery.treeTable.js
rem call compressor\compressor.bat supcan\supcan.js
rem call compressor\compressor.bat modules

rem modify by jeffen@pactera 2015/6/5
rem call compressor\compressor.bat common\jeesite.js
rem call compressor\compressor.bat common\jeesite.css
rem call compressor\compressor.bat bootstrap\table-fixed-header-master\table-fixed-header.css
rem call compressor\compressor.bat bootstrap\table-fixed-header-master\table-fixed-header.js
rem call compressor\compressor.bat bootstrap\table-fixed-header-master\duplicate_rows.js

call compressor\compressor.bat bootstrap\2.3.1\css_sdbi\bootstrap.css
call compressor\compressor.bat bootstrap\2.3.1\css_default\bootstrap.css
call compressor\compressor.bat bootstrap\2.3.1\css_united\bootstrap.css
call compressor\compressor.bat bootstrap\2.3.1\css_orange\bootstrap.css
call compressor\compressor.bat bootstrap\2.3.1\css_cerulean\bootstrap.css
call compressor\compressor.bat bootstrap\2.3.1\css_readable\bootstrap.css
call compressor\compressor.bat bootstrap\2.3.1\css_flat\bootstrap.css

rem add by jeffen@pactera 2016/1/24
rem call compressor\compressor.bat DataTables\1.10.10\js\fnReloadAjax.js
rem call compressor\compressor.bat DataTables\1.10.10\js\jquery.dataTables.js

rem call compressor\compressor.bat common\gridify.js

echo.
echo Compressor Success
pause
goto :restart_hit

echo on