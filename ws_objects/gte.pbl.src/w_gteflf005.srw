$PBExportHeader$w_gteflf005.srw
forward
global type w_gteflf005 from window
end type
type cb_3 from commandbutton within w_gteflf005
end type
type st_1 from statictext within w_gteflf005
end type
type ddlb_1 from dropdownlistbox within w_gteflf005
end type
type cb_4 from commandbutton within w_gteflf005
end type
type section_detail from tab within w_gteflf005
end type
type tabpage_1 from userobject within section_detail
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within section_detail
dw_1 dw_1
end type
type tabpage_2 from userobject within section_detail
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within section_detail
dw_2 dw_2
end type
type tabpage_3 from userobject within section_detail
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within section_detail
dw_3 dw_3
end type
type tabpage_9 from userobject within section_detail
end type
type dw_9 from datawindow within tabpage_9
end type
type tabpage_9 from userobject within section_detail
dw_9 dw_9
end type
type tabpage_5 from userobject within section_detail
end type
type dw_5 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within section_detail
dw_5 dw_5
end type
type tabpage_4 from userobject within section_detail
end type
type dw_4 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within section_detail
dw_4 dw_4
end type
type tabpage_6 from userobject within section_detail
end type
type dw_6 from datawindow within tabpage_6
end type
type tabpage_6 from userobject within section_detail
dw_6 dw_6
end type
type tabpage_7 from userobject within section_detail
end type
type dw_7 from datawindow within tabpage_7
end type
type tabpage_7 from userobject within section_detail
dw_7 dw_7
end type
type tabpage_8 from userobject within section_detail
end type
type dw_8 from datawindow within tabpage_8
end type
type tabpage_8 from userobject within section_detail
dw_8 dw_8
end type
type tabpage_10 from userobject within section_detail
end type
type dw_10 from datawindow within tabpage_10
end type
type tabpage_10 from userobject within section_detail
dw_10 dw_10
end type
type tabpage_11 from userobject within section_detail
end type
type dw_12 from datawindow within tabpage_11
end type
type dw_11 from datawindow within tabpage_11
end type
type tabpage_11 from userobject within section_detail
dw_12 dw_12
dw_11 dw_11
end type
type section_detail from tab within w_gteflf005
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_9 tabpage_9
tabpage_5 tabpage_5
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_10 tabpage_10
tabpage_11 tabpage_11
end type
type cb_1 from commandbutton within w_gteflf005
end type
type cb_2 from commandbutton within w_gteflf005
end type
end forward

global type w_gteflf005 from window
integer width = 6318
integer height = 7784
boolean titlebar = true
string title = "(w_gteflf005) Section Planting"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_3 cb_3
st_1 st_1
ddlb_1 ddlb_1
cb_4 cb_4
section_detail section_detail
cb_1 cb_1
cb_2 cb_2
end type
global w_gteflf005 w_gteflf005

type variables
long ix,ll_ctr, ll_cnt, ll_year,ll_totplant, ll_hh, ll_hb, ll_ht,ll_st_year,ll_end_year, ll_syrmn,ll_pyear,ll_ayear,ll_amon,ll_treeadded,ll_treeremoved,ll_month, ll_noplant,ll_act_plant
string ls_temp,ls_del_ind,ls_tmp_id, ls_section_id,ls_last,ls_count, ls_jat, ls_hedging,ls_sec,ls_spid,ls_pjat, ls_ph, ls_type, ls_act,ls_ref, ls_secplant_ty, ls_prun_style, ls_detprunid
string ls_srep, ls_stype, ls_pstyle, ls_ytmt, ls_year, ls_inat
double ld_x, ld_y, ld_z, ld_std_plant, ld_area, ld_stdp,ld_fp,ld_sec_area,ld_forplt,ld_parea, ld_pheight, ld_theight
datetime ld_pdate, ld_date, ld_sdate, ld_spdate,ld_prundt
boolean lb_neworder, lb_query

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_sec_id, datetime fd_date)
public function integer wf_inquiry (string sec_id)
public function integer wf_check_fillcol3 (integer fl_row)
public function integer wf_check_dupmanuring (string fs_sec_id, string fs_type, string fs_activity, datetime fd_date)
public function integer wf_check_fillcol4 (integer fl_row)
public function integer wf_check_dupsoila (string fs_sec_id, long fl_year, long fl_month)
public function integer wf_check_fillcol5 (integer fl_row)
public function integer wf_check_dupshade (string fs_sec_id, datetime fd_date)
public function integer wf_check_fillcol6 (integer fl_row)
public function integer wf_check_duppluck (string fs_sec_id, datetime fd_date)
public function integer wf_check_fillcol7 (integer fl_row)
public function integer wf_check_fillcol11 (integer fl_row)
public function integer wf_check_dupprun (string fs_sec_id, datetime fd_prdate)
public function integer wf_check_dupuproot (string fs_sec_id, datetime fd_date)
public function integer wf_check_fillcol8 (integer fl_row)
public function integer wf_check_fillcol10 (integer fl_row)
public function integer wf_check_dupinf (string fs_sec_id, string fs_year, long fs_month)
public function integer wf_checkdup_pstage (string fs_sec_id, datetime fd_date)
public function integer wf_check_fillcol9 (integer fl_row)
end prototypes

event ue_option();//choose case gs_ueoption
//	case "PRINT"
//			OpenWithParm(w_print,this.dw_1)
//	case "PRINTPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = yes")
//	case "RESETPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = no")
//	case "SAVEAS"
//			this.dw_1.saveas()
//	case "FILTER"
//			setnull(gs_filtertext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setfilter(gs_filtertext)
//			this.dw_1.filter()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//	case "SORT"
//			setnull(gs_sorttext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setsort(gs_sorttext)
//			this.dw_1.sort()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//end choose
end event

public function integer wf_check_fillcol (integer fl_row);if Section_Detail.tabpage_1.dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_1.dw_1.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_1.dw_1.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_1.dw_1.getitemdatetime(fl_row,'spd_date')) or &
		 isnull(Section_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'spd_plants')) or  Section_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'spd_plants') = 0 or &
		 isnull(Section_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'spd_plantarea')) or  Section_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'spd_plantarea') = 0 or &
		 isnull(Section_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'spd_nolabours')) or Section_Detail.tabpage_1.dw_1.getitemnumber(fl_row,'spd_nolabours') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Plantation Date, Planted Bush, Planted Area, No. Of Labours, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_sec_id, datetime fd_date);long fl_row
string ls_sec_id1
datetime ld_pdt1

Section_Detail.tabpage_1.dw_1.SelectRow(0, FALSE)
if Section_Detail.tabpage_1.dw_1.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_1.dw_1.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_1.dw_1.getitemstring(fl_row,'section_id')
		ld_pdt1 = Section_Detail.tabpage_1.dw_1.getitemdatetime(fl_row,'spd_date')
		
		if ls_sec_id1 = fs_sec_id and ld_pdt1 = fd_date then
			Section_Detail.tabpage_1.dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_inquiry (string sec_id);Section_Detail.tabpage_1.dw_1.settransobject(sqlca)
Section_Detail.tabpage_1.dw_1.retrieve(gs_user,sec_id)

Section_Detail.tabpage_2.dw_2.settransobject(sqlca)
Section_Detail.tabpage_2.dw_2.retrieve(gs_user,sec_id)

Section_Detail.tabpage_3.dw_3.settransobject(sqlca)
Section_Detail.tabpage_3.dw_3.retrieve(gs_user,sec_id)

Section_Detail.tabpage_9.dw_9.settransobject(sqlca)
Section_Detail.tabpage_9.dw_9.retrieve(gs_user,sec_id)

Section_Detail.tabpage_4.dw_4.settransobject(sqlca)
Section_Detail.tabpage_4.dw_4.retrieve(gs_user,sec_id)

Section_Detail.tabpage_5.dw_5.settransobject(sqlca)
Section_Detail.tabpage_5.dw_5.retrieve(gs_user,sec_id)

Section_Detail.tabpage_6.dw_6.settransobject(sqlca)
Section_Detail.tabpage_6.dw_6.retrieve(gs_user,sec_id)

Section_Detail.tabpage_7.dw_7.settransobject(sqlca)
Section_Detail.tabpage_7.dw_7.retrieve(gs_user,sec_id)

Section_Detail.tabpage_8.dw_8.settransobject(sqlca)
Section_Detail.tabpage_8.dw_8.retrieve(gs_user,sec_id)

Section_Detail.tabpage_10.dw_10.settransobject(sqlca)
Section_Detail.tabpage_10.dw_10.retrieve(gs_user,sec_id)

Section_Detail.tabpage_11.dw_11.settransobject(sqlca)
Section_Detail.tabpage_11.dw_12.settransobject(sqlca)
Section_Detail.tabpage_11.dw_11.reset()
Section_Detail.tabpage_11.dw_12.reset()
Section_Detail.tabpage_11.dw_11.modify(' b_3.visible = true')
Section_Detail.tabpage_11.dw_11.modify(' b_4.visible = true')
Section_Detail.tabpage_11.dw_11.modify(' b_5.visible = true')
Section_Detail.tabpage_11.dw_11.modify(' b_6.visible = true')
Section_Detail.tabpage_11.dw_11.retrieve(gs_user,sec_id)
// to be check by prabhat
if Section_Detail.tabpage_11.dw_11.getrow() > 0 then
	Section_Detail.tabpage_11.dw_12.retrieve(Section_Detail.tabpage_11.dw_11.getitemstring(Section_Detail.tabpage_11.dw_11.getrow(),'prun_id'))
end if
// Checked and Corrected 25/05/2011
lb_neworder = false

return 1
end function

public function integer wf_check_fillcol3 (integer fl_row);if Section_Detail.tabpage_3.dw_3.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_3.dw_3.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_3.dw_3.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_3.dw_3.getitemdatetime(fl_row,'secplant_date')) or &
		 isnull(Section_Detail.tabpage_3.dw_3.getitemstring(fl_row,'sectionplant_jat')) or  len(Section_Detail.tabpage_3.dw_3.getitemstring(fl_row,'sectionplant_jat')) = 0 or &
		 isnull(Section_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'secplant_nolabours')) or  Section_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'secplant_nolabours') = 0 or &
		 isnull(Section_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'secplant_noplant')) or Section_Detail.tabpage_3.dw_3.getitemnumber(fl_row,'secplant_noplant') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Date, Planted Jat, No Of Plants, No. Of Labours, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_dupmanuring (string fs_sec_id, string fs_type, string fs_activity, datetime fd_date);long fl_row
string ls_sec_id1, ls_type1,ls_act1
datetime ld_dt1

Section_Detail.tabpage_4.dw_4.SelectRow(0, FALSE)
if Section_Detail.tabpage_4.dw_4.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_4.dw_4.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'section_id')
		ld_dt1 = Section_Detail.tabpage_4.dw_4.getitemdatetime(fl_row,'mfwd_date')
		ls_type1 = Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_type')
		ls_act1 = Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_activitytype')
		
		if ls_sec_id1 = fs_sec_id and ld_dt1 = fd_date  and ls_type1 = fs_type and ls_act1 = fs_activity then
			Section_Detail.tabpage_4.dw_4.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcol4 (integer fl_row);if Section_Detail.tabpage_4.dw_4.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_4.dw_4.getitemdatetime(fl_row,'mfwd_date')) or &
		 isnull(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_type')) or  len(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_type')) = 0 or &
		 isnull(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_activitytype')) or  len(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_activitytype')) = 0 or &
		 isnull(Section_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mfwd_area')) or  Section_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mfwd_area') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Manuring/Foilaring/ Wedding Type, Activity Type, Date, Area, Please Check !!!')
		 return -1
	end if
