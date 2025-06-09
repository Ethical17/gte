$PBExportHeader$w_gtelaf069.srw
forward
global type w_gtelaf069 from window
end type
type em_1 from editmask within w_gtelaf069
end type
type cb_8 from commandbutton within w_gtelaf069
end type
type cb_7 from commandbutton within w_gtelaf069
end type
type cb_6 from commandbutton within w_gtelaf069
end type
type cb_4 from commandbutton within w_gtelaf069
end type
type cb_3 from commandbutton within w_gtelaf069
end type
type cb_2 from commandbutton within w_gtelaf069
end type
type cb_1 from commandbutton within w_gtelaf069
end type
type dw_1 from datawindow within w_gtelaf069
end type
end forward

global type w_gtelaf069 from window
integer width = 3977
integer height = 1948
boolean titlebar = true
string title = "(W_Oblatf27) Extra work Details"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
event ue_option ( )
em_1 em_1
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelaf069 w_gtelaf069

type variables
string ls_temp, ls_from, ls_to, ls_text,ls_od_dt,ls_slip_ty, ls_time_fr, ls_time_to, ls_day_type,ls_emp_cd,ls_kam_id,ls_emptype,ls_labour_id,ls_prorata_ind ,ls_month
long  ll_tot,ll_cnt, ll_proxy,ll_adoleage,ll_child
double ld_tot_time,ld_status,ld_labage,ld_afrate, ld_ahrate, ld_adfrate,ld_adhrate, ld_cfrate,ld_chrate,ld_rate,ld_wages
boolean lb_query, lb_neworder
datetime ld_date
n_cst_powerfilter iu_powerfilter
datawindowchild idw_emp
end variables

forward prototypes
public function integer wf_check_fillcol (long fl_row)
public function integer wf_dup_frdt (string fs_fr_dt, string fl_emp_cd, string fs_frtime, string fs_totime, long fl_row)
public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid, double fd_attendance, long fl_row)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "SAVEAS"
			this.dw_1.SaveAs()		
	case "PDF"
			this.dw_1.SaveAs("c:\reports\ATR006.pdf",pdf!,true)		
	case "PSR"
			this.dw_1.saveas("c:\reports\ATR006.psr",PSReport!,true)
	case "SFILTER"
			iu_powerfilter.checked = NOT iu_powerfilter.checked
			iu_powerfilter.event ue_clicked()
			m_main.m_file.m_filter.checked = iu_powerfilter.checked	
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_1.setredraw(false)
			this.dw_1.setfilter(gs_filtertext)
			this.dw_1.filter()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_1.setredraw(false)
			this.dw_1.setsort(gs_sorttext)
			this.dw_1.sort()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose
end event

public function integer wf_check_fillcol (long fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemstring(fl_row,'od_emp_cd')) or (dw_1.getitemstring(fl_row,'od_emp_cd')="") or &
		 isnull(dw_1.getitemstring(fl_row,'od_slip_type')) or (dw_1.getitemstring(fl_row,'od_slip_type')="") or &
		 isnull(dw_1.getitemstring(fl_row,'od_type')) or (dw_1.getitemstring(fl_row,'od_type')="") or &
		 isnull(dw_1.getitemstring(fl_row,'od_time_from')) or (dw_1.getitemstring(fl_row,'od_time_from')="") or &
		 isnull(dw_1.getitemstring(fl_row,'od_time_to')) or (dw_1.getitemstring(fl_row,'od_time_to')="") or &
		 isnull(dw_1.getitemstring(fl_row,'od_eacsubhead_id')) or (dw_1.getitemstring(fl_row,'od_eacsubhead_id')="") or &
		 isnull(dw_1.getitemdatetime(fl_row,'od_date')) ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Employee Code, OT Slip Type, Document Type & Date, From & To Time , Kamjhari')
		 return -1
	end if
end if

return 1
end function

