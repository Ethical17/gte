$PBExportHeader$w_gtebgr008.srw
forward
global type w_gtebgr008 from window
end type
type ddlb_2 from dropdownlistbox within w_gtebgr008
end type
type st_2 from statictext within w_gtebgr008
end type
type rb_5 from radiobutton within w_gtebgr008
end type
type rb_4 from radiobutton within w_gtebgr008
end type
type rb_3 from radiobutton within w_gtebgr008
end type
type rb_1 from radiobutton within w_gtebgr008
end type
type rb_2 from radiobutton within w_gtebgr008
end type
type dw_1 from datawindow within w_gtebgr008
end type
type em_1 from editmask within w_gtebgr008
end type
type cb_2 from commandbutton within w_gtebgr008
end type
type st_1 from statictext within w_gtebgr008
end type
type cb_4 from commandbutton within w_gtebgr008
end type
type gb_1 from groupbox within w_gtebgr008
end type
end forward

global type w_gtebgr008 from window
integer width = 4896
integer height = 3072
boolean titlebar = true
string title = "(W_gtebgr008) Budget Amundment "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_2 ddlb_2
st_2 st_2
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_1 rb_1
rb_2 rb_2
dw_1 dw_1
em_1 em_1
cb_2 cb_2
st_1 st_1
cb_4 cb_4
gb_1 gb_1
end type
global w_gtebgr008 w_gtebgr008

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id,ls_gl,ls_name,ls_sgl
string ls_srep
double ld_area
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
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

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gtebgr008.create
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_1=create dw_1
this.em_1=create em_1
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_4=create cb_4
this.gb_1=create gb_1
this.Control[]={this.ddlb_2,&
this.st_2,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_1,&
this.rb_2,&
this.dw_1,&
this.em_1,&
this.cb_2,&
this.st_1,&
this.cb_4,&
this.gb_1}
end on

on w_gtebgr008.destroy
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_1)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.gb_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

lb_query = false	
lb_neworder = false

setpointer(hourglass!)

//dw_1.GetChild ("eacsubhead_id", idw_subexp)
//idw_subexp.settransobject(sqlca)	

ddlb_2.reset()
ddlb_2.additem('ALL')

declare c1 cursor for
select distinct EACSUBHEAD_ID,EACSUBHEAD_NAME||' ['||EACSUBHEAD_ID||']' 
  from FB_EXPENSEACSUBHEAD,fb_acsubledger  
where ACSUBLEDGER_ID=EACHEAD_ID  and nvl(EXP_HEAD_IND,'N')='Y' order by 2;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_gl,:ls_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_name)
		fetch c1 into :ls_gl,:ls_name;
	loop
	close c1;
end if

ddlb_2.text='ALL'
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type ddlb_2 from dropdownlistbox within w_gtebgr008
integer x = 2258
integer y = 40
integer width = 1042
integer height = 1364
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_gtebgr008
integer x = 1970
integer y = 48
integer width = 283
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sub Ledger"
boolean focusrectangle = false
end type

type rb_5 from radiobutton within w_gtebgr008
integer x = 987
integer y = 44
integer width = 334
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tea Made"
end type

event clicked;
ddlb_2.enabled  = False
ddlb_2.reset()


end event

type rb_4 from radiobutton within w_gtebgr008
integer x = 763
integer y = 44
integer width = 229
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cash"
end type

event clicked;ddlb_2.enabled  = False
ddlb_2.reset()


end event

type rb_3 from radiobutton within w_gtebgr008
integer x = 553
integer y = 44
integer width = 224
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Store"
end type

event clicked;
ddlb_2.enabled  = True
ddlb_2.reset()

setpointer(hourglass!)

//dw_1.GetChild ("eacsubhead_id", idw_subexp)
//idw_subexp.settransobject(sqlca)	

ddlb_2.reset()
ddlb_2.additem('ALL')

