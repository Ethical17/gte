$PBExportHeader$w_gtepur001.srw
forward
global type w_gtepur001 from window
end type
type cb_1 from commandbutton within w_gtepur001
end type
type cbx_1 from checkbox within w_gtepur001
end type
type ddlb_1 from dropdownlistbox within w_gtepur001
end type
type st_3 from statictext within w_gtepur001
end type
type rb_2 from radiobutton within w_gtepur001
end type
type rb_1 from radiobutton within w_gtepur001
end type
type cb_2 from commandbutton within w_gtepur001
end type
type cb_4 from commandbutton within w_gtepur001
end type
type dw_1 from datawindow within w_gtepur001
end type
end forward

global type w_gtepur001 from window
integer width = 4663
integer height = 2364
boolean titlebar = true
string title = "(w_gtepur001) Purchase"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_1 cb_1
cbx_1 cbx_1
ddlb_1 ddlb_1
st_3 st_3
rb_2 rb_2
rb_1 rb_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gtepur001 w_gtepur001

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id,ls_indentflag,ls_frdt,ls_dt,ls_sigflg
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

on w_gtepur001.create
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cbx_1,&
this.ddlb_1,&
this.st_3,&
this.rb_2,&
this.rb_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gtepur001.destroy
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nm+"'")
lb_query = false	
lb_neworder = false

dw_1.settransobject( sqlca);

setpointer(hourglass!)
dw_1.GetChild ("eacsubhead_id", idw_subexp)
idw_subexp.settransobject(sqlca)	

setpointer(hourglass!)
ddlb_1.reset()

ddlb_1.additem('ALL')
declare c1 cursor for
select INDENT_ID||'-('||INDENT_DATE||')' 
  from fb_indent where INDENT_HOLOCALFLAG= '1'
  order by INDENT_DATE desc;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_temp)
		fetch c1 into :ls_temp;
	loop
	close c1;
end if
ddlb_1.text='ALL'

setpointer(arrow!)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type cb_1 from commandbutton within w_gtepur001
integer x = 3982
integer y = 20
integer width = 544
integer height = 104
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "XLS FOR PROCOL"
end type

event clicked;if len(ddlb_1.text) > 15 then
	ls_temp = left(ddlb_1.text,len(ddlb_1.text) - 12)
else
	ls_temp = trim(ddlb_1.text) 
end if

if ls_temp = 'ALL' then
	messagebox('Warning','Please Select Required Indent No.')
	return 1
end if

dw_1.dataobject='dw_gtepur001b'
dw_1.settransobject(sqlca)
dw_1.retrieve('A','0',ls_temp)

if dw_1.rowcount() = 0 then
	messagebox('Warning','No Record Found For The Given Criteria')
	return 1
end if

parent.dw_1.saveas("c:\reports\"+string(right(left(ls_temp,12),6))+".xls",Excel5!,true)
if rb_1.checked then
	dw_1.dataobject='dw_gtepur001h'	
elseif rb_2.checked then
	dw_1.dataobject='dw_gtepur001'
end if;	
dw_1.settransobject( sqlca);
end event

type cbx_1 from checkbox within w_gtepur001
integer x = 2309
integer y = 20
integer width = 471
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "With Signature"
end type

type ddlb_1 from dropdownlistbox within w_gtepur001
integer x = 1294
integer y = 24
integer width = 946
integer height = 856
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gtepur001
integer x = 855
integer y = 44
integer width = 421
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Indent No.: "
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_gtepur001
integer x = 439
integer y = 36
integer width = 425
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Local Indent"
end type

event clicked;setpointer(hourglass!)
ddlb_1.reset()

ddlb_1.additem('ALL')
declare c1 cursor for
select INDENT_ID||'-('||INDENT_DATE||')' 
  from fb_indent where INDENT_HOLOCALFLAG= '0'
  order by INDENT_DATE desc;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_temp)
		fetch c1 into :ls_temp;
	loop
	close c1;
end if
ddlb_1.text='ALL'

setpointer(arrow!)
end event

type rb_1 from radiobutton within w_gtepur001
integer x = 55
integer y = 36
integer width = 425
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "H.O. Indent"
boolean checked = true
end type

event clicked;setpointer(hourglass!)
ddlb_1.reset()

ddlb_1.additem('ALL')
declare c1 cursor for
select INDENT_ID||'-('||INDENT_DATE||')' 
  from fb_indent where INDENT_HOLOCALFLAG= '1'
  order by INDENT_DATE desc;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_temp)
		fetch c1 into :ls_temp;
	loop
	close c1;
end if
ddlb_1.text='ALL'

setpointer(arrow!)
end event

type cb_2 from commandbutton within w_gtepur001
integer x = 2848
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
string text = "&OK"
end type

event clicked;ls_temp = left(ddlb_1.text,len(ddlb_1.text) - 12)
dw_1.settransobject(sqlca)

ls_frdt = string(today(),'dd/mm/yyyy')

select to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy') 
into :ls_dt
from dual;

if cbx_1.checked then
	ls_sigflg = 'Y'
else
	ls_sigflg = 'N'
end if

if rb_1.checked then
	dw_1.show()
	dw_1.dataobject='dw_gtepur001h'	
	dw_1.settransobject( sqlca);
	dw_1.modify("t_gnm.text = '"+gs_garden_nm+"'")
	dw_1.retrieve('A','1',ls_temp,ls_dt,ls_sigflg)
elseif rb_2.checked then
	dw_1.show()
	dw_1.dataobject='dw_gtepur001'
	dw_1.settransobject( sqlca);
	dw_1.modify("t_gnm.text = '"+gs_garden_nm+"'")
	dw_1.retrieve('A','0',ls_temp)
end if;	
	

	

end event

type cb_4 from commandbutton within w_gtepur001
integer x = 3118
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

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtepur001
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 128
integer width = 4507
integer height = 2104
integer taborder = 60
string dataobject = "dw_gtepur001"
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

