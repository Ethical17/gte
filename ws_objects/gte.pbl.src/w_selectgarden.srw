$PBExportHeader$w_selectgarden.srw
forward
global type w_selectgarden from window
end type
type st_1 from statictext within w_selectgarden
end type
type cb_1 from commandbutton within w_selectgarden
end type
type dw_1 from datawindow within w_selectgarden
end type
end forward

global type w_selectgarden from window
integer width = 2272
integer height = 2088
boolean titlebar = true
string title = "Select Garden"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_option ( )
st_1 st_1
cb_1 cb_1
dw_1 dw_1
end type
global w_selectgarden w_selectgarden

type variables
string ls_gl
end variables

event ue_option();choose case gs_ueoption
	case "PRINT"
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
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose


end event

on w_selectgarden.create
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_1,&
this.dw_1}
end on

on w_selectgarden.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject( sqlca);
dw_1.retrieve()
end event

type st_1 from statictext within w_selectgarden
integer y = 1912
integer width = 1216
integer height = 80
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 134217857
long backcolor = 67108864
string text = "Please Double to Select A Garden"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_selectgarden
integer x = 1275
integer y = 1900
integer width = 288
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Close"
end type

event clicked;Close(parent)
end event

type dw_1 from datawindow within w_selectgarden
integer width = 2258
integer height = 1888
string dataobject = "dw_selectgarden"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if row > 0 then

	string ls_snm
	
	select sysdate into :gd_dt from dual; 

//	messagebox('DBdate','DBdate : '+string(gd_dt)+'  Sysdate : '+string(Today()) ) 
	
	if date(gd_dt) <> today() then
		messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
		return 1
	end if
	
	ls_snm = lower(dw_1.getitemstring(row,'unit_shortname'))

	disconnect using sqlca;
	SQLCA.DBMS = "ORA Oracle"
	//SQLCA.DBMS = "O90 Oracle9i (9.0.1)"
	//SQLCA.DBMS = "O10 Oracle10g (10.1.0)"
	SQLCA.LogPass = ls_snm+"ote"
	SQLCA.ServerName = "ltcdb"
//	SQLCA.ServerName = "ltcdbho"
	SQLCA.LogId = ls_snm+"ote"
	SQLCA.AutoCommit = False
	SQLCA.DBParm = ""
	connect using sqlca;

	select UNIT_ID,UNIT_NAME,UNIT_SHORTNAME,UNIT_NAME||' '||UNIT_ADD,UNIT_CO_CD, UNIT_COMPNAME,UNIT_SUPID,UNIT_MAIN_STORE,UNIT_STATE
  	  into :gs_unit,:gs_garden_nm,:gs_garden_snm,:gs_garden_nameadd,:gs_CO_ID,:gs_CO_name,:gs_supid,:gs_storeid,:gs_garden_state
	 from fb_gardenmaster
   where UNIT_ACTIVE_IND ='Y' and UNIT_SHORTNAME = upper(:ls_snm);
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL Error: During Getting Garden Details : ',sqlca.sqlerrtext)
		return 1
	elseif sqlca.sqlcode = 100 then 
		messagebox('Warning','Please Enter Then Garden Information First')
		return 1
	end if

//	if not isvalid(w_hologin) then
		  gb_validuserid = true
		  gs_option='HO'
		  open(w_mdi)
//	end if
end if
end event