public function integer wf_dup_frdt (string fs_fr_dt, string fl_emp_cd, string fs_frtime, string fs_totime, long fl_row);dw_1.SelectRow(0, FALSE)
string ls_from1, ls_to1,ls_od_dt1,ls_emp_cd1

if dw_1.rowcount() > 2 then
   for fl_row = 1 to dw_1.rowcount() - 1
	ls_from1 = dw_1.getitemstring(fl_row,'od_time_from')
	ls_to1   = dw_1.getitemstring(fl_row,'od_time_to')
	ls_od_dt1 = string(dw_1.getitemdatetime(fl_row,'od_date'),'dd/mm/yyyy')
	ls_emp_cd1 = dw_1.getitemstring(fl_row,'emp_cd')
		
		
	   if (ls_emp_cd1 = fl_emp_cd and ls_od_dt1 = fs_fr_dt and ls_from1 = fs_frtime ) and fl_row <> dw_1.getrow() then
 	      messagebox("Error ","Duplicate Entry At Row No: "+string(fl_row))
		 dw_1.SelectRow(fl_row, TRUE)
	      return -1
		else 
			dw_1.SelectRow(fl_row, FALSE)
	   end if
   next 
end if
return 1

end function

public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid, double fd_attendance, long fl_row);select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
into :ll_adoleage, :ll_child
from fb_param_detail 
where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
		 trunc(:fd_date) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;


//select ((:fd_date - emp_dob) /365),EMP_TYPE  into :ld_labage, :ls_emptype  from fb_employee emp  where emp.emp_id= :ls_labour_id;

