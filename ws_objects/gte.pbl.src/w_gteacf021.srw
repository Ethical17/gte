$PBExportHeader$w_gteacf021.srw
forward
global type w_gteacf021 from window
end type
type dp_1 from datepicker within w_gteacf021
end type
type st_1 from statictext within w_gteacf021
end type
type cb_2 from commandbutton within w_gteacf021
end type
type cb_1 from commandbutton within w_gteacf021
end type
end forward

global type w_gteacf021 from window
integer width = 1335
integer height = 516
boolean titlebar = true
string title = "(w_gteacf021) HO Remittance Openning Entry"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dp_1 dp_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_gteacf021 w_gteacf021

type variables
long ll_user_level
string ls_gl,ls_frym, ls_toym,ls_ac_dt
n_cst_powerfilter iu_powerfilter
end variables

on w_gteacf021.create
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dp_1,&
this.st_1,&
this.cb_2,&
this.cb_1}
end on

on w_gteacf021.destroy
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;dp_1.value = datetime('31/03/'+string(today(),'yyyy'))

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level = 3 then
	cb_1.visible = false
	cb_1.enabled = false
end if
end event

type dp_1 from datepicker within w_gteacf021
integer x = 626
integer y = 44
integer width = 393
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
boolean enabled = false
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-04-29"), Time("11:19:52.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gteacf021
integer x = 261
integer y = 60
integer width = 366
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "As On Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteacf021
integer x = 654
integer y = 200
integer width = 265
integer height = 100
integer taborder = 40
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

type cb_1 from commandbutton within w_gteacf021
integer x = 379
integer y = 200
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;date  ld_st_year,ld_end_year

if isnull(dp_1.text) or dp_1.text='00/00/0000' then
	messagebox('Warning','Please Enter The "From" Date !!!')
	return 
end if

ls_frym =dp_1.text

select to_date('01/04'||decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))),'dd/mm/yyyy') fy_stdt ,
		to_date('31/03'||(decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-4),-1,decode(sign(to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'mm'))-3),1,0,to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY'))-1),to_number(to_char(to_date(:ls_frym,'dd/mm/yyyy'),'YYYY')))+1),'dd/mm/yyyy')fy_enddt 
		into :ld_st_year,:ld_end_year
  from dual;
								  
 n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(dp_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=dp_1.text
end if;	 

setpointer(hourglass!)

//if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

if luo_fames.wf_horemittance_entry(ls_ac_dt, string(ld_st_year,'dd/mm/yyyy'), string(ld_end_year,'dd/mm/yyyy')) = -1 then 
	rollback using sqlca;
	return 1;
end if;

commit using sqlca;

DESTROY n_fames

setpointer(arrow!)

messagebox('Information','Jv Created Successfully !!!')

//sql for ho openning remittance entry

////SELECT  sum(decode(a.ACLEDGER_CUMLATIVE_IND,'C',decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0),
////                                                      'H',decode(trunc(VH_VOU_DATE),to_date(:fy_end_dt,'dd/mm/yyyy'),0,decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0)),
////                                                            decode(sign(trunc(VH_VOU_DATE)- to_date(:fy_st_dt,'dd/mm/yyyy')),-1,0,decode(a.ACLEDGER_ACTYPE,'A',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),'E',(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)),0))))  -
////        sum(decode(a.ACLEDGER_CUMLATIVE_IND,'C',decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0),
////                                                      'H',decode(trunc(VH_VOU_DATE),to_date(:fy_end_dt,'dd/mm/yyyy'),0,decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0)),
////                                                            decode(sign(trunc(VH_VOU_DATE) - to_date(:fy_st_dt,'dd/mm/yyyy')),-1,0,decode(a.ACLEDGER_ACTYPE,'L',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),'I',(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)),0)))) amt    
////  from FB_ACLEDGER a,fb_vou_head,Fb_vou_DET
//// where VH_DOC_SRL = vd_doc_srl and vd_gl_cd = ACLEDGER_ID AND ACLEDGER_CUMLATIVE_IND in ('C','H') and
////       trunc(VH_VOU_DATE) <= TO_DATE (:frdt,'dd/mm/yyyy') and VH_APPROVED_DT is not null
end event

