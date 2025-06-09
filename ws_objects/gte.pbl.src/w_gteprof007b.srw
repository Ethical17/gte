$PBExportHeader$w_gteprof007b.srw
forward
global type w_gteprof007b from window
end type
type cbx_1 from checkbox within w_gteprof007b
end type
type cb_4 from commandbutton within w_gteprof007b
end type
type cb_6 from commandbutton within w_gteprof007b
end type
type em_1 from editmask within w_gteprof007b
end type
type st_1 from statictext within w_gteprof007b
end type
type cb_2 from commandbutton within w_gteprof007b
end type
type dw_1 from datawindow within w_gteprof007b
end type
end forward

global type w_gteprof007b from window
integer width = 4617
integer height = 2396
boolean titlebar = true
string title = "(w_gteprof007b) Green Leaf Transaction for A/C"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_option ( )
cbx_1 cbx_1
cb_4 cb_4
cb_6 cb_6
em_1 em_1
st_1 st_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gteprof007b w_gteprof007b

type variables
long ll_ctr
string ls_temp,ls_ac_dt,ls_gt_id
boolean lb_neworder, lb_query
double ld_netamount

end variables

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

on w_gteprof007b.create
this.cbx_1=create cbx_1
this.cb_4=create cb_4
this.cb_6=create cb_6
this.em_1=create em_1
this.st_1=create st_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cbx_1,&
this.cb_4,&
this.cb_6,&
this.em_1,&
this.st_1,&
this.cb_2,&
this.dw_1}
end on

on w_gteprof007b.destroy
destroy(this.cbx_1)
destroy(this.cb_4)
destroy(this.cb_6)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
dw_1.Retrieve(gs_user,'Y')


end event

event key;IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if

end event

type cbx_1 from checkbox within w_gteprof007b
integer x = 3278
integer y = 24
integer width = 357
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select ALL"
end type

event clicked;for ll_ctr = 1 to dw_1.rowcount()
	if cbx_1.checked then
		dw_1.setitem(ll_ctr,'appr_flag','Y')
		//cb_6.enabled = true
	else
		dw_1.setitem(ll_ctr,'appr_flag','N')
		//cb_6.enabled = false
	end if;	
next;
end event

type cb_4 from commandbutton within w_gteprof007b
integer x = 1518
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

type cb_6 from commandbutton within w_gteprof007b
integer x = 1161
integer y = 4
integer width = 343
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked; n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

	for ll_ctr = 1 to dw_1.rowcount() 
		if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'gt_vou_no'))=true then
			
//			if luo_fames.wf_purchase_to_account(dw_1.getitemstring(ll_ctr,'gt_id'),ls_ac_dt) = -1 then 
//				rollback using sqlca;
//				return 1;
//			end if;
			setnull(ls_gt_id)
			ls_gt_id=dw_1.getitemstring(ll_ctr,'gt_id')
			declare p2 procedure for up_gl_pur_to_acct (:ls_gt_id,:ls_ac_dt,:gs_CO_ID,:gs_garden_snm,:GS_USER);
			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Declare of up_gl_pur_to_acct',sqlca.sqlerrtext)
				 return 1
			end if
			
			execute p2;
			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Execute of up_gl_pur_to_acct',sqlca.sqlerrtext)
				 return 1
			end if			

			
	
			//Update DailyExpense
			if dw_1.getitemstring(ll_ctr,'gt_type')='PURCHASE' then
				string ls_exsub_head
				setnull(ls_exsub_head)
				select distinct DR_EACSUBHEAD_ID into :ls_exsub_head from fb_acautoprocess 
				where AC_PROCESS='Green Leaf Purchase' and AC_PROCESS_DETAIL = 'Purchase  Leaf';
				
				if sqlca.sqlcode = -1  then
					messagebox('SQL Error: During Getting The Expense Sub Head A/c',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				if len(ls_exsub_head) > 0  then
							
//					if luo_fames.wf_upd_mes(ls_ac_dt,ls_exsub_head,dw_1.getitemnumber(ll_ctr,'gt_netamount'),'C','N')  = -1 then 
//						rollback using sqlca;
//						return 1;
//					end if;
			ld_netamount=0;
			ld_netamount=dw_1.getitemnumber(ll_ctr,'gt_netamount')
			declare p3 procedure for up_upd_mes (:ls_ac_dt,:ls_exsub_head,:ld_netamount,'C','N');
			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Declare of up_upd_mes',sqlca.sqlerrtext)
				 return 1
			end if
			
			execute p3;
			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Execute of up_upd_mes',sqlca.sqlerrtext)
				 return 1
			end if			

				else
					messagebox('Warning','Expense Sub Head A/c Not In A/c Auto Process Master, Please Check')
					rollback using sqlca;
					return 1
				end if
				
			end if
		end if
	next	
	
dw_1.update( )
commit using sqlca;

DESTROY n_fames
dw_1.reset()
messagebox('Information;',' JV Created Successfully')
cb_6.enabled = false
end event

type em_1 from editmask within w_gteprof007b
integer x = 736
integer y = 16
integer width = 411
integer height = 84
integer taborder = 50
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
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

event modified;if isdate(em_1.text) = false then 
	messagebox('Error At Process date','Please Enter Account Process date...!')
	cb_6.enabled = false	
	return 1
else
	ls_temp=em_1.text
	cb_6.enabled = true
end if;	
end event

type st_1 from statictext within w_gteprof007b
integer x = 297
integer y = 28
integer width = 453
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " A/C Process Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteprof007b
integer x = 9
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;	lb_neworder =false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,'Y')
	dw_1.settaborder('gt_id',0)
	dw_1.settaborder('gt_date',0)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
//	cb_1.enabled = true

end event

type dw_1 from datawindow within w_gteprof007b
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 14
integer y = 112
integer width = 4590
integer height = 2200
integer taborder = 20
string dataobject = "dw_gteprof007a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