select get_diff(:fd_date,emp_dob,'B'),EMP_TYPE  into :ld_labage, :ls_emptype  from fb_employee emp  where emp.emp_id= :fs_labourid;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
// trunc(:ld_dt) between KAMSUB_FRDT and nvl(KAMSUB_TODT,sysdate) 
	
	select kam.kamsub_afrate afrate, kam.kamsub_ahrate ahrate, kam.kamsub_adfrate adfrate, kam.kamsub_adhrate adhrate, kam.kamsub_cfrate cfrate,kam.kamsub_chrate chrate 
		into :ld_afrate, :ld_ahrate, :ld_adfrate, :ld_adhrate, :ld_cfrate,:ld_chrate 
	 from fb_kamsubhead kam
	where trim(kam.kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if


if gs_garden_snm='MT' then		
	select PH_HOURS into :ld_prorata_hours from fb_prorata_hours where PH_DATE = trunc(:fd_date);
	
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Prorat Hours ',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		ld_prorata_hours=0
	end if
	
	if dw_1.getcolumnname() = 'lda_prorataind' then
		ls_prorata_ind = dw_1.gettext()
	else
		ls_prorata_ind = dw_1.getitemstring(dw_1.getrow(),'lda_prorataind')
	end if
	
//	if ld_prorata_hours > 0 and dw_1.getitemstring(fl_row,'lda_prorataind') ='Y'  then
	if ld_prorata_hours > 0 and ls_prorata_ind ='Y'  then
		If ld_labage <= ll_child Then //(144 months=12 years)
			 If fd_attendance = 1 Then
				 ld_rate = ld_cFrate - round(((ld_cFrate / 8) * ld_prorata_hours),0)
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_cHrate - round(((ld_cHrate / 8) * ld_prorata_hours),0)
			else
				 ld_rate = ld_cFrate - round((((ld_cFrate * fd_attendance) / 8) * ld_prorata_hours),0)
			 End If
		 ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_adfrate - round(((ld_adfrate / 8) * ld_prorata_hours),0)
			 elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_adhrate - round(((ld_adhrate / 8) * ld_prorata_hours),0)
			else
				 ld_rate = ld_adfrate - round((((ld_adfrate * fd_attendance) / 8) * ld_prorata_hours),0)
			 End If
		 ElseIf ld_labage > ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_afrate - round(((ld_afrate / 8) * ld_prorata_hours),0)
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_ahrate - round(((ld_ahrate / 8) * ld_prorata_hours),0)
			else
				 ld_rate = ld_afrate - round((((ld_afrate * fd_attendance) / 8) * ld_prorata_hours),0)
			 End If
		End If
	else
		If ld_labage <= ll_child Then //(144 months=12 years)
			 If fd_attendance = 1 Then
				 ld_rate = ld_cFrate
			elseif fd_attendance = 0.5 Then
				 ld_rate = ld_cHrate
			 else
				 ld_rate = ld_cFrate * fd_attendance
			End If
		 ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_adfrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_adhrate
			else
				 ld_rate = ld_adfrate * fd_attendance
			 End If
		 ElseIf ld_labage > ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_afrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_ahrate
			else
				 ld_rate = ld_afrate * fd_attendance
			 End If
		End If
	end if	
else	// Other than Matelli
		If ld_labage <= ll_child Then //(144 months=12 years)
			 If fd_attendance = 1 Then
				 ld_rate = ld_cFrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_cHrate
			else
				 ld_rate = ld_cFrate * fd_attendance
			 End If
		
		 ElseIf ld_labage > ll_child And ld_labage <= ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_adfrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_adhrate
			else
				 ld_rate = ld_adfrate * fd_attendance
			 End If
		 ElseIf ld_labage > ll_adoleage Then
			 If fd_attendance = 1 Then
				 ld_rate = ld_afrate
			elseIf fd_attendance = 0.5 Then
				 ld_rate = ld_ahrate
			else
				 ld_rate = ld_afrate * fd_attendance
			 End If
		End If
end if

return ld_rate
end function

event open;dw_1.settransobject(sqlca)

dw_1.GetChild ("emp_cd", idw_emp)
idw_emp.settransobject(sqlca)

// Changes MAde in Report Oblatf27c as per Mr. Y.K.Gupta dated 23/09/2011


end event

on w_gtelaf069.create
this.em_1=create em_1
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelaf069.destroy
destroy(this.em_1)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event close;//execute immediate "drop view emp_list_vw" using sqlca;
end event

type em_1 from editmask within w_gtelaf069
integer x = 293
integer y = 16
integer width = 338
integer height = 88
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type cb_8 from commandbutton within w_gtelaf069
integer x = 1984
integer y = 12
integer width = 265
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Summary"
end type

event clicked;opensheet(w_Gtelaf069c,w_mdi,1,layered!) 
end event

type cb_7 from commandbutton within w_gtelaf069
integer x = 1714
integer y = 12
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "DaysWise"
end type

event clicked;opensheet(w_Gtelaf069b,w_mdi,1,layered!)
end event

type cb_6 from commandbutton within w_gtelaf069
integer x = 1445
integer y = 12
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Report"
end type

event clicked;opensheet(w_Gtelaf069a,w_mdi,1,layered!)

end event

type cb_4 from commandbutton within w_gtelaf069
integer x = 635
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
string text = "&Query"
end type

event clicked;if cb_4.text = "&Query" then
	if isnull(em_1.text) or em_1.text = '00/00/0000' or em_1.text = 'none' then
		messagebox('Warning!','Please Select A Reading Date !!!')
		return 1
	end if
	
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
 	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")	 
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.settaborder('od_date',0)
	cb_4.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_query = false
	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.settaborder('od_date',10)
	dw_1.Retrieve(em_1.text)
	dw_1.SetRedraw (TRUE)
	cb_4.text = "&Query"
	cb_1.enabled = true
end if
lb_neworder = false

end event

type cb_3 from commandbutton within w_gtelaf069
integer x = 905
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save"
end type

event clicked;dw_1.accepttext()
if dw_1.accepttext() = -1 then
	return 
end if	

if dw_1.rowcount() > 0 then
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF

	IF (lb_neworder = TRUE or lb_query = false) and &
		(isnull(dw_1.getitemstring(dw_1.getrow(),'od_emp_cd')) or (len(dw_1.getitemstring(dw_1.getrow(),'od_emp_cd'))=0)) THEN
		dw_1.deleterow(dw_1.rowcount())
	END IF
end if

//for ll_cnt = dw_1.rowcount() to 1 step -1
//	ls_slip_ty = dw_1.getitemstring(ll_cnt,'od_slip_type')
//	ls_emp_cd = dw_1.getitemstring(ll_cnt,'emp_cd')
//	ld_date = dw_1.getitemdatetime(ll_cnt,'od_date')
//	ls_time_fr = dw_1.getitemstring(ll_cnt,'od_time_from')
//	ls_time_to  = dw_1.getitemstring(ll_cnt,'od_time_to')
//	
//	if ls_slip_ty = 'E' then
//		
//		SELECT EM_PROXY_NO into :ll_proxy
//  		FROM (select em_emp_cd,em_emp_name,EM_DEPT_ID,EM_PROXY_NO from obt.fa_emp,attn_empl
//            where em_emp_cd = atn_emp_cd and em_co_cd in  ('1','7') and nvl(em_left_tag,'N') = 'N' and em_emp_cd = :ll_emp_cd);
//				
//		if sqlca.sqlcode = -1 then
//			messagebox('Error During Getting Proxy No',sqlca.sqlerrtext)
//			return 1
//		end if
//		
//		
//		select distinct 'x' into :ls_temp from attn_daily_det where DD_PER_NO = :ll_emp_cd and DD_DATE = trunc(:ld_date) and DD_TIME = :ls_time_fr and DD_RATN_IND='E';
//		if sqlca.sqlcode = -1 then
//			messagebox('Error During Checking Detail',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Duplicate !!!','Entry Already Exists For This Employee, Date and Time, Please Check !!!')
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			insert into attn_daily_det (DD_PER_NO, DD_DATE, DD_TIME, DD_PROXY_NO,DD_RATN_IND) values (:ll_emp_cd,trunc(:ld_date),:ls_time_fr,:ll_proxy,'E');
//			if sqlca.sqlcode = -1 then
//				messagebox('Error During Inserting Detail',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			end if		
//		end if
//		
//		select distinct 'x' into :ls_temp from attn_daily_det where DD_PER_NO = :ll_emp_cd and DD_DATE = trunc(:ld_date) and DD_TIME = :ls_time_to and DD_RATN_IND='E';
//		if sqlca.sqlcode = -1 then
//			messagebox('Error During Checking Detail',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Duplicate !!!','Entry Already Exists For This Employee, Date and Time, Please Check !!!')
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//
//			insert into attn_daily_det (DD_PER_NO, DD_DATE, DD_TIME, DD_PROXY_NO,DD_RATN_IND) values (:ll_emp_cd,trunc(:ld_date),:ls_time_to,:ll_proxy,'E');
//			if sqlca.sqlcode = -1 then
//				messagebox('Error During Inserting Detail',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			end if		
//		end if
//		
//	end if
//
//next

//delete from attn_ot_det where nvl(od_emp_cd,0) = '0';
//if sqlca.sqlcode = -1 then
//	messagebox('Error During Deletion',sqlca.sqlerrtext)
//	rollback using sqlca;
//	return 1
//end if

if dw_1.update(true,false) = 1 then
	dw_1.resetupdate()
	commit using sqlca;
	dw_1.reset()
else
	messagebox('SQL Error 123',sqlca.sqlerrtext)
	rollback using sqlca;			
	return 1
end if
cb_3.enabled = false
end event

type cb_2 from commandbutton within w_gtelaf069
integer x = 1175
integer y = 12
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

on clicked;Close(parent)
end on

type cb_1 from commandbutton within w_gtelaf069
integer x = 14
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
string text = "&Insert"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
end if

dw_1.settransobject(sqlca)

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'od_date',today())
	dw_1.setcolumn('od_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setcolumn('od_date')
end if

lb_neworder = true

end event

type dw_1 from datawindow within w_gtelaf069
event ue_tab_to_enter pbm_dwnprocessenter
event key_down pbm_dwnrowchanging
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 9
integer y = 116
integer width = 3776
integer height = 1696
integer taborder = 10
string dataobject = "dw_Gtelaf069"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'od_date',dw_1.GetItemdatetime(currentrow,'od_date'))
		dw_1.setitem(newrow,'od_slip_type',dw_1.GetItemstring(currentrow,'od_slip_type'))
		dw_1.setitem(newrow,'od_time_from',dw_1.GetItemstring(currentrow,'od_time_from'))
		dw_1.setitem(newrow,'od_time_to',dw_1.GetItemstring(currentrow,'od_time_to'))
		dw_1.setitem(newrow,'od_type',dw_1.GetItemstring(currentrow,'od_type'))
		dw_1.setitem(newrow,'od_no_hours',dw_1.GetItemnumber(currentrow,'od_no_hours'))
	end if
 end if