end if
return 1

//	if (isnull(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'section_id'))=0 or &
//		 isnull(Section_Detail.tabpage_4.dw_4.getitemdatetime(fl_row,'mfwd_date')) or &
//		 isnull(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_type')) or  len(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_type')) = 0 or &
//		 isnull(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_activitytype')) or  len(Section_Detail.tabpage_4.dw_4.getitemstring(fl_row,'mfwd_activitytype')) = 0 or &
//		 isnull(Section_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mfwd_nolabours')) or  Section_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mfwd_nolabours') = 0 or &
//		 isnull(Section_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mfwd_area')) or  Section_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mfwd_area') = 0 or &
//		 isnull(Section_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mfwd_nobush')) or Section_Detail.tabpage_4.dw_4.getitemnumber(fl_row,'mfwd_nobush') = 0) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Manuring/Foilaring/ Wedding Type, Activity Type, Date, No Of Bush,No. Of Labours, Area, Please Check !!!')

end function

public function integer wf_check_dupsoila (string fs_sec_id, long fl_year, long fl_month);long fl_row, ll_year1, ll_mon1
string ls_sec_id1
datetime ld_dt1

Section_Detail.tabpage_5.dw_5.SelectRow(0, FALSE)
if Section_Detail.tabpage_5.dw_5.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_5.dw_5.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_5.dw_5.getitemstring(fl_row,'section_id')
		ll_year1 = Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_year')
		ll_mon1 = Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_month')
		
		if ls_sec_id1 = fs_sec_id and ll_year1 = fl_year  and ll_mon1 = fl_month then
			Section_Detail.tabpage_5.dw_5.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcol5 (integer fl_row);if Section_Detail.tabpage_5.dw_5.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_5.dw_5.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_5.dw_5.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_5.dw_5.getitemstring(fl_row,'soil_type')) or  len(Section_Detail.tabpage_5.dw_5.getitemstring(fl_row,'soil_type')) = 0 or &
		 isnull(Section_Detail.tabpage_5.dw_5.getitemstring(fl_row,'soil_desc')) or  len(Section_Detail.tabpage_5.dw_5.getitemstring(fl_row,'soil_desc')) = 0 or &
		 isnull(Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_year')) or  Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_year') = 0 or &
		 isnull(Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_month')) or  Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_month') = 0 or &
		 isnull(Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_ph')) or  Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_ph') = 0 or &
		 isnull(Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_c')) or  Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_c') = 0 or &
		 isnull(Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_k2o')) or  Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_k2o') = 0 or &
		 isnull(Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_s')) or Section_Detail.tabpage_5.dw_5.getitemnumber(fl_row,'soil_s') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Analysis Year, Month, Type, Soil PH, C, K2O, S, Description, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_dupshade (string fs_sec_id, datetime fd_date);long fl_row, ll_year1, ll_mon1
string ls_sec_id1
datetime ld_dt1

Section_Detail.tabpage_6.dw_6.SelectRow(0, FALSE)
if Section_Detail.tabpage_6.dw_6.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_6.dw_6.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_6.dw_6.getitemstring(fl_row,'section_id')
		ld_dt1 = Section_Detail.tabpage_6.dw_6.getitemdatetime(fl_row,'shade_date')
		
		if ls_sec_id1 = fs_sec_id and ld_dt1 = fd_date then
			Section_Detail.tabpage_6.dw_6.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcol6 (integer fl_row);if Section_Detail.tabpage_6.dw_6.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_6.dw_6.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_6.dw_6.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_6.dw_6.getitemdatetime(fl_row,'shade_date')) or &
		 isnull(Section_Detail.tabpage_6.dw_6.getitemstring(fl_row,'shade_jat')) or  len(Section_Detail.tabpage_6.dw_6.getitemstring(fl_row,'shade_jat')) = 0 or &
		 isnull(Section_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'shade_nolabours')) or  Section_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'shade_nolabours') = 0 or &
		 isnull(Section_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'shade_distx')) or  Section_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'shade_distx') = 0 or &
		 isnull(Section_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'shade_disty')) or Section_Detail.tabpage_6.dw_6.getitemnumber(fl_row,'shade_disty') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Date, No. Of Labours, Shading Jat, Shade Plant Spacing X or Y, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duppluck (string fs_sec_id, datetime fd_date);long fl_row
string ls_sec_id1
datetime ld_dt1

Section_Detail.tabpage_7.dw_7.SelectRow(0, FALSE)
if Section_Detail.tabpage_7.dw_7.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_7.dw_7.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_7.dw_7.getitemstring(fl_row,'section_id')
		ld_dt1 = Section_Detail.tabpage_7.dw_7.getitemdatetime(fl_row,'spr_date')
		
		if ls_sec_id1 = fs_sec_id and ld_dt1 = fd_date then
			Section_Detail.tabpage_7.dw_7.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcol7 (integer fl_row);if Section_Detail.tabpage_7.dw_7.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_7.dw_7.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_7.dw_7.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_7.dw_7.getitemdatetime(fl_row,'spr_date')) or &
		 isnull(Section_Detail.tabpage_7.dw_7.getitemnumber(fl_row,'spr_areacovered')) or  Section_Detail.tabpage_7.dw_7.getitemnumber(fl_row,'spr_areacovered') = 0 or &
		 isnull(Section_Detail.tabpage_7.dw_7.getitemnumber(fl_row,'spr_mandays')) or  Section_Detail.tabpage_7.dw_7.getitemnumber(fl_row,'spr_mandays') = 0 or &
		 isnull(Section_Detail.tabpage_7.dw_7.getitemnumber(fl_row,'spr_gl')) or Section_Detail.tabpage_7.dw_7.getitemnumber(fl_row,'spr_gl') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Plucked Area Today, Own GL, Mandays, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_fillcol11 (integer fl_row);if Section_Detail.tabpage_11.dw_12.rowcount() > 0 and fl_row > 0 then
	if (	 isnull(Section_Detail.tabpage_11.dw_12.getitemdatetime(fl_row,'prun_date')) or &
		 isnull(Section_Detail.tabpage_11.dw_12.getitemnumber(fl_row,'prun_nolabours')) or  Section_Detail.tabpage_11.dw_12.getitemnumber(fl_row,'prun_nolabours') = 0 or &
		 isnull(Section_Detail.tabpage_11.dw_12.getitemnumber(fl_row,'prun_nobush')) or  Section_Detail.tabpage_11.dw_12.getitemnumber(fl_row,'prun_nobush') = 0 or &
		 isnull(Section_Detail.tabpage_11.dw_12.getitemnumber(fl_row,'prun_area')) or Section_Detail.tabpage_11.dw_12.getitemnumber(fl_row,'prun_area') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Prun Date, No. Of Bush Pruned, No. Of Labours, Pruned Area, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_dupprun (string fs_sec_id, datetime fd_prdate);long fl_row
string ls_sec_id1
datetime ld_prdt1

Section_Detail.tabpage_11.dw_12.SelectRow(0, FALSE)
if Section_Detail.tabpage_11.dw_12.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_11.dw_12.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_11.dw_11.getitemstring(1,'section_id')
		ld_prdt1 = Section_Detail.tabpage_11.dw_12.getitemdatetime(fl_row,'prun_date')
		
		if ls_sec_id1 = fs_sec_id and ld_prdt1 = fd_prdate then
			Section_Detail.tabpage_11.dw_12.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_dupuproot (string fs_sec_id, datetime fd_date);long fl_row
string ls_sec_id1
datetime ld_dt1

Section_Detail.tabpage_8.dw_8.SelectRow(0, FALSE)
if Section_Detail.tabpage_8.dw_8.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_8.dw_8.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_8.dw_8.getitemstring(fl_row,'section_id')
		ld_dt1 = Section_Detail.tabpage_8.dw_8.getitemdatetime(fl_row,'su_date')
		
		if ls_sec_id1 = fs_sec_id and ld_dt1 = fd_date then
			Section_Detail.tabpage_8.dw_8.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcol8 (integer fl_row);if Section_Detail.tabpage_8.dw_8.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_8.dw_8.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_8.dw_8.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_8.dw_8.getitemdatetime(fl_row,'su_date')) or &
		 isnull(Section_Detail.tabpage_8.dw_8.getitemnumber(fl_row,'su_uparea')) or  Section_Detail.tabpage_8.dw_8.getitemnumber(fl_row,'su_uparea') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Uprooting Date, Uprooted Area, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_fillcol10 (integer fl_row);if Section_Detail.tabpage_10.dw_10.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_year')) or  len(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_year'))=0 or &
		 isnull(Section_Detail.tabpage_10.dw_10.getitemnumber(fl_row,'infect_month')) or  Section_Detail.tabpage_10.dw_10.getitemnumber(fl_row,'infect_month') = 0 or &
		 isnull(Section_Detail.tabpage_10.dw_10.getitemnumber(fl_row,'infect_area')) or  Section_Detail.tabpage_10.dw_10.getitemnumber(fl_row,'infect_area') = 0 or &
		 isnull(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_nature')) or  len(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_nature'))=0 or &
		 isnull(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_type')) or  len(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_type'))=0 or &
		 isnull(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_medicineused')) or  len(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_medicineused'))=0 or &
		 isnull(Section_Detail.tabpage_10.dw_10.getitemnumber(fl_row,'infect_qnty')) or  Section_Detail.tabpage_10.dw_10.getitemnumber(fl_row,'infect_qnty') = 0 or &
		 isnull(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_unit')) or  len(Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_unit'))=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Year, Month, Infected Area,Symptom, Type, Medicin Used, Quantity and Unit, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_dupinf (string fs_sec_id, string fs_year, long fs_month);long fl_row, ll_mon1
string ls_sec_id1, ls_year1
datetime ld_dt1

Section_Detail.tabpage_10.dw_10.SelectRow(0, FALSE)
if Section_Detail.tabpage_10.dw_10.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_10.dw_10.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'section_id')
		ls_year1 = Section_Detail.tabpage_10.dw_10.getitemstring(fl_row,'infect_year')
		ll_mon1 = Section_Detail.tabpage_10.dw_10.getitemnumber(fl_row,'infect_month')
		
		if ls_sec_id1 = fs_sec_id and long(ls_year1) = long(fs_year) and ll_mon1 = fs_month then
			Section_Detail.tabpage_10.dw_10.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_checkdup_pstage (string fs_sec_id, datetime fd_date);long fl_row
string ls_sec_id1
datetime ld_pdt1

