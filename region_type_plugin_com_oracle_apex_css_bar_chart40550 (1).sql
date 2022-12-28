prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_210200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2021.10.15'
,p_release=>'21.2.0'
,p_default_workspace_id=>1473980843436064
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'PCS'
);
end;
/
 
prompt APPLICATION 103 - SWM-PCS
--
-- Application Export:
--   Application:     103
--   Name:            SWM-PCS
--   Date and Time:   11:04 Wednesday December 28, 2022
--   Exported By:     SAMEER
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 48135623091867865
--   Manifest End
--   Version:         21.2.0
--   Instance ID:     697879731379168
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_css_bar_chart40550
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(48135623091867865)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.CSS_BAR_CHART40550'
,p_display_name=>'CSS Cards V2'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure render_bar_chart (',
'    p_region in apex_plugin.t_region )',
'is',
'    -- constants for the columns of our region source query',
'    c_label_col constant pls_integer := 1;',
'    c_value_col constant pls_integer := 2;',
'    c_prev_col   constant pls_integer := 3;',
'    c_color_col constant pls_integer := 4;',
'',
'    -- attributes of the plug-in',
'    l_display_as           varchar2(20)    := nvl(p_region.attribute_13, ''VALUE_ABSOLUTE'');',
'    l_value_prefix         varchar2(40)    := p_region.attribute_02;',
'    l_value_postfix        varchar2(40)    := p_region.attribute_03;',
'    -- page items to submit = p_region.attribute_09',
'    l_max_rows             number          := to_number(p_region.attribute_10);',
'    l_region_source        varchar2(32767) := p_region.source;',
'',
'    l_valid_data_type_list wwv_flow_global.vc_arr2;',
'    l_column_value_list    apex_plugin_util.t_column_value_list2;',
'    l_max_value            number;',
'    l_total_value          number;',
'    l_label                varchar2(4000);',
'    l_value                number;',
'    l_url                  varchar2(4000);',
'    l_color                varchar2(4000);',
'    l_width                number;',
'    p_perc                   number;',
'    l_display_value        varchar2(4000);',
'begin',
'    -- define the valid column data types for the region query',
'    l_valid_data_type_list(c_label_col) := apex_plugin_util.c_data_type_varchar2;',
'    l_valid_data_type_list(c_value_col) := apex_plugin_util.c_data_type_number;',
'    l_valid_data_type_list(c_prev_col)   := apex_plugin_util.c_data_type_number;',
'    l_valid_data_type_list(c_color_col) := apex_plugin_util.c_data_type_varchar2;',
'                              -- get the data to be displayed',
'                               l_column_value_list := apex_plugin_util.get_data2 (',
'                               p_sql_statement  => l_region_source,',
'                               p_min_columns    => 2,',
'                               p_max_columns    => 4,',
'                               p_data_type_list => l_valid_data_type_list,',
'                               p_component_name => p_region.name,',
'                               p_max_rows       => l_max_rows );',
'',
'sys.htp.p(''<div class="Grid-Conatiner ''||p_region.attribute_13||''" >'');',
'',
'for i in 1 .. l_column_value_list(c_value_col).value_list.count loop',
'',
'BEGIN',
'p_perc := round(  ((to_number(l_column_value_list(c_value_col).value_list(i).number_value) - to_number(l_column_value_list(c_prev_col).value_list(i).number_value))',
'                / to_number(l_column_value_list(c_prev_col).value_list(i).number_value))*100,2);',
'EXCEPTION WHEN OTHERS THEN NULL;',
'END;',
'',
'',
'  sys.htp.p(''<a class="Grid-Item" href="''||p_region.attribute_14||''" ><span class="Grid-Upper" >''||l_column_value_list(c_label_col).value_list(i).varchar2_value||''</span></br>'');',
'  sys.htp.p(''<span class="Grid-Lower" >',
'  ''||p_region.attribute_02||to_char(l_column_value_list(c_value_col).value_list(i).number_value,''999,999,999,999'')||''</span></br>'');',
'  if p_region.attribute_12 = ''Y'' then ',
'  ',
'  if nvl(p_perc,0) > 0 then ',
'  sys.htp.p(''<span class="Perc-Area Val-Up" ><i class="t-icon fa fa-level-up" ></i> ''||p_perc||''%</span> <span>''||p_region.attribute_03||''</span>'');',
'  else',
'  sys.htp.p(''<span class="Perc-Area Val-Down" ><i class="t-icon fa fa-level-down" ></i> ''||p_perc||''%</span> <span>''||p_region.attribute_03||''</span>'');',
'  end if;',
'',
'  end if;',
'  sys.htp.p(''</a>'');',
'',
'end loop;',
'',
'sys.htp.p(''</div>'');',
'',
'',
'end render_bar_chart;',
'',
'',
'function render (',
'    p_region              in apex_plugin.t_region,',
'    p_plugin              in apex_plugin.t_plugin,',
'    p_is_printer_friendly in boolean )',
'    return apex_plugin.t_region_render_result',
'is',
'    l_page_items_to_submit varchar2(4000)  := p_region.attribute_09;',
'begin',
'    apex_css.add_file (',
'        p_name      => ''CSS_CARDS'',',
'        p_directory => p_plugin.file_prefix,',
'        p_version   => null );',
'',
'',
'    -- print our region data',
'    sys.htp.p(''<div id="''||p_region.static_id||''_chart" class="cbc">'');',
'',
'    render_bar_chart (',
'        p_region => p_region );',
'',
'    sys.htp.p(''</div>'');',
'/*',
'    apex_javascript.add_library (',
'        p_name      => ''com_oracle_apex_css_bar_chart40550'',',
'        p_directory => p_plugin.file_prefix,',
'        p_version   => null );',
'',
'    apex_javascript.add_onload_code (',
'        p_code => ''com_oracle_apex_css_bar_chart40550(''||',
'                      apex_javascript.add_value(p_region.static_id)||',
'                      ''{''||',
'                      apex_javascript.add_attribute(''pageItemsToSubmit'', apex_plugin_util.page_item_names_to_jquery(l_page_items_to_submit))||',
'                      apex_javascript.add_attribute(''ajaxIdentifier'',    apex_plugin.get_ajax_identifier, false, false)||',
'                      ''});'' );',
'                      */',
'',
'    return null;',
'end render;',
'',
'    function ajax (',
'    p_region              in apex_plugin.t_region,',
'    p_plugin              in apex_plugin.t_plugin )',
'    return apex_plugin.t_region_ajax_result',
'    is',
'    begin',
'    sys.owa_util.mime_header(''text/html'', false);',
'    sys.htp.p(''Cache-Control: no-cache'');',
'    sys.htp.p(''Pragma: no-cache'');',
'    sys.owa_util.http_header_close;',
'',
'    render_bar_chart (',
'        p_region => p_region );',
'',
'    return null;',
'    exception when others then',
'    sys.htp.p(''Error: ''||sqlerrm);',
'    end ajax;'))
,p_api_version=>1
,p_render_function=>'render'
,p_ajax_function=>'ajax'
,p_standard_attributes=>'SOURCE_SQL'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'0.9'
,p_about_url=>'http://apex.oracle.com/plugins'
,p_files_version=>23
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(48138279362867884)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Prefix for Value'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'$'
,p_display_length=>10
,p_max_length=>40
,p_is_translatable=>true
,p_help_text=>'Specify the prefix which should be added to the displayed value.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(48138644729867884)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Postfix for Percentage'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'VS Last Year'
,p_display_length=>10
,p_max_length=>40
,p_is_translatable=>true
,p_help_text=>'Specify the postfix which should be added after the percentage value.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(48139037289867885)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Page Items to Submit'
,p_attribute_type=>'PAGE ITEMS'
,p_is_required=>false
,p_is_translatable=>false
,p_help_text=>'Specify a comma separated list of page items that will be submitted to the server and thus, available for use from within your region source SQL statement.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(48139433770867885)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Maximum Rows'
,p_attribute_type=>'INTEGER'
,p_is_required=>true
,p_default_value=>'5'
,p_display_length=>3
,p_max_length=>3
,p_is_translatable=>false
,p_help_text=>'Defines the maximum number of rows to query and to display.'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(48198514002599007)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Add Precentage Area'
,p_attribute_type=>'CHECKBOX'
,p_is_required=>false
,p_default_value=>'N'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(48206961728668815)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>13
,p_display_sequence=>130
,p_prompt=>'Display As'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'flex-start'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(48207552896670645)
,p_plugin_attribute_id=>wwv_flow_api.id(48206961728668815)
,p_display_sequence=>10
,p_display_value=>'Float to Start'
,p_return_value=>'flex-start'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(48208196642672284)
,p_plugin_attribute_id=>wwv_flow_api.id(48206961728668815)
,p_display_sequence=>20
,p_display_value=>'Float to end'
,p_return_value=>'flex-end'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(48208770650676648)
,p_plugin_attribute_id=>wwv_flow_api.id(48206961728668815)
,p_display_sequence=>30
,p_display_value=>'Float in center'
,p_return_value=>'space-around'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(48288335306336990)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>14
,p_display_sequence=>140
,p_prompt=>'Link'
,p_attribute_type=>'LINK'
,p_is_required=>false
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(48141008544867896)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_name=>'SOURCE_SQL'
,p_is_required=>false
,p_sql_min_column_count=>2
,p_sql_max_column_count=>4
,p_depending_on_has_to_exist=>true
,p_examples=>wwv_flow_string.join(wwv_flow_t_varchar2(
'The region source has to be in the following format:',
'<pre>',
'select label,',
'       value,',
'       Prev_value',
'  from table',
' order by value',
'</pre>',
'<ul>',
'<li><strong>Label</strong> is the label ...</li>',
'<li><strong>Value</strong> is the value ... and has to be of type NUMBER</li>',
'<li><strong>Previous Value</strong> Prev Value is the value on which the Percentage has been calculated ... and has to be type NUMBER </li>',
'</ul>'))
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '0D0A7370616E2E477269642D5570706572207B0D0A20202020666F6E742D7765696768743A203530303B0D0A7D0D0A0D0A2E73706163652D61726F756E647B0D0A202020206A7573746966792D636F6E74656E743A2073706163652D61726F756E643B0D';
wwv_flow_api.g_varchar2_table(2) := '0A7D0D0A0D0A2E666C65782D73746172747B0D0A202020206A7573746966792D636F6E74656E743A20666C65782D73746172743B0D0A7D0D0A0D0A2E666C65782D656E647B0D0A202020206A7573746966792D636F6E74656E743A20666C65782D656E64';
wwv_flow_api.g_varchar2_table(3) := '3B0D0A7D0D0A0D0A2E477269642D436F6E6174696E65727B0D0A20202020646973706C61793A20666C65783B0D0A2020202077696474683A20313030253B0D0A202020202F2A6A7573746966792D636F6E74656E743A20666C65782D73746172743B2A2F';
wwv_flow_api.g_varchar2_table(4) := '0D0A7D0D0A0D0A2E477269642D4974656D207B0D0A2020202077696474683A20313030253B0D0A20202020746578742D616C69676E3A206C6566743B0D0A20202020626F726465723A2031707820736F6C696420236433643364333B0D0A202020207061';
wwv_flow_api.g_varchar2_table(5) := '6464696E672D746F703A203470783B0D0A2020202070616464696E672D626F74746F6D3A203670783B0D0A202020206D617267696E3A20313270783B0D0A20202020636F6C6F723A20626C61636B3B0D0A202020206261636B67726F756E642D636F6C6F';
wwv_flow_api.g_varchar2_table(6) := '723A2077686974653B0D0A20202020626F726465722D7261646975733A203870783B0D0A2020202070616464696E672D6C6566743A203770783B0D0A202020206D61782D77696474683A2032333670783B0D0A20202020626F782D736861646F773A2030';
wwv_flow_api.g_varchar2_table(7) := '203370782033707820726762283020302030202F20313425293B0D0A202020207472616E736974696F6E3A20302E34733B0D0A7D0D0A0D0A2E477269642D4974656D3A686F766572207B0D0A202020206261636B67726F756E643A202338303830383032';
wwv_flow_api.g_varchar2_table(8) := '363B0D0A20202020637572736F723A20706F696E7465723B0D0A7D0D0A0D0A7370616E2E477269642D4C6F776572207B0D0A20202020666F6E742D73697A653A20343070783B0D0A20202020666F6E742D7765696768743A203530303B0D0A202020206C';
wwv_flow_api.g_varchar2_table(9) := '696E652D6865696768743A20363470783B0D0A2020202077686974652D73706163653A206E6F777261703B0D0A7D0D0A0D0A2E506572632D55707B0D0A20202020636F6C6F723A20677265656E3B0D0A20202020666F6E742D7765696768743A20353030';
wwv_flow_api.g_varchar2_table(10) := '3B0D0A7D0D0A0D0A2E56616C2D55707B0D0A20202020636F6C6F723A677265656E0D0A7D0D0A0D0A2E56616C2D446F776E7B0D0A20202020636F6C6F723A7265640D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(48214048601755271)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_file_name=>'CSS_CARDS.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '7370616E2E477269642D55707065727B666F6E742D7765696768743A3530307D2E73706163652D61726F756E647B6A7573746966792D636F6E74656E743A73706163652D61726F756E647D2E666C65782D73746172747B6A7573746966792D636F6E7465';
wwv_flow_api.g_varchar2_table(2) := '6E743A666C65782D73746172747D2E666C65782D656E647B6A7573746966792D636F6E74656E743A666C65782D656E647D2E477269642D436F6E6174696E65727B646973706C61793A666C65783B77696474683A313030257D2E477269642D4974656D7B';
wwv_flow_api.g_varchar2_table(3) := '77696474683A313030253B746578742D616C69676E3A6C6566743B626F726465723A31707820736F6C696420236433643364333B70616464696E672D746F703A3470783B70616464696E672D626F74746F6D3A3670783B6D617267696E3A313270783B63';
wwv_flow_api.g_varchar2_table(4) := '6F6C6F723A233030303B6261636B67726F756E642D636F6C6F723A236666663B626F726465722D7261646975733A3870783B70616464696E672D6C6566743A3770783B6D61782D77696474683A32333670783B626F782D736861646F773A302033707820';
wwv_flow_api.g_varchar2_table(5) := '337078207267622830203020302F313425293B7472616E736974696F6E3A2E34737D2E477269642D4974656D3A686F7665727B6261636B67726F756E643A2338303830383032363B637572736F723A706F696E7465727D7370616E2E477269642D4C6F77';
wwv_flow_api.g_varchar2_table(6) := '65727B666F6E742D73697A653A343070783B666F6E742D7765696768743A3530303B6C696E652D6865696768743A363470783B77686974652D73706163653A6E6F777261707D2E506572632D55707B666F6E742D7765696768743A3530307D2E50657263';
wwv_flow_api.g_varchar2_table(7) := '2D55702C2E56616C2D55707B636F6C6F723A677265656E7D2E56616C2D446F776E7B636F6C6F723A7265647D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(48332887885745543)
,p_plugin_id=>wwv_flow_api.id(48135623091867865)
,p_file_name=>'CSS_CARDS.min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
