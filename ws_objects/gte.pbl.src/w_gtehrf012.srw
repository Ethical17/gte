$PBExportHeader$w_gtehrf012.srw
forward
global type w_gtehrf012 from window
end type
type st_1 from statictext within w_gtehrf012
end type
type em_1 from editmask within w_gtehrf012
end type
type cb_4 from commandbutton within w_gtehrf012
end type
type cb_3 from commandbutton within w_gtehrf012
end type
type cb_2 from commandbutton within w_gtehrf012
end type
type dw_1 from datawindow within w_gtehrf012
end type
end forward

global type w_gtehrf012 from window
integer width = 4978
integer height = 2484
boolean titlebar = true
string title = "(w_gtehrf012) Employee Electric , Advance and Ration Deduction"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
em_1 em_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_gtehrf012 w_gtehrf012

type variables
long ll_ctr,ll_user_level
//ll_cnt,l_ctr,ll_year, ll_month
string ls_temp,ls_empid,ls_ym
boolean lb_neworder, lb_query
double ld_adv,ld_electric, ld_lip,ld_pfded, ld_electadv, ld_medadv,ld_festadv,ld_pfinterestadv
//datetime ld_dt,ld_ded_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_emp_id, long fl_year, long fl_month)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_1)
			SetPointer (Arrow!)						
	case "SAVEAS"
			this.dw_1.saveas()
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if ( isnull(dw_1.getitemstring(fl_row,'emp_id')) or  len(dw_1.getitemstring(fl_row,'emp_id'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'ewd_year')) or dw_1.getitemnumber(fl_row,'ewd_year')=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'ewd_month')) or dw_1.getitemnumber(fl_row,'ewd_month')=0 or &
		 ((isnull(dw_1.getitemnumber(fl_row,'ewd_advanceded')) or dw_1.getitemnumber(fl_row,'ewd_advanceded')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'ewd_electricded')) or dw_1.getitemnumber(fl_row,'ewd_electricded')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'ewd_rationded')) or dw_1.getitemnumber(fl_row,'ewd_rationded')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'ewd_lipded')) or dw_1.getitemnumber(fl_row,'ewd_lipded')=0))) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Employee ID, Year, Month, (Advance / Ration / Electric / Lip) Deduction Amount, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_emp_id, long fl_year, long fl_month);long fl_row,ll_year1,ll_mon1
string ls_emp_id1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_emp_id1 = dw_1.getitemstring(fl_row,'emp_id')
		ll_year1 = dw_1.getitemnumber(fl_row,'ewd_year')
		ll_mon1 = dw_1.getitemnumber(fl_row,'ewd_month')
		
		if ls_emp_id1 = fs_emp_id and ll_year1 = fl_year and ll_mon1 = fl_month then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtehrf012.create
this.st_1=create st_1
this.em_1=create em_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_gtehrf012.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type st_1 from statictext within w_gtehrf012
integer x = 32
integer y = 20
integer width = 315
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year-Month:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtehrf012
integer x = 361
integer y = 12
integer width = 279
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm"
end type