end if
end event

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event itemchanged;if lb_neworder = true or lb_query = false then
	
	if dwo.name = 'od_date' then
		ls_od_dt = string(datetime(data),'dd/mm/yyyy')
		
		if date(datetime(data)) > date(today()) then 
			messagebox('Error During Date','OT Date Should Be <= Current Date');
			return 1
		end if;
		
	SELECT distinct 'X' into :ls_temp FROM dual WHERE TRUNC(ADD_MONTHS(SYSDATE, -1), 'MM')  <= to_date(:ls_od_dt,'dd/mm/yyyy') ;
	if sqlca.sqlcode = -1 then
			messagebox('Error while geting date..!!',sqlca.sqlerrtext)
			return 1
	elseif sqlca.sqlcode = 100 then
			messagebox("Warning..!!","Only this month and previous mont entry is Allow")	
			return 1			
		end if
			
	else
		ls_od_dt = string(dw_1.getitemdatetime(row,'od_date'),'dd/mm/yyyy')
	end if	
//	if dwo.name = 'od_slip_type' then
//		if data = 'E' then
//			idw_emp.SetFilter ("trim(EM_DEPT_ID) in ('52','53','13')") 
//			idw_emp.filter( )			
//		elseif data = 'T' then
//			idw_emp.SetFilter ("trim(EM_DEPT_ID) not in ('52','53','13')") 
//			idw_emp.filter( )	
//		else
//			idw_emp.SetFilter ("") 
//			idw_emp.filter( )				
//		end if
//	end if
	
	if dw_1.getcolumnname() = 'od_emp_cd' or dw_1.getcolumnname() = 'od_emp_cd_1' then
		ls_emp_cd = dw_1.gettext()		
		ls_od_dt = string(dw_1.getitemdatetime(row,'od_date'),'dd/mm/yyyy')
		
		//select nvl(cd_day_type,'X') into :ls_day_type from attn_emp_detail where cd_emp_cd = :ll_emp_cd and cd_date = to_date(:ls_od_dt,'dd/mm/yyyy');
		
		
		select emp_name into:ls_temp   from fb_employee where EMP_ID=:ls_emp_cd and nvl(EMP_ACTIVE,'O')='1';
		if sqlca.sqlcode = -1 then
			messagebox('Error During Getting Name',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox("EMPLOYEE CODE IS INVALID","Employee is In active")	
			return 1			
		end if
  
//		if ls_slip_ty = 'E' then
//			SELECT em_emp_name INTO :ls_temp 
//			 FROM (select em_emp_cd,em_emp_name,EM_DEPT_ID  from obt.fa_emp,attn_empl 
//						where em_emp_cd = atn_emp_cd and em_co_cd in (select distinct CM_CO_CD from obt.fa_company) and nvl(em_left_tag,'N') = 'N' 
//						union 
//					  select tf_per_no,tf_emp_name,tf_locn_cd from tm_emp_fixed,attn_empl 
//					where tf_per_no = atn_emp_cd and nvl(tf_left_tag,'N') = 'N' and tf_per_no < 80000 )
//			WHERE EM_EMP_CD  = :ll_EMP_CD and (EM_DEPT_ID not in ('52','53','13') and EM_DEPT_ID not in (SELECT distinct em_dept_id from fa_emp where EM_CO_CD IN ('9')));
//			
//			if sqlca.sqlcode = -1 then
//				messagebox('Error During Getting Name',sqlca.sqlerrtext)
//				return 1
//			elseif sqlca.sqlcode = 0 and ls_day_type <> 'HLDY' then
//				messagebox("EMPLOYEE CODE IS INVALID","Only for Boiler, ETP, Maintenance; others Department allowed on holidays.")	
//				return 1			
//			end if
//		elseif ls_slip_ty = 'T' then
//			SELECT em_emp_name INTO :ls_temp 
//			 FROM (select em_emp_cd,em_emp_name,EM_DEPT_ID  from obt.fa_emp,attn_empl 
//						where em_emp_cd = atn_emp_cd and em_co_cd in (select distinct CM_CO_CD from obt.fa_company) and nvl(em_left_tag,'N') = 'N' 
//						union 
//					  select tf_per_no,tf_emp_name,tf_locn_cd from tm_emp_fixed,attn_empl 
//					where tf_per_no = atn_emp_cd and nvl(tf_left_tag,'N') = 'N' and tf_per_no < 80000 )
//			WHERE EM_EMP_CD  = :ll_EMP_CD and  (EM_DEPT_ID in ('52','53','13') and EM_DEPT_ID not in (SELECT distinct em_dept_id from fa_emp where EM_CO_CD IN ('9')));
//			
//			if sqlca.sqlcode = -1 then
//				messagebox('Error During Getting Name',sqlca.sqlerrtext)
//				return 1
//			elseif sqlca.sqlcode = 0 then
//				messagebox("EMPLOYEE CODE IS INVALID","Employee Should Not Be From Boiler/ETP/Maintenance Division, Pls Check")	
//				return 1			
//			end if
//		end if
		
//			SELECT em_emp_name INTO :ls_temp 
//			 FROM (select em_emp_cd,em_emp_name,EM_DEPT_ID  from obt.fa_emp,attn_empl 
//						where em_emp_cd = atn_emp_cd and em_co_cd in (select distinct CM_CO_CD from obt.fa_company) and nvl(em_left_tag,'N') = 'N' 
//						union 
//					  select tf_per_no,tf_emp_name,tf_locn_cd from tm_emp_fixed,attn_empl 
//					where tf_per_no = atn_emp_cd and nvl(tf_left_tag,'N') = 'N' and tf_per_no < 80000 )
//			WHERE EM_EMP_CD  = :ll_EMP_CD;
//			
//			if sqlca.sqlcode = -1 then
//				messagebox('Error During Getting Name',sqlca.sqlerrtext)
//				return 1
//			elseif sqlca.sqlcode = 100 then
//				messagebox("EMPLOYEE CODE IS INVALID","Invalid Employee, Pls Check")	
//				return 1			
//			end if
//
			
		if dw_1.getrow() = dw_1.rowcount() and lb_neworder = true then
			dw_1.insertrow(0)
		end if
	else
		ls_emp_cd = dw_1.getitemstring(dw_1.getrow(),'od_emp_cd')
	end if		
	
  	if dw_1.getcolumnname() = 'od_time_to' then
   		ls_from = dw_1.getitemstring(dw_1.getrow(),'od_time_from')
		ls_to   = dw_1.gettext()
		ls_od_dt = string(dw_1.getitemdatetime(row,'od_date'),'dd/mm/yyyy')
		ls_emp_cd = dw_1.getitemstring(dw_1.getrow(),'od_emp_cd')
		
//		if wf_dup_frdt(ls_od_dt,ls_emp_cd,ls_from,ls_to,row) = -1 then
//			return 1
//		end if
//		select distinct 'x' into :ls_temp from ATTN_OT_DET
// 		where od_emp_cd = :ll_emp_cd and to_char(od_date,'dd/mm/yyyy') = :ls_od_dt and
//       			 OD_TIME_FROM = :ls_from and OD_TIME_TO = :ls_to;
//		
////		messagebox('Data',string(ll_emp_cd)+' '+ls_od_dt+' '+ls_from+' '+ls_to)
//		if sqlca.sqlcode = -1 then
//			messagebox('Sql Error At From Dt',sqlca.sqlerrtext)
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			messagebox('Error At From Date','OD Date For Employee '+string(ll_emp_cd) +' For Time '+ls_from+' And '+ls_to+' Already Entered....Pls Check')
//			return 1
//		end if	

	 	if ls_from > ls_to then	
	   	ll_tot = ((((long(LeftA(ls_to,2))+24) * 60) + long(RightA(ls_to,2))) - &
				 	   ((long(LeftA(ls_from,2))*60) + long(RightA(ls_from,2))))
		else
	    	ll_tot = (((long(LeftA(ls_to,2))*60) + long(RightA(ls_to,2))) - &
					   ((long(LeftA(ls_from,2))*60) + long(RightA(ls_from,2))))
	 	end if
	 
	 	ld_tot_time = (int(ll_tot/60)*100 + mod(ll_tot,60))/100
	 	dw_1.setitem(dw_1.getrow(),'od_no_hours',ld_tot_time)
  	end if
	  
	  if dwo.name='od_eacsubhead_id' then
	 		ls_kam_id = data
			ls_emp_cd = dw_1.getitemstring(row,'od_emp_cd')
			 ld_status=1
			 ld_date=dw_1.getitemdatetime(row,'od_date')
						 
			ld_wages = wf_kamjari_rate(ld_date,ls_emp_cd,ls_kam_id,ld_status,row)
			
			
			ld_wages=ld_wages/8;
			
			dw_1.setitem(row,'od_rate',ld_wages)
			
			 
	 end if
cb_3.enabled = true

dw_1.setitem(dw_1.getrow(),'od_entry_by',gs_user)
dw_1.setitem(dw_1.getrow(),'od_entry_date',today())

end if



end event

event rbuttondown;if messagebox("Confirmation Message","Do You Want To Delete The Current Record ...!",information!,yesno!,1) = 1 then
	
	ls_slip_ty = dw_1.getitemstring(row,'od_slip_type')
	ls_emp_cd = dw_1.getitemstring(row,'emp_cd')
	ld_date = dw_1.getitemdatetime(row,'od_date')
	ls_time_fr = dw_1.getitemstring(row,'od_time_from')
	ls_time_to  = dw_1.getitemstring(row,'od_time_to')

//	if ls_slip_ty = 'E' then
//		select distinct 'x' into :ls_temp from attn_daily_det where DD_PER_NO = :ll_emp_cd and trunc(DD_DATE) = trunc(:ld_date) and DD_TIME = :ls_time_fr and DD_RATN_IND='E';
//		if sqlca.sqlcode = -1 then
//			messagebox('Error During Checking Detail',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			delete from attn_daily_det where DD_PER_NO = :ll_emp_cd and trunc(DD_DATE) = trunc(:ld_date) and DD_TIME = :ls_time_fr and DD_RATN_IND='E';
//			commit using sqlca;
//		end if
//		
//		select distinct 'x' into :ls_temp from attn_daily_det where DD_PER_NO = :ll_emp_cd and trunc(DD_DATE) = trunc(:ld_date) and DD_TIME = :ls_time_to and DD_RATN_IND='E';
//		if sqlca.sqlcode = -1 then
//			messagebox('Error During Checking Detail',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then
//			delete from attn_daily_det where DD_PER_NO = :ll_emp_cd and trunc(DD_DATE) = trunc(:ld_date) and DD_TIME = :ls_time_to and DD_RATN_IND='E';
//			commit using sqlca;
//		end if
//	end if
	
  dw_1.deleterow(row)
  
  dw_1.update()
	if sqlca.sqlcode = 0 then
	  commit using sqlca;
	else
	  rollback using sqlca;
	end if
end if
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