Section_Detail.tabpage_2.dw_2.SelectRow(0, FALSE)
if Section_Detail.tabpage_2.dw_2.rowcount() > 1 then
	for fl_row = 1 to (Section_Detail.tabpage_2.dw_2.rowcount())
		ls_sec_id1 = Section_Detail.tabpage_2.dw_2.getitemstring(fl_row,'section_id')
		ld_pdt1 = Section_Detail.tabpage_2.dw_2.getitemdatetime(fl_row,'ss_date')
		
		if ls_sec_id1 = fs_sec_id and ld_pdt1 = fd_date  then
			Section_Detail.tabpage_2.dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_fillcol9 (integer fl_row);if Section_Detail.tabpage_9.dw_9.rowcount() > 0 and fl_row > 0 then
	if (isnull(Section_Detail.tabpage_9.dw_9.getitemstring(fl_row,'section_id')) or  len(Section_Detail.tabpage_9.dw_9.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(Section_Detail.tabpage_9.dw_9.getitemdatetime(fl_row,'secplant_date')) or &
		 isnull(Section_Detail.tabpage_9.dw_9.getitemstring(fl_row,'sectionplant_jat')) or  len(Section_Detail.tabpage_9.dw_9.getitemstring(fl_row,'sectionplant_jat')) = 0 or &
		 isnull(Section_Detail.tabpage_9.dw_9.getitemnumber(fl_row,'secplant_nolabours')) or  Section_Detail.tabpage_9.dw_9.getitemnumber(fl_row,'secplant_nolabours') = 0 or &
		 isnull(Section_Detail.tabpage_9.dw_9.getitemnumber(fl_row,'secplant_noplant')) or Section_Detail.tabpage_9.dw_9.getitemnumber(fl_row,'secplant_noplant') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Date, Planted Jat, No Of Plants, No. Of Labours, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

on w_gteflf005.create
this.cb_3=create cb_3
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_4=create cb_4
this.section_detail=create section_detail
this.cb_1=create cb_1
this.cb_2=create cb_2
this.Control[]={this.cb_3,&
this.st_1,&
this.ddlb_1,&
this.cb_4,&
this.section_detail,&
this.cb_1,&
this.cb_2}
end on

on w_gteflf005.destroy
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_4)
destroy(this.section_detail)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;
if f_openwindow(section_detail.tabpage_1.dw_1) = -1 then	
	close(this)
	return 1
end if

lb_query = false	
lb_neworder = false

setpointer(hourglass!)
ddlb_1.reset()

DECLARE c1 CURSOR FOR  
  select SECTION_NAME ||' ('||trim(SECTION_ID)||')'  from fb_section where nvl(SECTION_ACTIVE_IND,'Y') = 'Y';
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_sec;
do while sqlca.sqlcode <> 100
	ddlb_1.additem(ls_sec)
	fetch c1 into :ls_sec;
loop
END IF
close c1;
setpointer(arrow!)

//this.tag = Message.StringParm
//ll_user_level = long(this.tag)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if
end event

type cb_3 from commandbutton within w_gteflf005
integer x = 2930
integer y = 12
integer width = 590
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Plant Stage Calculation"
end type

event clicked;
if string(today(),'mm') <> '01' then
	messagebox('Warning!',string(today(),'mm')+' Plant Stage Calculation can be Done In The Month Of January Only, Please Check !!!')
	return 1
else
	setpointer(hourglass!)
	DECLARE c2 CURSOR FOR  
	select a.SECTION_ID, SECTIONPLANT_YEAR from FB_SECTION a, FB_SECTIONPLANTATION b
	where a.SECTION_ID = b.SECTION_ID (+)	order by a.SECTION_ID;
	
	open c2;
		
	IF sqlca.sqlcode = 0 THEN
		fetch c2 into :ls_section_id,:ll_year;
		do while sqlca.sqlcode <> 100
		select distinct 'x' into :ls_temp from fb_sectionstage where SECTION_ID = :ls_section_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			if (long(string(today(),'YYYY')) - ll_year) = 0 then
				update fb_sectionstage set  SS_TYPE = '0Y', SS_DATE = sysdate where section_id = :ls_section_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating Plant Stage',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif (long(string(today(),'YYYY')) - ll_year) <= 5 then
				update fb_sectionstage set  SS_TYPE = 'YT', SS_DATE = sysdate where section_id = :ls_section_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating Plant Stage',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif (long(string(today(),'YYYY')) - ll_year) > 5 then
				update fb_sectionstage set  SS_TYPE = 'MT', SS_DATE = sysdate where section_id = :ls_section_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating Plant Stage',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if
		elseif sqlca.sqlcode = 100 then
			if (long(string(today(),'YYYY')) - ll_year) = 0 then
				insert into fb_sectionstage(section_id,SS_TYPE,SS_DATE) values (:ls_section_id,'0Y',sysdate);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Plant Stage',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif (long(string(today(),'YYYY')) - ll_year) <= 5 then
				insert into fb_sectionstage(section_id,SS_TYPE,SS_DATE) values (:ls_section_id,'YT',sysdate);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Plant Stage',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif (long(string(today(),'YYYY')) - ll_year) > 5 then
				insert into fb_sectionstage(section_id,SS_TYPE,SS_DATE) values (:ls_section_id,'MT',sysdate);
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Plant Stage',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if
		end if
		fetch c2 into :ls_section_id,:ll_year;
		loop
	END IF
	close c2;
	commit using sqlca;
	setpointer(hourglass!)
end if
end event

type st_1 from statictext within w_gteflf005
integer x = 37
integer y = 24
integer width = 229
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Section"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteflf005
integer x = 306
integer y = 16
integer width = 1445
integer height = 852
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

type cb_4 from commandbutton within w_gteflf005
integer x = 2085
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	close(parent)
else
 	return
end if
end event

type section_detail from tab within w_gteflf005
event create ( )
event destroy ( )
integer x = 5
integer y = 128
integer width = 4503
integer height = 2072
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_9 tabpage_9
tabpage_5 tabpage_5
tabpage_4 tabpage_4
tabpage_6 tabpage_6
tabpage_7 tabpage_7
tabpage_8 tabpage_8
tabpage_10 tabpage_10
tabpage_11 tabpage_11
end type

on section_detail.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_9=create tabpage_9
this.tabpage_5=create tabpage_5
this.tabpage_4=create tabpage_4
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.tabpage_8=create tabpage_8
this.tabpage_10=create tabpage_10
this.tabpage_11=create tabpage_11
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_9,&
this.tabpage_5,&
this.tabpage_4,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_10,&
this.tabpage_11}
end on

on section_detail.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_9)
destroy(this.tabpage_5)
destroy(this.tabpage_4)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
destroy(this.tabpage_8)
destroy(this.tabpage_10)
destroy(this.tabpage_11)
end on