declare c1 cursor for
select distinct ACSUBLEDGER_ID,ACSUBLEDGER_NAME||' ['||ACSUBLEDGER_ID||']' 
  from fb_acsubledger where nvl(EXP_HEAD_IND,'N')='Y' order by 2;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_gl,:ls_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_name)
		fetch c1 into :ls_gl,:ls_name;
	loop
	close c1;
end if

ddlb_2.text='ALL'
end event

type rb_1 from radiobutton within w_gtebgr008
integer x = 87
integer y = 44
integer width = 206
integer height = 76
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Salary"
boolean checked = true
end type

event clicked;ddlb_2.enabled  = False

end event

type rb_2 from radiobutton within w_gtebgr008
integer x = 320
integer y = 44
integer width = 256
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Wages"
end type

event clicked;ddlb_2.enabled  = True
ddlb_2.reset()

setpointer(hourglass!)


ddlb_2.reset()
ddlb_2.additem('ALL')

declare c1 cursor for
select distinct ACSUBLEDGER_ID,ACSUBLEDGER_NAME||' ['||ACSUBLEDGER_ID||']' from fb_acsubledger where nvl(EXP_HEAD_IND,'N')='Y' order by 2;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_gl,:ls_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_name)
		fetch c1 into :ls_gl,:ls_name;
	loop
	close c1;
end if

ddlb_2.text='ALL'
end event

type dw_1 from datawindow within w_gtebgr008
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 37
integer y = 148
integer width = 4576
integer height = 2180
integer taborder = 60
string dataobject = "dw_gtebgr002a"
boolean vscrollbar = true
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type em_1 from editmask within w_gtebgr008
integer x = 1659
integer y = 44
integer width = 283
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "YYYY"
boolean dropdowncalendar = true
end type

type cb_2 from commandbutton within w_gtebgr008
integer x = 3319
integer y = 32
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;if isnull(em_1.text) or len(em_1.text) = 0 then
	messagebox('Warning!','Please Select A Year !!!')
	return 1
end if

if  long(em_1.text) < long(string(today(),'YYYY'))-1 then
     messagebox('Warning!','Please Select A Valid Budget Year !!!')
elseif  long(em_1.text) > long(string(today(),'YYYY'))+1 then
     messagebox('Warning!','Please Select A Valid Budget Year !!!')	  
end if

ll_year = long(em_1.text)

if isnull(ddlb_2.text) or len(ddlb_2.text) <1 then 
	messagebox('Warning ','Please Select a Valid Sub Ledger Id ....!') 
	return  1
end if
ls_sgl = left(right(ddlb_2.text,9),8)

setpointer(HourGlass!)  

if rb_1.checked then
	dw_1.DataObject = "dw_gtebgr001a"
	dw_1.settransobject(sqlca)
     dw_1.retrieve(gs_user,ll_year);
elseif rb_2.checked then
	dw_1.DataObject = "dw_gtebgr002a"
	dw_1.settransobject(sqlca)
     dw_1.retrieve(gs_user,ll_year,ls_sgl);
elseif rb_3.checked then
	dw_1.DataObject = "dw_gtebgr003a"
	dw_1.settransobject(sqlca)
     dw_1.retrieve(gs_user,ll_year,ls_sgl);
elseif rb_4.checked then
	dw_1.DataObject = "dw_gtebgr004a"
	dw_1.settransobject(sqlca)
     dw_1.retrieve(gs_user,ll_year);
elseif rb_5.checked then
	dw_1.DataObject = "dw_gtebgr005a"
	dw_1.settransobject(sqlca)
     dw_1.retrieve(gs_user,ll_year);
end if



if dw_1.rowcount() = 0 then
	messagebox('Information!','No Data Found  For The Given Criteria !!!')
	return 1
end if

setpointer(Arrow!)
end event

type st_1 from statictext within w_gtebgr008
integer x = 1509
integer y = 48
integer width = 169
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gtebgr008
integer x = 3589
integer y = 32
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

event clicked;	close(parent)

end event

type gb_1 from groupbox within w_gtebgr008
integer x = 69
integer width = 1298
integer height = 140
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

