$PBExportHeader$w_project_status.srw
forward
global type w_project_status from window
end type
type cbx_3 from checkbox within w_project_status
end type
type cbx_2 from checkbox within w_project_status
end type
type cbx_1 from checkbox within w_project_status
end type
type cb_5 from commandbutton within w_project_status
end type
type cb_3 from commandbutton within w_project_status
end type
type cb_2 from commandbutton within w_project_status
end type
type dw_1 from datawindow within w_project_status
end type
type gb_1 from groupbox within w_project_status
end type
end forward

global type w_project_status from window
integer width = 4974
integer height = 2388
windowtype windowtype = child!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
cb_5 cb_5
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_project_status w_project_status

type variables
boolean lb_query
datetime ld_dt
	string ls_c1,ls_i1, ls_t1	

end variables

event ue_option();choose case gs_ueoption
	case "PRINT"
		    dw_1.settransobject( sqlca)
			if cbx_1.checked then ; ls_c1 = 'Y'; else ; ls_c1='N' ;end if;
			if cbx_2.checked then ; ls_i1 = 'Y'; else ; ls_i1='N' ;end if;
			if cbx_3.checked then ; ls_t1 = 'Y'; else ; ls_t1='N' ;end if;
			dw_1.retrieve('N',ls_c1,ls_i1, ls_t1	)			 
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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
			this.dw_1.setredraw(true)
end choose

end event

on w_project_status.create
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.cb_5=create cb_5
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cbx_3,&
this.cbx_2,&
this.cbx_1,&
this.cb_5,&
this.cb_3,&
this.cb_2,&
this.dw_1,&
this.gb_1}
end on

on w_project_status.destroy
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.settransobject(sqlca)
cb_2.enabled = false	

end event

type cbx_3 from checkbox within w_project_status
integer x = 850
integer y = 76
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Be Done"
boolean checked = true
end type

type cbx_2 from checkbox within w_project_status
integer x = 466
integer y = 76
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inprocess"
boolean checked = true
end type

type cbx_1 from checkbox within w_project_status
integer x = 55
integer y = 76
integer width = 343
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Completed"
boolean checked = true
end type

type cb_5 from commandbutton within w_project_status
integer x = 1253
integer y = 48
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

event clicked;if cb_5.text = "&Query" then
	if dw_1.modifiedcount() > 0 then
	   if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
	      return 1
		end if
	end if
	dw_1.reset()
	lb_query = true
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus()
	cb_5.text = "&Run"
else
	lb_query = false
     dw_1.settransobject(sqlca)
	
	   
	if cbx_1.checked then ; ls_c1 = 'Y'; else ; ls_c1='N' ;end if;
	if cbx_2.checked then ; ls_i1 = 'Y'; else ; ls_i1='N' ;end if;
	if cbx_3.checked then ; ls_t1 = 'Y'; else ; ls_t1='N' ;end if;
	 
	dw_1.Retrieve('Y',ls_c1,ls_i1, ls_t1	)
	dw_1.Object.datawindow.querymode = 'no'
	cb_5.text = "&Query"
end if

end event

type cb_3 from commandbutton within w_project_status
integer x = 1783
integer y = 48
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_project_status
integer x = 1518
integer y = 48
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then return;

if dw_1.update(true,false) = 1 then
	dw_1.resetupdate()
	commit using sqlca;
ELSE 
	ROLLBACK USING SQLCA;
	return
END IF

dw_1.reset()
dw_1.settransobject(sqlca)

cb_2.enabled = false
//cb_5.enabled = false

end event

type dw_1 from datawindow within w_project_status
event ue_tab_to_enter pbm_dwnprocessenter
event key-down2 pbm_dwnrowchanging
integer y = 176
integer width = 4955
integer height = 2200
integer taborder = 40
string dataobject = "dw_project_status"
boolean vscrollbar = true
boolean livescroll = true
end type

event type long ue_tab_to_enter();Send(Handle(this),256,9,Long(0,0))
return 1
end event

event itemchanged;if lb_query = false then
	cb_2.enabled = true
	if dwo.name='verify_ind' then
		if data ='Y' then
			ld_dt = datetime(today())
			dw_1.setitem(row,'ld_ltc_verify_dt',datetime(today()))
		else
			setnull(ld_dt)
			dw_1.setitem(row,'ld_ltc_verify_dt',ld_dt)
		end if
	end if
	if dwo.name='docu_ind' then
		if data ='Y' then
			ld_dt = datetime(today())
			dw_1.setitem(row,'ld_document',datetime(today()))
		else
			setnull(ld_dt)
			dw_1.setitem(row,'ld_document',ld_dt)
		end if
	end if
	if dwo.name='test_ind' then
		if data ='Y' then
			ld_dt = datetime(today())
			dw_1.setitem(row,'ld_obl_testing',datetime(today()))
		else
			setnull(ld_dt)
			dw_1.setitem(row,'ld_obl_testing',ld_dt)
		end if
	end if
end if	
end event

type gb_1 from groupbox within w_project_status
integer x = 27
integer y = 16
integer width = 1207
integer height = 148
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Devlopment Status"
borderstyle borderstyle = stylebox!
end type