type tabpage_1 from userobject within section_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Section Planting"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 28
integer width = 4411
integer height = 1760
integer taborder = 40
string dataobject = "dw_gteflf005"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'spd_entry_by',gs_user)
		dw_1.setitem(newrow,'spd_entry_dt',datetime(today()))
		dw_1.setcolumn('section_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_1.deleterow(1)
	Section_Detail.tabpage_1.dw_1.modify(' b_2.visible = false')
	Section_Detail.tabpage_1.dw_1.modify(' b_2.enabled = false')
end if
if dw_1.rowcount() = 0 then
	Section_Detail.tabpage_1.dw_1.modify(' b_2.visible = false')
	Section_Detail.tabpage_1.dw_1.modify(' b_2.enabled = false')
end if

end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_1.deleterow(1)
	Section_Detail.tabpage_1.dw_1.modify(' b_2.visible = false')
	Section_Detail.tabpage_1.dw_1.modify(' b_2.enabled = false')
end if
if dw_1.rowcount() = 0 then
	Section_Detail.tabpage_1.dw_1.modify(' b_2.visible = false')
	Section_Detail.tabpage_1.dw_1.modify(' b_2.enabled = false')
end if

end event

event itemchanged;
if dwo.name = 'spd_date'  then
	ld_pdate = datetime(data)
	ls_section_id = dw_1.getitemstring(row,'section_id')
	
	if f_check_initial_space(string(ld_pdate)) = -1 then return 1

	if  wf_check_duplicate_rec(ls_section_id,ld_pdate) = -1 then return 1
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
		ll_end_year = (long(string(today(),'YYYY'))*100)+3;
	else
		ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
		ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
	end if;

//	if (long(right(string(ld_pdate,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_pdate,'dd/mm/yyyy'),4,2))) < ll_st_year or &
//	   (long(right(string(ld_pdate,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_pdate,'dd/mm/yyyy'),4,2)))  > ll_end_year then
//		messagebox('Warning!','Plantation Date Should Be Between Current Financial Year, Please Check !!!')
//		return 1
//	end if
end if

if dwo.name = 'spd_plantarea'  then
	ld_area = double(data)
	ls_section_id = dw_1.getitemstring(row,'section_id')
	
	if ld_area > ld_sec_area then
		messagebox('Warning!','Plantation Area Should Not Be Greater Than Section Area, Please Check !!!')
		return 1
	end if
	
	select round(nvl(section_formulaplants,0) / decode(nvl(section_area,0),0,1,nvl(section_area,0)),2) into :ld_fp  from fb_section where section_id = :ls_section_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Plantation Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		if isnull(ld_fp) then ld_fp = 0
		if isnull(ld_area) then ld_area = 0
		
		ld_forplt = ld_fp * ld_area
		if isnull(ld_forplt) then ld_forplt = 0
		dw_1.setitem(1,'spd_formulaplants',ld_forplt)
	end if	
end if

Section_Detail.tabpage_1.dw_1.setitem(row,'spd_entry_by',gs_user)
Section_Detail.tabpage_1.dw_1.setitem(row,'spd_entry_dt',datetime(today()))


Section_Detail.tabpage_1.dw_1.modify(' b_2.visible = true')
Section_Detail.tabpage_1.dw_1.modify(' b_2.enabled = true')

//If Trim(Me.cmbunit.text) = "Null" Then
//    '1 hectere  =  107635 sqft
//    '1 null = 144 sqft
//    '1 null = ((1 x 144) / 107635)hectere
//    farea = ((Val(Me.txtarea.text) * 144) / 107635)
//ElseIf Trim(Me.cmbunit.text) = "Acre" Then
//    '1 acre  =  43560 sqft
//    '1 hectere = 2.47 acre
//    '1 acre = (1 / 2.47) hectere
//    farea = Val(Me.txtarea.text) / 2.47
//ElseIf Trim(Me.cmbunit.text) = "Hectere" Then
//    farea = Val(Me.txtarea.text)
//End If

//fp = (Val(sfplant) / Val(sarea)) * Val(Me.txtarea.text)

end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if

	select nvl(SECTION_AREA,0), SECTIONPLANT_YEAR, SECTIONPLANT_JAT, SECTIONPLANT_HEDGING, 
			 HEDGING_HEDGES, HEDGING_BUSHES, HEDGING_TREELINES, 
			round(nvl(b.SECTION_AREA,0) * ((nvl(to_number(trim(SECTIONPLANT_HEDGING)),0) * 107635) / (nvl(HEDGING_BUSHES,0) * (nvl(HEDGING_HEDGES,0) + nvl(HEDGING_TREELINES,0)))),2) std_plant
	into :ld_sec_area,:ll_year, :ls_pjat, :ls_ph, :ll_hh, :ll_hb, :ll_ht, :ld_stdp
	from fb_sectionplantation a, fb_section b
	WHERE a.SECTION_ID = b.SECTION_ID and a.SECTION_ID = :ls_section_id and 
				SECTIONPLANT_YEAR in (select  max(SECTIONPLANT_YEAR) from fb_sectionplantation where SECTION_ID = :ls_section_id);
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_1.scrolltorow(dw_1.insertrow(1))
		dw_1.setitem(1,'section_id',ls_section_id)
		dw_1.setitem(1,'sectionplant_year',ll_year)
		dw_1.setitem(1,'sectionplant_jat',ls_pjat)
		dw_1.setitem(1,'sectionplant_hedging',ls_ph)
		dw_1.setitem(1,'hedging_hedges',ll_hh)
		dw_1.setitem(1,'hedging_bushes',ll_hb)
		dw_1.setitem(1,'hedging_treelines',ll_ht)
		dw_1.setitem(1,'std_plant',ld_stdp)
		dw_1.setitem(1,'spd_entry_by',gs_user)
		dw_1.setitem(1,'spd_entry_dt',datetime(today()))
		dw_1.setcolumn('spd_date')
	end if
	
	select secplant_id into :ls_spid from fb_sectionplantation 
	where section_id= :ls_section_id and sectionplant_year=(select max(sectionplant_year) from fb_sectionplantation where section_id= :ls_section_id);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Standard Plant Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_1.setitem(1,'secplant_id',ls_spid)
	end if
	
	select distinct 'x' into :ls_temp from fb_sectionuproot where SECTION_ID= :ls_section_id and to_number(to_char(su_date,'YYYY')) = (select max(sectionplant_year) from fb_sectionplantation where section_id= :ls_section_id);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Standard Plant Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_1.setitem(1,'spd_new_re_plant','REPLANT')
	elseif sqlca.sqlcode = 100 then
		dw_1.setitem(1,'spd_new_re_plant','NEWPLANT')
	end if
end if

if dwo.name = 'b_2' then
	if dw_1.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
	IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'section_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'section_id'))=0) THEN
		 dw_1.deleterow(dw_1.rowcount())
	END IF
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_1.rowcount() to 1 step -1
			if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_1.deleterow(ll_ctr)
			end if
		next	
		
		if dw_1.rowcount() > 0 then
			for ll_ctr = 1 to dw_1.rowcount( ) 
				ls_section_id = dw_1.getitemstring(ll_ctr,'section_id')
				ll_noplant = dw_1.getitemnumber(ll_ctr,'spd_plants')

				select distinct 'x' into :ls_temp from fb_section where section_id = :ls_section_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					update fb_section set SECTION_ACTUALPLANTS = (nvl(to_number(SECTION_ACTUALPLANTS),0) + nvl(:ll_noplant,0))  where section_id = :ls_section_id;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Actual Plants',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				end if
			next	
		end if
		
		if dw_1.update(true,false) = 1 then
			dw_1.resetupdate();
			commit using sqlca;
			dw_1.modify(' b_2.visible = true')
			dw_1.modify(' b_2.enabled = true')
			dw_1.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

type tabpage_2 from userobject within section_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Plant Stage"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 14
integer y = 16
integer width = 2990
integer height = 1804
integer taborder = 80
string title = "none"
string dataobject = "dw_gteflf006"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_2.deleterow(1)
	Section_Detail.tabpage_2.dw_2.modify(' b_2.visible = false')
	Section_Detail.tabpage_2.dw_2.modify(' b_2.enabled = false')
end if
if dw_2.rowcount() = 0 then
	Section_Detail.tabpage_2.dw_2.modify(' b_2.visible = false')
	Section_Detail.tabpage_2.dw_2.modify(' b_2.enabled = false')
end if

end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_2.deleterow(1)
	Section_Detail.tabpage_2.dw_2.modify(' b_2.visible = false')
	Section_Detail.tabpage_2.dw_2.modify(' b_2.enabled = false')
end if
if dw_2.rowcount() = 0 then
	Section_Detail.tabpage_2.dw_2.modify(' b_2.visible = false')
	Section_Detail.tabpage_2.dw_2.modify(' b_2.enabled = false')
end if
end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'ss_type'  then
	ls_section_id = dw_2.getitemstring(row,'section_id')
	ld_pdate	= dw_2.getitemdatetime(row,'ss_date')
	
	if f_check_initial_space(string(ls_type)) = -1 then return 1
	if f_check_special_char(string(ls_type)) = -1 then return 1

	//if  wf_checkdup_pstage(ls_section_id,ld_pdate) = -1 then return 1
end if

Section_Detail.tabpage_2.dw_2.modify(' b_2.visible = true')
Section_Detail.tabpage_2.dw_2.modify(' b_2.enabled = true')

end event

type tabpage_3 from userobject within section_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Counting"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from datawindow within tabpage_3
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 14
integer y = 16
integer width = 3913
integer height = 1804
integer taborder = 90
string title = "none"
string dataobject = "dw_gteflf007"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_3.deleterow(1)
	Section_Detail.tabpage_3.dw_3.modify(' b_2.visible = false')
	Section_Detail.tabpage_3.dw_3.modify(' b_2.enabled = false')
end if
if dw_3.rowcount() = 0 then
	Section_Detail.tabpage_3.dw_3.modify(' b_2.visible = false')
	Section_Detail.tabpage_3.dw_3.modify(' b_2.enabled = false')
end if

end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_3.deleterow(1)
	Section_Detail.tabpage_3.dw_3.modify(' b_3.visible = false')
	Section_Detail.tabpage_3.dw_3.modify(' b_3.enabled = false')
end if
if dw_3.rowcount() = 0 then
	Section_Detail.tabpage_3.dw_3.modify(' b_3.visible = false')
	Section_Detail.tabpage_3.dw_3.modify(' b_3.enabled = false')
end if
end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if
	
	dw_3.scrolltorow(dw_3.insertrow(1))
	dw_3.setitem(1,'section_id',ls_section_id)
	dw_3.setitem(1,'secplant_type','Counting')
	dw_3.setitem(1,'secplant_entry_by',gs_user)
	dw_3.setitem(1,'secplant_entry_dt',datetime(today()))
	dw_3.setcolumn('secplant_type')
end if

if dwo.name = 'b_2' then
	if dw_3.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
//	IF (isnull(dw_3.getitemstring(dw_3.rowcount(),'section_id')) or len(dw_3.getitemstring(dw_3.rowcount(),'section_id'))=0) THEN
//		 dw_3.deleterow(dw_3.rowcount())
//	END IF
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_3.rowcount() to 1 step -1
			if dw_3.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_3.deleterow(ll_ctr)
			end if
		next	
		
		if dw_3.rowcount() > 0 then
			for ll_ctr = 1 to dw_3.rowcount( ) 
				IF wf_check_fillcol3(ll_ctr) = -1 THEN 
					return 1
				end if
				ls_section_id = dw_3.getitemstring(ll_ctr,'section_id')
				ls_secplant_ty = dw_3.getitemstring(ll_ctr,'secplant_type')
				ll_noplant = dw_3.getitemnumber(ll_ctr,'secplant_noplant')
				select distinct 'x' into :ls_temp from fb_section where section_id = :ls_section_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if ls_secplant_ty = 'Counting' then
						update fb_section set SECTION_ACTUALPLANTS = to_char(:ll_noplant) where section_id = :ls_section_id;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Updating Actual Plants',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
					elseif ls_secplant_ty = 'Infilling' then
						update fb_section set SECTION_ACTUALPLANTS = to_char(nvl(to_number(SECTION_ACTUALPLANTS),0) + nvl(:ll_noplant,0)) where section_id = :ls_section_id;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Updating Increasing Actual Plants',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
					end if
				end if
			next	
		end if

		
		if dw_3.update(true,false) = 1 then
			dw_3.resetupdate();
			commit using sqlca;
			dw_3.modify(' b_2.visible = true')
			dw_3.modify(' b_2.enabled = true')
			dw_3.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'secplant_type'  then
	ls_type = data
	ls_section_id = dw_3.getitemstring(row,'section_id')
	
	if f_check_initial_space(string(ls_type)) = -1 then return 1
	if f_check_special_char(string(ls_type)) = -1 then return 1
	
	select SECTIONPLANT_JAT 	into :ls_pjat	from fb_sectionplantation WHERE SECTION_ID = :ls_section_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_3.setitem(1,'sectionplant_jat',ls_pjat)
	end if


	//if  wf_checkdup_pstage(ls_section_id,ld_pdate,ls_type) = -1 then return 1
end if
Section_Detail.tabpage_3.dw_3.setitem(row,'secplant_entry_by',gs_user)
Section_Detail.tabpage_3.dw_3.setitem(row,'secplant_entry_dt',datetime(today()))

Section_Detail.tabpage_3.dw_3.modify(' b_2.visible = true')
Section_Detail.tabpage_3.dw_3.modify(' b_2.enabled = true')

end event

type tabpage_9 from userobject within section_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Infilling"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_9 dw_9
end type

on tabpage_9.create
this.dw_9=create dw_9
this.Control[]={this.dw_9}
end on

on tabpage_9.destroy
destroy(this.dw_9)
end on

type dw_9 from datawindow within tabpage_9
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 14
integer y = 16
integer width = 3913
integer height = 1804
integer taborder = 20
string title = "none"
string dataobject = "dw_gteflf019"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_9.deleterow(1)
	Section_Detail.tabpage_9.dw_9.modify(' b_2.visible = false')
	Section_Detail.tabpage_9.dw_9.modify(' b_2.enabled = false')
end if
if dw_9.rowcount() = 0 then
	Section_Detail.tabpage_9.dw_9.modify(' b_2.visible = false')
	Section_Detail.tabpage_9.dw_9.modify(' b_2.enabled = false')
end if

end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_9.deleterow(1)
	Section_Detail.tabpage_9.dw_9.modify(' b_3.visible = false')
	Section_Detail.tabpage_9.dw_9.modify(' b_3.enabled = false')
end if
if dw_9.rowcount() = 0 then
	Section_Detail.tabpage_9.dw_9.modify(' b_3.visible = false')
	Section_Detail.tabpage_9.dw_9.modify(' b_3.enabled = false')
end if
end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if
	
	dw_9.scrolltorow(dw_9.insertrow(1))
	dw_9.setitem(1,'section_id',ls_section_id)
	dw_9.setitem(1,'secplant_type','Infilling')
	dw_9.setitem(1,'secplant_entry_by',gs_user)
	dw_9.setitem(1,'secplant_entry_dt',datetime(today()))
	dw_9.setcolumn('secplant_type')

end if

if dwo.name = 'b_2' then
	if dw_9.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
//	IF (isnull(dw_9.getitemstring(dw_9.rowcount(),'section_id')) or len(dw_9.getitemstring(dw_9.rowcount(),'section_id'))=0) THEN
//		 dw_9.deleterow(dw_9.rowcount())
//	END IF
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_9.rowcount() to 1 step -1
			if dw_9.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_9.deleterow(ll_ctr)
			end if
		next	
		
		if dw_9.rowcount() > 0 then
			for ll_ctr = 1 to dw_9.rowcount( ) 
				IF wf_check_fillcol9(ll_ctr) = -1 THEN 
					return 1
				end if
				ls_section_id = dw_9.getitemstring(ll_ctr,'section_id')
				ls_secplant_ty = dw_9.getitemstring(ll_ctr,'secplant_type')
				ll_noplant = dw_9.getitemnumber(ll_ctr,'secplant_noplant')
				select distinct 'x' into :ls_temp from fb_section where section_id = :ls_section_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if ls_secplant_ty = 'Counting' then
						update fb_section set SECTION_ACTUALPLANTS = to_char(:ll_noplant) where section_id = :ls_section_id;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Updating Actual Plants',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
					elseif ls_secplant_ty = 'Infilling' then
						update fb_section set SECTION_ACTUALPLANTS = to_char(nvl(to_number(SECTION_ACTUALPLANTS),0) + nvl(:ll_noplant,0)) where section_id = :ls_section_id;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Updating Increasing Actual Plants',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
					end if
				end if
			next	
		end if

		
		if dw_9.update(true,false) = 1 then
			dw_9.resetupdate();
			commit using sqlca;
			dw_9.modify(' b_2.visible = true')
			dw_9.modify(' b_2.enabled = true')
			dw_9.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'secplant_type'  then
	ls_type = data
	ls_section_id = dw_9.getitemstring(row,'section_id')
	
	if f_check_initial_space(string(ls_type)) = -1 then return 1
	if f_check_special_char(string(ls_type)) = -1 then return 1
	
	select SECTIONPLANT_JAT 	into :ls_pjat	from fb_sectionplantation WHERE SECTION_ID = :ls_section_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_9.setitem(1,'sectionplant_jat',ls_pjat)
	end if


	//if  wf_checkdup_pstage(ls_section_id,ld_pdate,ls_type) = -1 then return 1
end if
Section_Detail.tabpage_9.dw_9.setitem(row,'secplant_entry_by',gs_user)
Section_Detail.tabpage_9.dw_9.setitem(row,'secplant_entry_dt',datetime(today()))

Section_Detail.tabpage_9.dw_9.modify(' b_2.visible = true')
Section_Detail.tabpage_9.dw_9.modify(' b_2.enabled = true')

end event

type tabpage_5 from userobject within section_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Soil Analysis"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from datawindow within tabpage_5
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 16
integer width = 4343
integer height = 1804
integer taborder = 90
string title = "none"
string dataobject = "dw_gteflf012"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_5.deleterow(1)
	Section_Detail.tabpage_5.dw_5.modify(' b_2.visible = false')
	Section_Detail.tabpage_5.dw_5.modify(' b_2.enabled = false')
end if
if dw_5.rowcount() = 0 then
	Section_Detail.tabpage_5.dw_5.modify(' b_2.visible = false')
	Section_Detail.tabpage_5.dw_5.modify(' b_2.enabled = false')
end if
end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_5.deleterow(1)
	Section_Detail.tabpage_5.dw_5.modify(' b_2.visible = false')
	Section_Detail.tabpage_5.dw_5.modify(' b_2.enabled = false')
end if
if dw_5.rowcount() = 0 then
	Section_Detail.tabpage_5.dw_5.modify(' b_2.visible = false')
	Section_Detail.tabpage_5.dw_5.modify(' b_2.enabled = false')
end if
end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if
	
	select MAX(fb_sectionplantation.sectionplant_year) into :ll_pyear
	from fb_sectionplantation, fb_section 
	where fb_sectionplantation.section_id=fb_section.section_id and  fb_section.section_id= :ls_section_id and fb_section.section_uprootflag=0;
					  
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Plantation Year Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_5.scrolltorow(dw_5.insertrow(1))
		dw_5.setitem(1,'section_id',ls_section_id)
		dw_5.setitem(1,'pyear',ll_pyear)
		dw_5.setitem(1,'soil_entry_by',gs_user)
		dw_5.setitem(1,'soil_entry_dt',datetime(today()))
		dw_5.setcolumn('soil_year')
	end if
end if

if dwo.name = 'b_2' then
	if dw_5.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
//	IF (isnull(dw_5.getitemstring(dw_5.rowcount(),'section_id')) or len(dw_5.getitemstring(dw_5.rowcount(),'section_id'))=0) THEN
//		 dw_5.deleterow(dw_5.rowcount())
//	END IF
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_5.rowcount() to 1 step -1
			if dw_5.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_5.deleterow(ll_ctr)
			end if
		next	
		
		if dw_5.rowcount() > 0 then
			for ll_ctr = 1 to dw_5.rowcount( ) 
				IF wf_check_fillcol5(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if

		
		if dw_5.update(true,false) = 1 then
			dw_5.resetupdate();
			commit using sqlca;
			dw_5.modify(' b_2.visible = true')
			dw_5.modify(' b_2.enabled = true')
			dw_5.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'soil_year'  then
	ll_ayear = long(data)
	
	if f_check_initial_space(string(ll_ayear)) = -1 then return 1
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = long(string(today(),'YYYY'))-1;
		ll_end_year = long(string(today(),'YYYY'));
	else
		ll_st_year  = long(string(today(),'YYYY'));
		ll_end_year = long(string(today(),'YYYY'))+1;
	end if;
	if ll_ayear < ll_st_year or ll_ayear > ll_end_year then
		messagebox('Warning!','Analysis Year Should Be Of Current Financial Year, Please Check !!!')
		return 1
	end if
end if

if dwo.name = 'soil_month'  then
	ll_amon = long(data)
	ll_ayear = dw_5.getitemnumber(row,'soil_year')
	ls_section_id = dw_5.getitemstring(row,'section_id')

	if f_check_initial_space(string(ll_amon)) = -1 then return 1

	if  wf_check_dupsoila(ls_section_id,ll_ayear,ll_amon) = -1 then return 1
end if

if dwo.name = 'soil_desc'  then
	if f_check_initial_space(data) = -1 then return 1
end if

Section_Detail.tabpage_5.dw_5.setitem(row,'soil_entry_by',gs_user)
Section_Detail.tabpage_5.dw_5.setitem(row,'soil_entry_dt',datetime(today()))

Section_Detail.tabpage_5.dw_5.modify(' b_2.visible = true')
Section_Detail.tabpage_5.dw_5.modify(' b_2.enabled = true')

end event

type tabpage_4 from userobject within section_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Manuring/Foliaring/Weeding"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from datawindow within tabpage_4
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 16
integer width = 4343
integer height = 1804
integer taborder = 90
string title = "none"
string dataobject = "dw_gteflf014"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_4.deleterow(1)
	Section_Detail.tabpage_4.dw_4.modify(' b_2.visible = false')
	Section_Detail.tabpage_4.dw_4.modify(' b_2.enabled = false')
end if
if dw_4.rowcount() = 0 then
	Section_Detail.tabpage_4.dw_4.modify(' b_2.visible = false')
	Section_Detail.tabpage_4.dw_4.modify(' b_2.enabled = false')
end if
end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_4.deleterow(1)
	Section_Detail.tabpage_4.dw_4.modify(' b_2.visible = false')
	Section_Detail.tabpage_4.dw_4.modify(' b_2.enabled = false')
end if
if dw_4.rowcount() = 0 then
	Section_Detail.tabpage_4.dw_4.modify(' b_2.visible = false')
	Section_Detail.tabpage_4.dw_4.modify(' b_2.enabled = false')
end if
end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if
	
	select soil_remark, soil_type, ((soil_year * 100) + soil_month)
	into :ls_srep, :ls_stype, :ll_syrmn
	from fb_soilanalysis 
     where section_id= :ls_section_id and soil_year=(select max(soil_year) from fb_soilanalysis where section_id= :ls_section_id) and 
            	 soil_month=(select max(soil_month) from fb_soilanalysis where soil_year=(select max(soil_year) from fb_soilanalysis where section_id= :ls_section_id) and 
              section_id= :ls_section_id);
				  
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_4.scrolltorow(dw_4.insertrow(1))
		dw_4.setitem(1,'section_id',ls_section_id)
		dw_4.setitem(1,'soil_remark',ls_srep)
		dw_4.setitem(1,'soil_type',ls_stype)
		dw_4.setitem(1,'soil_ym',ll_syrmn)
		dw_4.setitem(1,'mfwd_entry_by',gs_user)
		dw_4.setitem(1,'mfwd_entry_dt',datetime(today()))
		dw_4.setitem(1,'mfwd_date',datetime(today()))
		dw_4.setcolumn('mfwd_type')
	elseif sqlca.sqlcode = 100 then
		dw_4.scrolltorow(dw_4.insertrow(1))
		dw_4.setitem(1,'section_id',ls_section_id)
		dw_4.setitem(1,'soil_remark',ls_srep)
		dw_4.setitem(1,'soil_type',ls_stype)
		dw_4.setitem(1,'soil_ym',string(today(),'YYYY'))
		dw_4.setitem(1,'mfwd_entry_by',gs_user)
		dw_4.setitem(1,'mfwd_entry_dt',datetime(today()))
		dw_4.setitem(1,'mfwd_date',datetime(today()))
		dw_4.setcolumn('mfwd_type')		
	end if
	
	select section_plantstatus into :ls_ytmt from fb_section where section_id= :ls_section_id;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_4.setitem(1,'section_plantstatus',ls_ytmt)
	end if

	select prun_style into :ls_pstyle from fb_pruningsession 
	where section_id = :ls_section_id and prun_year=(select max(prun_year) from fb_pruningsession where section_id= :ls_section_id);
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		dw_4.setitem(1,'prun_style',ls_pstyle)
	end if
end if

if dwo.name = 'b_2' then
	if dw_4.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
//	IF (isnull(dw_4.getitemstring(dw_4.rowcount(),'section_id')) or len(dw_4.getitemstring(dw_4.rowcount(),'section_id'))=0) THEN
//		 dw_4.deleterow(dw_4.rowcount())
//	END IF
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_4.rowcount() to 1 step -1
			if dw_4.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_4.deleterow(ll_ctr)
			end if
		next	
		
		if dw_4.rowcount() > 0 then
			for ll_ctr = 1 to dw_4.rowcount( ) 
				IF wf_check_fillcol4(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if

		
		if dw_4.update(true,false) = 1 then
			dw_4.resetupdate();
			commit using sqlca;
			dw_4.modify(' b_2.visible = true')
			dw_4.modify(' b_2.enabled = true')
			dw_4.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'mfwd_date'  then
	ld_date = datetime(data)
	ls_section_id = dw_4.getitemstring(row,'section_id')
	ls_type = dw_4.getitemstring(row,'mfwd_type')
	ls_act = dw_4.getitemstring(row,'mfwd_activitytype')
	
	if f_check_initial_space(string(ls_type)) = -1 then return 1
	

	if  wf_check_dupmanuring(ls_section_id,ls_type,ls_act,ld_date) = -1 then return 1
end if
if dwo.name = 'mfwd_area'  then
	ls_section_id = dw_4.getitemstring(row,'section_id')
	
	select  nvl(SECTION_AREA,0) into :ld_sec_area  from fb_section where section_id = :ls_section_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Plantation Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		if long(data) > ld_sec_area then
			messagebox('Warning!','Manuring/Foliaring/Weeding Area Should Not Be Greater Than Section Area, Please Check !!!')
			return 1
		end if
	end if
end if
Section_Detail.tabpage_4.dw_4.setitem(row,'mfwd_entry_by',gs_user)
Section_Detail.tabpage_4.dw_4.setitem(row,'mfwd_entry_dt',datetime(today()))

Section_Detail.tabpage_4.dw_4.modify(' b_2.visible = true')
Section_Detail.tabpage_4.dw_4.modify(' b_2.enabled = true')

end event

type tabpage_6 from userobject within section_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "ShadeTree Planting"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tabpage_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_6.destroy
destroy(this.dw_6)
end on

type dw_6 from datawindow within tabpage_6
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 16
integer width = 4439
integer height = 1804
integer taborder = 90
string title = "none"
string dataobject = "dw_gteflf013"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_6.deleterow(1)
	Section_Detail.tabpage_6.dw_6.modify(' b_2.visible = false')
	Section_Detail.tabpage_6.dw_6.modify(' b_2.enabled = false')
end if
if dw_6.rowcount() = 0 then
	Section_Detail.tabpage_6.dw_6.modify(' b_2.visible = false')
	Section_Detail.tabpage_6.dw_6.modify(' b_2.enabled = false')
end if
end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_6.deleterow(1)
	Section_Detail.tabpage_6.dw_6.modify(' b_2.visible = false')
	Section_Detail.tabpage_6.dw_6.modify(' b_2.enabled = false')
end if
if dw_6.rowcount() = 0 then
	Section_Detail.tabpage_6.dw_6.modify(' b_2.visible = false')
	Section_Detail.tabpage_6.dw_6.modify(' b_2.enabled = false')
end if
end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if
	
		dw_6.scrolltorow(dw_6.insertrow(1))
		dw_6.setitem(1,'section_id',ls_section_id)
		dw_6.setitem(1,'shade_entry_by',gs_user)
		dw_6.setitem(1,'shade_entry_dt',datetime(today()))
		dw_6.setitem(1,'shade_date',datetime(today()))
		dw_6.setcolumn('shade_date')
end if

if dwo.name = 'b_2' then
	if dw_6.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
//	IF (isnull(dw_6.getitemstring(dw_6.rowcount(),'section_id')) or len(dw_6.getitemstring(dw_6.rowcount(),'section_id'))=0) THEN
//		 dw_6.deleterow(dw_6.rowcount())
//	END IF
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_6.rowcount() to 1 step -1
			if dw_6.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_6.deleterow(ll_ctr)
			end if
		next	
		
		if dw_6.rowcount() > 0 then
			for ll_ctr = 1 to dw_6.rowcount( ) 
				IF wf_check_fillcol6(ll_ctr) = -1 THEN 
					return 1
				end if
				ls_section_id = dw_6.getitemstring(ll_ctr,'section_id')
				ll_treeadded = dw_6.getitemnumber(ll_ctr,'shade_treesinc')
				ll_treeremoved = dw_6.getitemnumber(ll_ctr,'shade_treesdec')
				
				select distinct 'x' into :ls_temp from fb_section where section_id = :ls_section_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then	
					update fb_section set section_shadetrees= nvl(section_shadetrees,0) + (nvl(:ll_treeadded,0) - nvl(:ll_treeremoved,0)) where section_id = :ls_section_id;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Section Details',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
				end if	
			next	
		end if

		
		if dw_6.update(true,false) = 1 then
			dw_6.resetupdate();
			commit using sqlca;
			dw_6.modify(' b_2.visible = true')
			dw_6.modify(' b_2.enabled = true')
			dw_6.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'shade_date'  then
	ld_sdate = datetime(data)
	ls_section_id = dw_6.getitemstring(row,'section_id')
	
	if f_check_initial_space(string(ld_sdate)) = -1 then return 1
	
	if ld_sdate > datetime(today()) then
		messagebox('Warning!','Shading Date Should Not Be > Current Date, Please Check !!!')
		return 1
	end if
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
		ll_end_year = (long(string(today(),'YYYY'))*100)+3;
	else
		ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
		ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
	end if;

	if (long(right(string(ld_sdate,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_sdate,'dd/mm/yyyy'),4,2))) < ll_st_year or &
	   (long(right(string(ld_sdate,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_sdate,'dd/mm/yyyy'),4,2)))  > ll_end_year then
		messagebox('Warning!','Shading Date Should Be Of Current Financial Year, Please Check !!!')
		return 1
	end if
	
	if  wf_check_dupshade(ls_section_id,ld_sdate) = -1 then return 1
end if
if dwo.name = 'shade_nolabours'  then
	ld_sdate = dw_6.getitemdatetime(row,'shade_date')
	ls_section_id = dw_6.getitemstring(row,'section_id')
	
	if  wf_check_dupshade(ls_section_id,ld_sdate) = -1 then return 1
end if
Section_Detail.tabpage_6.dw_6.setitem(row,'shade_entry_by',gs_user)
Section_Detail.tabpage_6.dw_6.setitem(row,'shade_entry_dt',datetime(today()))

Section_Detail.tabpage_6.dw_6.modify(' b_2.visible = true')
Section_Detail.tabpage_6.dw_6.modify(' b_2.enabled = true')

end event

type tabpage_7 from userobject within section_detail
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Plucking Area"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_7 dw_7
end type

on tabpage_7.create
this.dw_7=create dw_7
this.Control[]={this.dw_7}
end on

on tabpage_7.destroy
destroy(this.dw_7)
end on

type dw_7 from datawindow within tabpage_7
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 16
integer width = 4439
integer height = 1804
integer taborder = 90
string title = "none"
string dataobject = "dw_gteflf016a"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_7.deleterow(1)
	Section_Detail.tabpage_7.dw_7.modify(' b_2.visible = false')
	Section_Detail.tabpage_7.dw_7.modify(' b_2.enabled = false')
end if
if dw_7.rowcount() = 0 then
	Section_Detail.tabpage_7.dw_7.modify(' b_2.visible = false')
	Section_Detail.tabpage_7.dw_7.modify(' b_2.enabled = false')
end if
end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_7.deleterow(1)
	Section_Detail.tabpage_7.dw_7.modify(' b_2.visible = false')
	Section_Detail.tabpage_7.dw_7.modify(' b_2.enabled = false')
end if
if dw_7.rowcount() = 0 then
	Section_Detail.tabpage_7.dw_7.modify(' b_2.visible = false')
	Section_Detail.tabpage_7.dw_7.modify(' b_2.enabled = false')
end if
end event

event itemchanged;if dwo.name = 'spr_date'  then
	ld_spdate = datetime(data)
	ls_section_id = dw_7.getitemstring(row,'section_id')
	
	if f_check_initial_space(string(ld_spdate)) = -1 then return 1
	
	if ld_spdate > datetime(today()) then
		messagebox('Warning!','Shading Date Should Not Be > Current Date, Please Check !!!')
		return 1
	end if
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
		ll_end_year = (long(string(today(),'YYYY'))*100)+3;
	else
		ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
		ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
	end if;

	if (long(right(string(ld_spdate,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_spdate,'dd/mm/yyyy'),4,2))) < ll_st_year or &
	   (long(right(string(ld_spdate,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_spdate,'dd/mm/yyyy'),4,2)))  > ll_end_year then
		messagebox('Warning!','Plucking Date Should Be Of Current Financial Year, Please Check !!!')
		return 1
	end if
	
	if  wf_check_duppluck(ls_section_id,ld_spdate) = -1 then return 1
	
	select distinct 'x' into :ls_temp
	from fb_sectionpluckinground where SECTION_ID =  :ls_section_id and trunc(spr_date) = trunc(:ld_spdate);
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		messagebox('Warning!','Plucking Details Already Exists For The Selected Date, Please Check !!!')
		return 1
	end if
	
end if

if dwo.name = 'spr_areacovered'  then
	ld_parea = double(data)
	ls_section_id = dw_7.getitemstring(dw_7.getrow(),'section_id')
	
	select  nvl(SECTION_AREA,0) into :ld_sec_area from fb_section where SECTION_ID = :ls_section_id;
	if sqlca.sqlcode = -1 then
		messagebox('Error!','While Getting Section Area '+sqlca.sqlerrtext)
		return 1
	end if
	
	if ld_parea > ld_sec_area then
		messagebox('Warning!','Plucked Area Cannot Be Greater Than Section Area, Please Check !!!')
		return 1
	end if;
end if

Section_Detail.tabpage_7.dw_7.modify(' b_2.visible = true')
Section_Detail.tabpage_7.dw_7.modify(' b_2.enabled = true')

end event

type tabpage_8 from userobject within section_detail
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Uprooting"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_8 dw_8
end type

on tabpage_8.create
this.dw_8=create dw_8
this.Control[]={this.dw_8}
end on

on tabpage_8.destroy
destroy(this.dw_8)
end on

type dw_8 from datawindow within tabpage_8
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 23
integer y = 24
integer width = 2857
integer height = 1788
integer taborder = 60
string title = "none"
string dataobject = "dw_gteflf008"
boolean livescroll = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_8.deleterow(1)
	Section_Detail.tabpage_8.dw_8.modify(' b_2.visible = false')
	Section_Detail.tabpage_8.dw_8.modify(' b_2.enabled = false')
end if
if dw_8.rowcount() = 0 then
	Section_Detail.tabpage_8.dw_8.modify(' b_2.visible = false')
	Section_Detail.tabpage_8.dw_8.modify(' b_2.enabled = false')
end if
end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_8.deleterow(1)
	Section_Detail.tabpage_8.dw_8.modify(' b_2.visible = false')
	Section_Detail.tabpage_8.dw_8.modify(' b_2.enabled = false')
end if
if dw_8.rowcount() = 0 then
	Section_Detail.tabpage_8.dw_8.modify(' b_2.visible = false')
	Section_Detail.tabpage_8.dw_8.modify(' b_2.enabled = false')
end if
end event

event itemchanged;if dwo.name = 'su_date'  then
	ld_spdate = datetime(data)
	ls_section_id = dw_8.getitemstring(row,'section_id')
	
	if f_check_initial_space(string(ld_spdate)) = -1 then return 1
	
	if ld_spdate > datetime(today()) then
		messagebox('Warning!','Shading Date Should Not Be > Current Date, Please Check !!!')
		return 1
	end if
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
		ll_end_year = (long(string(today(),'YYYY'))*100)+3;
	else
		ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
		ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
	end if;

	if (long(right(string(ld_spdate,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_spdate,'dd/mm/yyyy'),4,2))) < ll_st_year or &
	   (long(right(string(ld_spdate,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_spdate,'dd/mm/yyyy'),4,2)))  > ll_end_year then
		messagebox('Warning!','Plucking Date Should Be Of Current Financial Year, Please Check !!!')
		return 1
	end if
	
	if  wf_check_dupuproot(ls_section_id,ld_spdate) = -1 then return 1
	
	select distinct 'x' into :ls_temp
	from fb_sectionuproot where SECTION_ID =  :ls_section_id and trunc(su_date) = trunc(:ld_spdate);
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		messagebox('Warning!','Plucking Details Already Exists For The Selected Date, Please Check !!!')
		return 1
	end if
	
end if

if dwo.name = 'su_uparea'  then
	ld_parea = double(data)
	ls_section_id = dw_8.getitemstring(dw_8.getrow(),'section_id')
	
	select  nvl(SECTION_AREA,0) into :ld_sec_area from fb_section where SECTION_ID = :ls_section_id;
	if sqlca.sqlcode = -1 then
		messagebox('Error!','While Getting Section Area '+sqlca.sqlerrtext)
		return 1
	end if
	
	if ld_parea > ld_sec_area then
		messagebox('Warning!','Uprooted Area Cannot Be Greater Than Section Area, Please Check !!!')
		return 1
	end if;
end if
Section_Detail.tabpage_8.dw_8.setitem(row,'su_entry_by',gs_user)
Section_Detail.tabpage_8.dw_8.setitem(row,'su_entry_dt',datetime(today()))

Section_Detail.tabpage_8.dw_8.modify(' b_2.visible = true')
Section_Detail.tabpage_8.dw_8.modify(' b_2.enabled = true')

end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if
		dw_8.scrolltorow(dw_8.insertrow(1))
		dw_8.setitem(1,'section_id',ls_section_id)
		dw_8.setitem(1,'su_entry_by',gs_user)
		dw_8.setitem(1,'su_entry_dt',datetime(today()))
		dw_8.setitem(1,'su_date',datetime(today()))
		dw_8.setcolumn('su_date')
end if

if dwo.name = 'b_2' then
	if dw_8.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
//	IF (isnull(dw_8.getitemstring(dw_8.rowcount(),'section_id')) or len(dw_8.getitemstring(dw_8.rowcount(),'section_id'))=0) THEN
//		 dw_8.deleterow(dw_8.rowcount())
//	END IF
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_8.rowcount() to 1 step -1
			if dw_8.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_8.deleterow(ll_ctr)
			end if
		next	
		
		if dw_8.rowcount() > 0 then
			for ll_ctr = 1 to dw_8.rowcount( ) 
				IF wf_check_fillcol8(ll_ctr) = -1 THEN 
					return 1
				end if
				ls_section_id = dw_8.getitemstring(ll_ctr,'section_id')
				ld_area = dw_8.getitemnumber(ll_ctr,'su_uparea')
				ll_noplant = dw_8.getitemnumber(ll_ctr,'su_noplant')
				
				select nvl(SECTION_AREA,0),nvl(to_number(SECTION_ACTUALPLANTS),0)  into :ld_sec_area, :ll_act_plant from fb_section 
				where section_id = :ls_section_id;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode = 0 then
					if ld_sec_area = ld_area then
						update fb_section set SECTION_ACTIVE_IND = 'N' where section_id = :ls_section_id;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Updating Section Active Ind',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
					elseif ld_sec_area <> ld_area and ll_act_plant >= ll_noplant then
						update fb_section set SECTION_ACTUALPLANTS = to_char(nvl(SECTION_ACTUALPLANTS,0) - nvl(:ll_noplant,0)) where section_id = :ls_section_id;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Updating Decreasing Actual Plants',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						end if
					end if
				end if
			next	
		end if

		
		if dw_8.update(true,false) = 1 then
			dw_8.resetupdate();
			commit using sqlca;
			dw_8.modify(' b_2.visible = true')
			dw_8.modify(' b_2.enabled = true')
			dw_8.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

type tabpage_10 from userobject within section_detail
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Plant Infection"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_10 dw_10
end type

on tabpage_10.create
this.dw_10=create dw_10
this.Control[]={this.dw_10}
end on

on tabpage_10.destroy
destroy(this.dw_10)
end on

type dw_10 from datawindow within tabpage_10
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 14
integer y = 20
integer width = 4448
integer height = 1828
integer taborder = 60
string title = "none"
string dataobject = "dw_gteflf010"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event ue_dwnkey;IF KeyDown(KeyF6!) THEN
	dw_10.deleterow(1)
	Section_Detail.tabpage_10.dw_10.modify(' b_2.visible = false')
	Section_Detail.tabpage_10.dw_10.modify(' b_2.enabled = false')
end if
if dw_10.rowcount() = 0 then
	Section_Detail.tabpage_10.dw_10.modify(' b_2.visible = false')
	Section_Detail.tabpage_10.dw_10.modify(' b_2.enabled = false')
end if
end event

event ue_keydwn;IF KeyDown(KeyF6!) THEN
	dw_10.deleterow(1)
	Section_Detail.tabpage_10.dw_10.modify(' b_2.visible = false')
	Section_Detail.tabpage_10.dw_10.modify(' b_2.enabled = false')
end if
if dw_10.rowcount() = 0 then
	Section_Detail.tabpage_10.dw_10.modify(' b_2.visible = false')
	Section_Detail.tabpage_10.dw_10.modify(' b_2.enabled = false')
end if
end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if
	
		dw_10.scrolltorow(dw_10.insertrow(1))
		dw_10.setitem(1,'section_id',ls_section_id)
		dw_10.setitem(1,'infect_entry_by',gs_user)
		dw_10.setitem(1,'infect_entry_dt',datetime(today()))
		dw_10.setitem(1,'infect_year',string(today(),'YYYY'))
		dw_10.setitem(1,'infect_month',string(today(),'MM'))
		dw_10.setcolumn('infect_year')
end if

if dwo.name = 'b_2' then
	if dw_10.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 
	
//	IF (isnull(dw_10.getitemstring(dw_10.rowcount(),'section_id')) or len(dw_10.getitemstring(dw_10.rowcount(),'section_id'))=0) THEN
//		 dw_10.deleterow(dw_10.rowcount())
//	END IF
	
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ll_ctr = dw_10.rowcount() to 1 step -1
			if dw_10.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_10.deleterow(ll_ctr)
			end if
		next	
		
		if dw_10.rowcount() > 0 then
			for ll_ctr = 1 to dw_10.rowcount( ) 
				IF wf_check_fillcol10(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if

		
		if dw_10.update(true,false) = 1 then
			dw_10.resetupdate();
			commit using sqlca;
			dw_10.modify(' b_2.visible = true')
			dw_10.modify(' b_2.enabled = true')
			dw_10.reset()
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 
end if
end event

event itemchanged;if dwo.name = 'infect_year'  then
	ls_year = data
	
	if f_check_initial_space(ls_year) = -1 then return 1
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = long(string(today(),'YYYY'))-1;
		ll_end_year = long(string(today(),'YYYY'));
	else
		ll_st_year  = long(string(today(),'YYYY'));
		ll_end_year = long(string(today(),'YYYY'))+1;
	end if;
	
	if long(ls_year) < ll_st_year or long(ls_year) > ll_end_year then
		messagebox('Warning!','Infection Year Should Be Of Current Financial Year, Please Check !!!')
		return 1
	end if
end if

if dwo.name = 'infect_nature'  then
	ls_inat = data
	if f_check_initial_space(ls_inat) = -1 then return 1
	if f_check_special_char(ls_inat) = -1 then return 1
	if f_check_alphanumeric(ls_inat) = -1 then return 1
	//if f_check_string_sp(ls_inat) = -1 then return 1
	
end if

if dwo.name = 'infect_type'  then
	if f_check_initial_space(data) = -1 then return 1
	if f_check_special_char(data) = -1 then return 1
	if f_check_alphanumeric(data) = -1 then return 1
end if

if dwo.name = 'infect_medicineused'  then
	if f_check_initial_space(data) = -1 then return 1
	if f_check_special_char(data) = -1 then return 1
	if f_check_alphanumeric(data) = -1 then return 1
end if

if dwo.name = 'infect_month'  then
	ll_month = long(data)
	ls_section_id = dw_10.getitemstring(row,'section_id')
	ls_year = dw_10.getitemstring(row,'infect_year')
	
	if  wf_check_dupinf(ls_section_id,ls_year, ll_month) = -1 then return 1
	
	select distinct 'x' into :ls_temp
	from fb_plantinfection where SECTION_ID =  :ls_section_id and to_number(infect_year) = to_number(:ls_year) and infect_month = :ll_month;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		messagebox('Warning!','Infection Details Already Exists For The Section Of Entered Year Month, Please Check !!!')
		return 1
	end if
	
end if

if dwo.name = 'infect_area'  then
	ld_parea = double(data)
	ls_section_id = dw_10.getitemstring(dw_10.getrow(),'section_id')
	
	select  nvl(SECTION_AREA,0) into :ld_sec_area from fb_section where SECTION_ID = :ls_section_id;
	if sqlca.sqlcode = -1 then
		messagebox('Error!','While Getting Section Area '+sqlca.sqlerrtext)
		return 1
	end if
	
	if ld_parea > ld_sec_area then
		messagebox('Warning!','Infected Area Cannot Be Greater Than Section Area, Please Check !!!')
		return 1
	end if;
end if

Section_Detail.tabpage_10.dw_10.setitem(row,'infect_entry_by',gs_user)
Section_Detail.tabpage_10.dw_10.setitem(row,'infect_entry_dt',datetime(today()))

Section_Detail.tabpage_10.dw_10.modify(' b_2.visible = true')
Section_Detail.tabpage_10.dw_10.modify(' b_2.enabled = true')

end event

type tabpage_11 from userobject within section_detail
integer x = 18
integer y = 108
integer width = 4466
integer height = 1948
long backcolor = 67108864
string text = "Pruning"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_12 dw_12
dw_11 dw_11
end type

on tabpage_11.create
this.dw_12=create dw_12
this.dw_11=create dw_11
this.Control[]={this.dw_12,&
this.dw_11}
end on

on tabpage_11.destroy
destroy(this.dw_12)
destroy(this.dw_11)
end on

type dw_12 from datawindow within tabpage_11
event key_down pbm_dwnrowchanging
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 494
integer y = 560
integer width = 2341
integer height = 1228
integer taborder = 70
string title = "none"
string dataobject = "dw_gteflf011a"
boolean vscrollbar = true
boolean livescroll = true
end type

event key_down;if currentrow <> dw_12.rowcount() then
//	IF wf_check_fillcol11(currentrow) = -1 THEN
//		return 1
//	END IF
END If

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event itemchanged;if dwo.name = 'prun_date'  then
	ls_section_id = dw_11.getitemstring(dw_11.getrow(),'section_id')
	ld_prundt = datetime(data)
	
	if wf_check_dupprun(ls_section_id,ld_prundt) = -1 then
		return 1
	end if	

	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
		ll_end_year = (long(string(today(),'YYYY'))*100)+3;
	else
		ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
		ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
	end if;

//	if (long(right(string(ld_prundt,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_prundt,'dd/mm/yyyy'),4,2))) < ll_st_year or &
//	   (long(right(string(ld_prundt,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_prundt,'dd/mm/yyyy'),4,2)))  > ll_end_year then
//		messagebox('Warning!','Prun Date Should Be Between Current Financial Year, Please Check !!!')
//		return 1
//	end if
end if

if dwo.name = 'prun_area'  then
	ld_parea = double(data)
	ls_section_id = dw_11.getitemstring(dw_11.getrow(),'section_id')
	
	select  nvl(SECTION_AREA,0) into :ld_sec_area from fb_section where SECTION_ID = :ls_section_id;
	if sqlca.sqlcode = -1 then
		messagebox('Error!','While Getting Section Area '+sqlca.sqlerrtext)
		return 1
	end if
	
	if ld_parea > ld_sec_area then
		messagebox('Warning!','Pruned Area Cannot Be Greater Than Section Area, Please Check !!!')
		return 1
	end if;
end if

if dwo.name = 'rec_ind' then
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = long(string(today(),'YYYY'))-1;
		ll_end_year = long(string(today(),'YYYY'));
	else
		ll_st_year  = long(string(today(),'YYYY'));
		ll_end_year = long(string(today(),'YYYY'))+1;
	end if;

	if dw_11.getitemnumber(dw_11.getrow(),'prun_year') >= ll_st_year and dw_11.getitemnumber(dw_11.getrow(),'prun_year') <= ll_end_year then
		dw_12.insertrow(0)
		dw_12.triggerevent("key_down")
	else
		dw_12.setitem(row,'rec_ind','N')			
		messagebox('Error During Selection','Records Can Be Inserted Only In Current Financial Year Data, Please Check !!!')
		return 1
	end if	

end if	

if dwo.name = 'del_flag' then
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = long(string(today(),'YYYY'))-1;
		ll_end_year = long(string(today(),'YYYY'));
	else
		ll_st_year  = long(string(today(),'YYYY'));
		ll_end_year = long(string(today(),'YYYY'))+1;
	end if;
	if dw_11.getitemnumber(dw_11.getrow(),'prun_year') < ll_st_year or dw_11.getitemnumber(dw_11.getrow(),'prun_year') > ll_end_year then
		messagebox('Error During Delete','Records Can Be Deleted Only Of Current Financial Year Data, Please Check !!!')
		dw_12.setitem(row,'del_flag','N')
		return 1
	end if	
end if	

if row = dw_12.rowcount() and dwo.name <> 'del_flag'  then
	dw_12.insertrow(0)
end if

Section_Detail.tabpage_11.dw_11.modify(' b_2.visible = true')
Section_Detail.tabpage_11.dw_11.modify(' b_2.enabled = true')


end event

type dw_11 from datawindow within tabpage_11
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 5
integer y = 8
integer width = 3456
integer height = 536
integer taborder = 60
string title = "none"
string dataobject = "dw_gteflf011"
boolean livescroll = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event clicked;if dwo.name = 'b_1' then	
	if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
		messagebox('Warning!','Please Select A Section !!!')
		return 1
	end if
	
	ls_section_id = left(right(ddlb_1.text,8),7)
	if long(string(today(),'mm')) < 4 then
		ll_year  = long(string(today(),'YYYY'))-1;
	else
		ll_year  = long(string(today(),'YYYY'));
	end if;

	select distinct 'x' into :ls_temp from fb_pruningsession where PRUN_YEAR = :ll_year and SECTION_ID = :ls_section_id;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Pruning Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 0 then
		select distinct max(PRUN_YEAR),max(PRUN_STYLE), max(PRUN_HEIGHT), max(PRUN_TIPPINGHEIGHT)  into :ll_year,:ls_prun_style,:ld_pheight, :ld_theight
		from fb_pruningsession where PRUN_YEAR = :ll_year and SECTION_ID = :ls_section_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Pruning Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then	
			dw_11.setitem(1,'prun_year',ll_year)
			dw_11.setitem(1,'prun_style',ls_prun_style)
			dw_11.setitem(1,'prun_height',ld_pheight)
			dw_11.setitem(1,'prun_tippingheight',ld_theight)
			dw_12.insertrow(0)
			dw_12.setcolumn('prun_date')
		end if
	elseif sqlca.sqlcode = 100 then	
			dw_11.reset()
			dw_12.reset()
			lb_neworder = true
			Section_Detail.tabpage_11.dw_11.modify(' b_3.visible = false')
			Section_Detail.tabpage_11.dw_11.modify(' b_4.visible = false')
			Section_Detail.tabpage_11.dw_11.modify(' b_5.visible = false')
			Section_Detail.tabpage_11.dw_11.modify(' b_6.visible = false')
			
			dw_11.scrolltorow(dw_11.insertrow(1))
			dw_11.setitem(1,'section_id',ls_section_id)
			dw_11.setitem(1,'prun_entry_by',gs_user)
			dw_11.setitem(1,'prun_entry_dt',datetime(today()))
			dw_11.setitem(1,'prun_year',ll_year)
	end if
end if
if dwo.name = 'b_3' then
	if dw_11.rowcount() > 0 then
		dw_11.ScrolltoRow(1)
	end if
end if
if dwo.name = 'b_4' then
	if dw_11.rowcount() > 0 then
		dw_11.ScrollPriorRow()
	end if
end if
if dwo.name = 'b_5' then
	if dw_11.rowcount() > 0 then
		dw_11.ScrollnextRow()
	end if
end if
if dwo.name = 'b_6' then
	if dw_11.rowcount() > 0 then
		dw_11.ScrolltoRow(dw_11.rowcount())
	end if
end if
if dwo.name = 'b_2' then
	if dw_11.accepttext() = -1 then
		messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
		return 
	end if 

	if dw_12.rowcount() > 1 then
		if (isnull(dw_12.getitemnumber(dw_12.rowcount(),'prun_nobush')) or dw_12.getitemnumber(dw_12.rowcount(),'prun_nobush') = 0) then 
			dw_12.deleterow(dw_12.rowcount())
		end if;
	end if
	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
		for ix = dw_12.rowcount() to 1 step -1
			if dw_12.getitemstring(ix,'del_flag') = 'Y' and dw_12.rowcount() = dw_12.getitemnumber(ix,'sel_row') then
				messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
				return 1
			elseif dw_12.getitemstring(ix,'del_flag') = 'Y' and dw_12.rowcount() <> dw_12.getitemnumber(ix,'sel_row') then
				dw_12.deleterow(ix)
			end if
		next	
		
		if dw_12.rowcount() = 0 then
			messagebox('Error','Records Should Be Available In Detail Block')
			return
		end if
		if dw_11.getitemstring(dw_11.getrow(),'prun_style') <> 'UP' then
			if (isnull(dw_11.getitemnumber(dw_11.getrow(),'prun_year')) or dw_11.getitemnumber(dw_11.getrow(),'prun_year') = 0 or &
				isnull(dw_11.getitemstring(dw_11.getrow(),'prun_style')) or len(dw_11.getitemstring(dw_11.getrow(),'prun_style')) = 0 or &
				isnull(dw_11.getitemnumber(dw_11.getrow(),'prun_height')) or dw_11.getitemnumber(dw_11.getrow(),'prun_height') = 0 or &
				isnull(dw_11.getitemnumber(dw_11.getrow(),'prun_tippingheight')) or dw_11.getitemnumber(dw_11.getrow(),'prun_tippingheight') = 0 ) then
				messagebox('Warning:','One Of The Fields Are Blank : Pruning Year, Pruning Style, Prun Height, Prun Tipping Height !!!')
				dw_11.setfocus()
				dw_11.setcolumn('prun_year')
				return
			end if
		
			if dw_12.rowcount() > 0 then
				for ll_ctr = 1 to dw_12.rowcount( ) 
//					IF wf_check_fillcol11(ll_ctr) = -1 THEN 
//						return 1
//					end if
				next	
			end if
		end if
		select nvl(MAX(prun_id),0) into :ls_last from fb_pruningsession;
		ls_last = right(ls_last,5)
		ll_cnt = long(ls_last)
		ll_cnt = ll_cnt + 1
		//select lpad(:ll_cnt,5,'0') into :ls_count from dual;
		ls_tmp_id = 'PRUN'+string(ll_cnt,'00000') //ls_count
		if isnull(dw_11.getitemstring(dw_11.getrow(),'prun_id')) or len(dw_11.getitemstring(dw_11.getrow(),'prun_id')) = 0 then
			dw_11.setitem(dw_11.getrow(),'prun_id',ls_tmp_id)
		end if
		for ix = 1 to dw_12.rowcount()
			ls_detprunid = dw_11.getitemstring(dw_11.getrow(),'prun_id')
			if isnull(dw_12.getitemstring(ix,'prun_id')) or len(dw_12.getitemstring(ix,'prun_id')) = 0 then
				dw_12.setitem(ix,'prun_id',ls_detprunid)
			end if
		next
		if dw_11.update(true,false) = 1 and dw_12.update(true,false) = 1 then
			dw_12.resetupdate();
			dw_11.resetupdate();
			commit using sqlca;
			
			dw_11.reset()
			dw_12.reset()
			Section_Detail.tabpage_11.dw_11.modify(' b_2.enabled = false')
			Section_Detail.tabpage_11.dw_11.modify(' b_2.visible = false')
		else
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else
		return
	end if 

end if
end event

event itemchanged;if lb_neworder = true and dw_12.rowcount() = 0 then
	dw_12.setfocus()
	dw_12.insertrow(0)
	dw_11.setfocus()
	dw_11.setcolumn('prun_style')		
end if;

if dwo.name = 'prun_year'  then
	ll_year = long(data)
	
	if long(string(today(),'mm')) < 4 then
		ll_st_year  = long(string(today(),'YYYY'))-1;
		ll_end_year = long(string(today(),'YYYY'));
	else
		ll_st_year  = long(string(today(),'YYYY'));
		ll_end_year = long(string(today(),'YYYY'))+1;
	end if;

	if ll_year < ll_st_year or ll_year  >= ll_end_year then
		messagebox('Warning!','Plucking Year Should Be Between Current Financial Year, Please Check !!!')
		return 1
	end if	
end if

if dwo.name = 'prun_style'  then
	if data = 'UP' then
		dw_11.setitem(row,'prun_height',0)
		dw_11.setitem(row,'prun_tippingheight',0)
		dw_12.setitem(dw_12.getrow(),'prun_date',datetime(today()))
		dw_12.setitem(dw_12.getrow(),'prun_nobush',0)
		dw_12.setitem(dw_12.getrow(),'prun_nolabours',0)
		dw_12.setitem(dw_12.getrow(),'prun_area',0)
	end if
end if
Section_Detail.tabpage_11.dw_11.setitem(row,'prun_entry_by',gs_user)
Section_Detail.tabpage_11.dw_11.setitem(row,'prun_entry_dt',datetime(today()))

Section_Detail.tabpage_11.dw_11.modify(' b_2.visible = true')
Section_Detail.tabpage_11.dw_11.modify(' b_2.enabled = true')

end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_11.rowcount() > 0 then
			ls_ref = dw_11.getitemstring(dw_11.getrow(),'prun_id')
			dw_12.reset()
			dw_12.retrieve(ls_ref)
		end if
	end if
end if
end event

type cb_1 from commandbutton within w_gteflf005
integer x = 1815
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Section !!!')
	return 1
end if
ls_section_id = left(right(ddlb_1.text,8),7)
wf_inquiry (ls_section_id)
end event

type cb_2 from commandbutton within w_gteflf005
integer x = 2354
integer y = 12
integer width = 576
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Plucking Area"
end type

event clicked;opensheetwithparm(w_gteflf016,this.tag,w_mdi,0,layered!)
end event