type cb_4 from commandbutton within w_gtehrf012
integer x = 1216
integer y = 8
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

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtehrf012
integer x = 951
integer y = 8
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;
IF MessageBox("Save  Alert", 'If you confirm advance deduction then it will be saved permanently and you can not deduct advance for any labour further for this week ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = 1 to DW_1.ROWCOUNT()
		if dw_1.getitemnumber(ll_ctr,'natpayafterded') < 0 then
			messagebox('Warning!','Advance Cannot Be Deducted More Than Advance Net Pay Available At Record '+string(ll_ctr)+', Please Check !!!')
			return 1
		end if
	next

	for ll_ctr = 1 to DW_1.ROWCOUNT()
		if dw_1.getitemstring(ll_ctr,'exempt_ind') ='Y' then
			ls_empid = dw_1.getitemstring(ll_ctr,'empid')
			ld_adv = dw_1.getitemnumber(ll_ctr,'adv_ded')
			ld_pfded = dw_1.getitemnumber(ll_ctr,'pfadv_ded')
			ld_lip = dw_1.getitemnumber(ll_ctr,'ewd_lipded')
			ls_ym = dw_1.getitemstring(ll_ctr,'ls_ym')
			ld_electadv = dw_1.getitemnumber(ll_ctr,'ewd_electricded')
			ld_medadv = dw_1.getitemnumber(ll_ctr,'ewd_medadvded')
			ld_festadv = dw_1.getitemnumber(ll_ctr,'ewd_festadvded')
			ld_pfinterestadv = dw_1.getitemnumber(ll_ctr,'pfint_ded')
			
			select distinct 'x' into :ls_temp from fb_empwisededuction 
			where EMP_ID = :ls_empid and ((nvl(EWD_YEAR,0) * 100) + nvl(EWD_MONTH,0))  = to_number(to_char(to_date(:ls_ym,'yyyymm'),'yyyymm'));

			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 100 then

				insert into fb_empwisededuction (EMP_ID, EWD_MONTH, EWD_YEAR, EWD_ADVANCEDED, EWD_RATIONDED,EWD_ELECTRICDED,EWD_PFADVDED, EWD_LIPDED, EWD_ENTRY_BY, EWD_ENTRY_DT,EWD_VOU_SAL,EWD_MEDADVDED, EWD_FESTADVDED,EWD_pfinterestded)
				values(:ls_empid,to_number(to_char(to_date(:ls_ym,'yyyymm'),'MM')),to_number(to_char(to_date(:ls_ym,'yyyymm'),'YYYY')),nvl(:ld_adv,0),0,nvl(:ld_electadv,0),nvl(:ld_pfded,0),nvl(:ld_lip,0),:gs_user,trunc(sysdate),'S',nvl(:ld_medadv,0),nvl(:ld_festadv,0),nvl(:ld_pfinterestadv,0));
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Inserting Record',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			elseif sqlca.sqlcode  = 0 then
				update fb_empwisededuction 
					 set EWD_PFADVDED = nvl(:ld_pfded,0), EWD_ADVANCEDED = nvl(:ld_adv,0),EWD_LIPDED = nvl(:ld_lip,0), 
					 	 EWD_ELECTRICDED = nvl(:ld_electadv,0),EWD_MEDADVDED = nvl(:ld_medadv,0), EWD_FESTADVDED = nvl(:ld_festadv,0),
						  EWD_ENTRY_DT = trunc(sysdate), EWD_pfinterestded=nvl(:ld_pfinterestadv,0),EWD_ENTRY_BY = :gs_user
				where EMP_ID = :ls_empid and ((nvl(EWD_YEAR,0) * 100) + nvl(EWD_MONTH,0))  = to_number(to_char(to_date(:ls_ym,'yyyymm'),'yyyymm'));
				
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Updating labadvancededuction table',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
			end if	
			
//			select distinct 'x' into :ls_temp from fb_emppayment 
//			where EMP_ID = :ls_empid and EP_YEAR = to_number(to_char(sysdate,'YYYY')) and EP_MONTH = to_number(to_char(sysdate,'MM'));
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Employee Payment Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode  = 0 then
//				update fb_emppayment set ep_advancededamount= nvl(:ld_adv,0),ep_lipdedamount= nvl(:ld_lip,0)
//				EMP_ID = :ls_empid and EP_YEAR = to_number(to_char(sysdate,'YYYY')) and EP_MONTH = to_number(to_char(sysdate,'MM'));
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Updating emppayment table',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if
//			end if		

//			select distinct 'x' into :ls_temp from fb_empadvance where EMP_ID = :ls_empid;
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode  = 0 then
//				update fb_empadvance set EMP_AMOUNTTOPAYTODATE= EMP_AMOUNTTOPAYTODATE - nvl(:ld_adv,0)
//				where EMP_DI = :ls_empid and emp_date=(select max(emp_date) from fb_empadvance where emp_id = :ls_empid);
//				
//				if sqlca.sqlcode = -1 then
//					messagebox('Error : While Updating empdvance table',sqlca.sqlerrtext)
//					rollback using sqlca;
//					return 1
//				end if
//			end if		
		end if
	next
	
	update fb_emppaymentstatus set eps_advanceconfirm = '1' where eps_month = to_number(to_char(sysdate,'MM')) and eps_year= to_number(to_char(sysdate,'YYYY'));
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Updating emppaymentstatus table',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if

	commit using sqlca;
	cb_3.enabled = false
	dw_1.reset()		
	
else
	return
end if 

end event

type cb_2 from commandbutton within w_gtehrf012
integer x = 686
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(em_1.text) or len(em_1.text) <=0 then
	messagebox('Error','Please Enter Current Year Month as (YYYYMM)')
	return 1
end if

dw_1.retrieve(left(em_1.text,4) + right(em_1.text,2),gs_garden_snm)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if
setpointer(Arrow!)
cb_3.enabled = true
end event

type dw_1 from datawindow within w_gtehrf012
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 4768
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtehrf012"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

