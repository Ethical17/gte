$PBExportHeader$w_gteflr009_mis_old.srw
forward
global type w_gteflr009_mis_old from window
end type
type dp_2 from datepicker within w_gteflr009_mis_old
end type
type st_2 from statictext within w_gteflr009_mis_old
end type
type dp_1 from datepicker within w_gteflr009_mis_old
end type
type st_1 from statictext within w_gteflr009_mis_old
end type
type cb_2 from commandbutton within w_gteflr009_mis_old
end type
type cb_1 from commandbutton within w_gteflr009_mis_old
end type
type dw_1 from datawindow within w_gteflr009_mis_old
end type
end forward

global type w_gteflr009_mis_old from window
integer width = 3854
integer height = 2460
boolean titlebar = true
string title = "(Gteflr009_old) - Section Wise Cost & Yield"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_2 dp_2
st_2 st_2
dp_1 dp_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteflr009_mis_old w_gteflr009_mis_old

type variables
long ll_year,ll_lyear, ll_pyear
double ld_teamade,ld_teamade_ly, ld_teamade_py, ld_recper, ld_recper_ly, ld_recper_py, ld_totgl, ld_totgl_ly, ld_totgl_py
double ld_unallocated, ld_unallocated_ly, ld_unallocated_py,ld_indirectcost, ld_indirectcost_ly, ld_indirectcost_py 
double ld_gardenarea, ld_una_costph, ld_una_costph_ly, ld_una_costph_py, ld_ind_costph, ld_ind_costph_ly, ld_ind_costph_py
double ld_secarea_ly, ld_yieldphec_ly, ld_wages_ly, ld_stores_ly, ld_unallocated_fly, ld_Indirect_ly
double ld_secarea_py, ld_yieldphec_py, ld_wages_py, ld_stores_py, ld_unallocated_fpy, ld_Indirect_py
n_cst_powerfilter iu_powerfilter
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

on w_gteflr009_mis_old.create
this.dp_2=create dp_2
this.st_2=create st_2
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.dp_2,&
this.st_2,&
this.dp_1,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteflr009_mis_old.destroy
destroy(this.dp_2)
destroy(this.st_2)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//em_1.text = string(today(),'yyyy')

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))
end event

type dp_2 from datepicker within w_gteflr009_mis_old
integer x = 937
integer y = 12
integer width = 389
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-12-03"), Time("14:38:40.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteflr009_mis_old
integer x = 791
integer y = 28
integer width = 137
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To : "
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteflr009_mis_old
integer x = 384
integer y = 12
integer width = 389
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2014-12-03"), Time("14:38:40.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gteflr009_mis_old
integer x = 5
integer y = 28
integer width = 379
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Period From : "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteflr009_mis_old
integer x = 1609
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteflr009_mis_old
integer x = 1344
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;string ra_frdt,ra_todt,ra_frdt_ly,ra_todt_ly,ra_frdt_py,ra_todt_py,ls_ysdt 
dw_1.settransobject(sqlca)

setpointer(hourglass!) 

if isnull(dp_1.text) or dp_1.text='00/00/0000' then
	messagebox('Warning','Please Enter The "From" Date !!!')
	return 
end if

if isnull(dp_2.text) or dp_2.text='00/00/0000' then
	messagebox('Warning','Please Enter The "To" Date !!!')
	return 
end if

if date(dp_1.text) > date(dp_2.text)  then
	messagebox('Warning ','The From Date Should be <= TO Date , Please check ...!')
	return 1
end if


ra_frdt = dp_1.text
ra_todt = dp_2.text

select decode('C','C','01/01/'||to_char(to_date(:ra_frdt,'dd/mm/yyyy'),'yyyy'),to_char(to_date((decode(sign(to_number(to_char(to_date(:ra_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ra_frdt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ra_frdt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy'))
  into :ls_ysdt from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During Date Select',sqlca.sqlerrtext)
	return 1
end if

select (to_char(to_date(:ra_frdt,'dd/mm/yyyy'),'dd/mm/')||to_char((to_number(to_char(to_date(:ra_frdt,'dd/mm/yyyy'),'yyyy'))-1))),
		(to_char(to_date(:ra_todt,'dd/mm/yyyy'),'dd/mm/')||(to_number(to_char(to_date(:ra_todt,'dd/mm/yyyy'),'yyyy'))-1)),
		(to_char(to_date(:ra_frdt,'dd/mm/yyyy'),'dd/mm/')||to_char((to_number(to_char(to_date(:ra_frdt,'dd/mm/yyyy'),'yyyy'))-2))),
		(to_char(to_date(:ra_todt,'dd/mm/yyyy'),'dd/mm/')||(to_number(to_char(to_date(:ra_todt,'dd/mm/yyyy'),'yyyy'))-2))
  into :ra_frdt_ly,:ra_todt_ly,:ra_frdt_py, :ra_todt_py  from dual;

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During Date Select',sqlca.sqlerrtext)
	return 1
end if

ll_year = long(right(string(date(dp_1.text)),4))
ll_lyear = long(right(string(date(dp_1.text)),4)) -1
ll_pyear= long(right(string(date(dp_1.text)),4)) - 2

//select sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_frdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_todt,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0))))
//  into :ld_teamade 
//from fb_glforproduction a,fb_gardenwiseteamade b 
//where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and 
//		trunc(GLFP_PLUCKINGDATE) between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy');
select nvl(sum(nvl(GWTM_TEAMADE,0)),0) into :ld_teamade from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and to_number(to_char(GLFP_PLUCKINGDATE,'YYYY')) = :ll_year;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

select nvl(sum(nvl(GWTM_TEAMADE,0)),0) into :ld_teamade_ly from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and to_number(to_char(GLFP_PLUCKINGDATE,'YYYY')) = :ll_lyear;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

select nvl(sum(nvl(GWTM_TEAMADE,0)),0) into :ld_teamade_py from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and to_number(to_char(GLFP_PLUCKINGDATE,'YYYY')) = :ll_pyear;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

//select sum(decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_frdt,'dd/mm/yyyy')),-1,0,decode(sign(GLFP_PLUCKINGDATE - to_date(:ra_todt,'dd/mm/yyyy')),1,0,nvl(GWTM_TEAMADE,0))))
//  into :ld_totgl
//from fb_glforproduction a,fb_gardenwiseteamade b 
//where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and 
//		trunc(GLFP_PLUCKINGDATE) between to_date(:ls_ysdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy');
		
SELECT sum(nvl(glt.gt_quantity,0)) into :ld_totgl  FROM fb_gltransaction glt, fb_supplier sup
WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER')    and NVL (glt.gt_quantity, 0) > 0    and
		  to_number(to_char(glt.pluckingdate,'YYYY')) = :ll_year;			
				
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Green Leaf',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

SELECT sum(nvl(glt.gt_quantity,0)) into :ld_totgl_ly  FROM fb_gltransaction glt, fb_supplier sup
WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER')    and NVL (glt.gt_quantity, 0) > 0    and
		  to_number(to_char(glt.pluckingdate,'YYYY')) = :ll_lyear;			
				
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Green Leaf',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

SELECT sum(nvl(glt.gt_quantity,0)) into :ld_totgl_py  FROM fb_gltransaction glt, fb_supplier sup
WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER')    and NVL (glt.gt_quantity, 0) > 0    and
		  to_number(to_char(glt.pluckingdate,'YYYY')) = :ll_pyear;			
				
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Green Leaf',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

if isnull(ld_teamade) then ld_teamade = 0
if isnull(ld_totgl) then ld_totgl = 0
if ld_totgl = 0 then
	ld_recper = 0
else
	ld_recper = round(ld_teamade / ld_totgl * 100,2)
end if

if isnull(ld_teamade_ly) then ld_teamade_ly = 0
if isnull(ld_totgl_ly) then ld_totgl_ly = 0
if ld_totgl_ly = 0 then
	ld_recper_ly = 0
else
	ld_recper_ly = round(ld_teamade_ly / ld_totgl_ly * 100,2)
end if

if isnull(ld_teamade_py) then ld_teamade_py = 0
if isnull(ld_totgl_py) then ld_totgl_py = 0
if ld_totgl_py = 0 then
	ld_recper_py = 0
else
	ld_recper_py = round(ld_teamade_py / ld_totgl_py * 100,2)
end if

select sum(decode(ACSUBLEDGER_COSTNATURE,'D',decode(VD_SECTION_ID,null,nvl(value,0),0),0)) unallocated,
	   	   sum(decode(ACSUBLEDGER_COSTNATURE,'I',nvl(value,0),0)) InDirect
into :ld_unallocated, :ld_indirectcost
from 
(	select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(value,0)) value
	from
	(	select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(vd_amount,0)) value from fb_vou_det,fb_vou_head 
		where VH_DOC_SRL = VD_DOC_SRL and VD_SECTION_ID not like 'CC%' and trunc(vh_vou_date) between to_date(:ra_frdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy') and vd_expsubhead is not null 
		group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID 
		union 
		select 'T',EACSUBHEAD_ID, SECTION_ID, sum(nvl(PRIS_VALUE,0)) from fb_productissuedetails a,fb_productissue b 
		where a.PRIS_ID = b.PRIS_ID and nvl(PRIS_STOCKIND,'N') = 'Y' and trunc(pris_date) between to_date(:ra_frdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID, SECTION_ID 
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(SA_VALUE,0)) from fb_stores_adjustment 
		where nvl(SA_STOCKIND,'N') = 'Y' and trunc(SA_ADJ_DATE) between to_date(:ra_frdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID 
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(PRET_VALUE,0)) from fb_productreturndetails a,fb_productreturn b 
		where a.PRET_ID = b.PRET_ID and nvl(PRET_STOCKIND,'N') = 'Y' and trunc(pret_date) between to_date(:ra_frdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(SPR_UNITPRICE,0) * nvl(SPR_QUANTITY,0)) from fb_supproductreturndetails a,fb_supproductreturn b, 
			   (select distinct EACSUBHEAD_ID,SP_ID from fb_storeproduct, fb_expenseacsubhead where SPC_ID = EACHEAD_ID) c 
		where a.SPR_ID = b.SPR_ID and a.SP_ID = c.SP_ID and nvl(SPR_STOCKIND,'N') = 'Y' and trunc(SPR_DATE) between to_date(:ra_frdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID
		union 
		select 'W',KAMSUB_ID, LDA_SECTIONID1, sum(nvl(LDA_WAGES,0)) from fb_labourdailyattendance
		where trunc(LDA_DATE) between to_date(:ra_frdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy') and KAMSUB_ID is not null 
		group by KAMSUB_ID, LDA_SECTIONID1 
		union 
		select 'W',OT_KAMSUB_ID, null, sum(nvl(OT_AMOUNT,0)) from fb_overtime
		where trunc(OT_DT) between to_date(:ra_frdt,'dd/mm/yyyy') and to_date(:ra_todt,'dd/mm/yyyy') and OT_KAMSUB_ID is not null 
		group by OT_KAMSUB_ID)
	group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID) a,fb_acsubledger b, FB_EXPENSEACSUBHEAD c 
where a.vd_expsubhead = c.EACSUBHEAD_ID and b.ACSUBLEDGER_ID = c.EACHEAD_ID;

select sum(decode(ACSUBLEDGER_COSTNATURE,'D',decode(VD_SECTION_ID,null,nvl(value,0),0),0)) unallocated,
	   	   sum(decode(ACSUBLEDGER_COSTNATURE,'I',nvl(value,0),0)) InDirect
into :ld_unallocated_ly, :ld_indirectcost_ly
from 
(	select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(value,0)) value
	from
	(	select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(vd_amount,0)) value from fb_vou_det,fb_vou_head 
		where VH_DOC_SRL = VD_DOC_SRL and VD_SECTION_ID not like 'CC%' and trunc(vh_vou_date) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and vd_expsubhead is not null 
		group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID 
		union 
		select 'T',EACSUBHEAD_ID, SECTION_ID, sum(nvl(PRIS_VALUE,0)) from fb_productissuedetails a,fb_productissue b 
		where a.PRIS_ID = b.PRIS_ID and nvl(PRIS_STOCKIND,'N') = 'Y' and trunc(pris_date) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID, SECTION_ID 
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(SA_VALUE,0)) from fb_stores_adjustment 
		where nvl(SA_STOCKIND,'N') = 'Y' and trunc(SA_ADJ_DATE) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID 
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(PRET_VALUE,0)) from fb_productreturndetails a,fb_productreturn b 
		where a.PRET_ID = b.PRET_ID and nvl(PRET_STOCKIND,'N') = 'Y' and trunc(pret_date) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(SPR_UNITPRICE,0) * nvl(SPR_QUANTITY,0)) from fb_supproductreturndetails a,fb_supproductreturn b, 
			   (select distinct EACSUBHEAD_ID,SP_ID from fb_storeproduct, fb_expenseacsubhead where SPC_ID = EACHEAD_ID) c 
		where a.SPR_ID = b.SPR_ID and a.SP_ID = c.SP_ID and nvl(SPR_STOCKIND,'N') = 'Y' and trunc(SPR_DATE) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID
		union 
		select 'W',KAMSUB_ID, LDA_SECTIONID1, sum(nvl(LDA_WAGES,0)) from fb_labourdailyattendance
		where trunc(LDA_DATE) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and KAMSUB_ID is not null 
		group by KAMSUB_ID, LDA_SECTIONID1 
		union 
		select 'W',OT_KAMSUB_ID, null, sum(nvl(OT_AMOUNT,0)) from fb_overtime
		where trunc(OT_DT) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and OT_KAMSUB_ID is not null 
		group by OT_KAMSUB_ID)
	group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID) a,fb_acsubledger b, FB_EXPENSEACSUBHEAD c 
where a.vd_expsubhead = c.EACSUBHEAD_ID and b.ACSUBLEDGER_ID = c.EACHEAD_ID;

select sum(decode(ACSUBLEDGER_COSTNATURE,'D',decode(VD_SECTION_ID,null,nvl(value,0),0),0)) unallocated,
	   	   sum(decode(ACSUBLEDGER_COSTNATURE,'I',nvl(value,0),0)) InDirect
into :ld_unallocated, :ld_indirectcost
from 
(	select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(value,0)) value
	from
	(	select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(vd_amount,0)) value from fb_vou_det,fb_vou_head 
		where VH_DOC_SRL = VD_DOC_SRL and VD_SECTION_ID not like 'CC%' and trunc(vh_vou_date) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and vd_expsubhead is not null 
		group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID 
		union 
		select 'T',EACSUBHEAD_ID, SECTION_ID, sum(nvl(PRIS_VALUE,0)) from fb_productissuedetails a,fb_productissue b 
		where a.PRIS_ID = b.PRIS_ID and nvl(PRIS_STOCKIND,'N') = 'Y' and trunc(pris_date) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID, SECTION_ID 
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(SA_VALUE,0)) from fb_stores_adjustment 
		where nvl(SA_STOCKIND,'N') = 'Y' and trunc(SA_ADJ_DATE) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID 
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(PRET_VALUE,0)) from fb_productreturndetails a,fb_productreturn b 
		where a.PRET_ID = b.PRET_ID and nvl(PRET_STOCKIND,'N') = 'Y' and trunc(pret_date) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID
		union 
		select 'T',EACSUBHEAD_ID, null, sum(nvl(SPR_UNITPRICE,0) * nvl(SPR_QUANTITY,0)) from fb_supproductreturndetails a,fb_supproductreturn b, 
			   (select distinct EACSUBHEAD_ID,SP_ID from fb_storeproduct, fb_expenseacsubhead where SPC_ID = EACHEAD_ID) c 
		where a.SPR_ID = b.SPR_ID and a.SP_ID = c.SP_ID and nvl(SPR_STOCKIND,'N') = 'Y' and trunc(SPR_DATE) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
		group by EACSUBHEAD_ID
		union 
		select 'W',KAMSUB_ID, LDA_SECTIONID1, sum(nvl(LDA_WAGES,0)) from fb_labourdailyattendance
		where trunc(LDA_DATE) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and KAMSUB_ID is not null 
		group by KAMSUB_ID, LDA_SECTIONID1 
		union 
		select 'W',OT_KAMSUB_ID, null, sum(nvl(OT_AMOUNT,0)) from fb_overtime
		where trunc(OT_DT) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and OT_KAMSUB_ID is not null 
		group by OT_KAMSUB_ID)
	group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID) a,fb_acsubledger b, FB_EXPENSEACSUBHEAD c 
where a.vd_expsubhead = c.EACSUBHEAD_ID and b.ACSUBLEDGER_ID = c.EACHEAD_ID;

select sum(nvl(SECTION_AREA,0)) into :ld_gardenarea from fb_section;

if isnull(ld_unallocated) then ld_unallocated = 0
if isnull(ld_indirectcost) then ld_indirectcost = 0
if isnull(ld_gardenarea) then ld_gardenarea = 0

if ld_gardenarea = 0 then
	ld_una_costph = 0
	ld_ind_costph = 0
else
	ld_una_costph = ld_unallocated / ld_gardenarea
	ld_ind_costph = ld_indirectcost / ld_gardenarea
end if

if isnull(ld_unallocated_ly) then ld_unallocated_ly = 0
if isnull(ld_indirectcost) then ld_indirectcost_ly = 0

if ld_gardenarea = 0 then
	ld_una_costph_ly = 0
	ld_ind_costph_ly = 0
else
	ld_una_costph_ly = ld_unallocated_ly / ld_gardenarea
	ld_ind_costph_ly = ld_indirectcost_ly / ld_gardenarea
end if

if isnull(ld_unallocated_py) then ld_unallocated_py = 0
if isnull(ld_indirectcost_py) then ld_indirectcost_py = 0


if ld_gardenarea = 0 then
	ld_una_costph_py = 0
	ld_ind_costph_py = 0
else
	ld_una_costph_py = ld_unallocated_py / ld_gardenarea
	ld_ind_costph_py = ld_indirectcost_py / ld_gardenarea
end if

SELECT sum(nvl(a.SECTION_AREA,0)) secarea,  
           round((sum(nvl(totgl,0)) * nvl(:ld_recper_ly,0) / 100),2) yieldphec,
           sum(nvl(wages,0)) wages, sum(nvl(stores,0)) stores, sum((nvl(:ld_una_costph_ly,0) * a.SECTION_AREA)) unallocated, 
		  sum(nvl(:ld_ind_costph_ly,0) * a.SECTION_AREA) Indirect
into :ld_secarea_ly, :ld_yieldphec_ly, :ld_wages_ly, :ld_stores_ly, :ld_unallocated_fly, :ld_Indirect_ly
FROM   FB_SECTION a, (select SECTION_ID, PRUN_STYLE from fb_pruningsession where PRUN_YEAR = to_number(to_char(to_date(:ra_frdt_ly,'dd/mm/yyyy'),'yyyy'))) b,
            (select c.section_id,
                    sum(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
                  nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
                     nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
                 nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
                 nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0))  totgl
            from FB_TASKACTIVEDAILY c, FB_KAMSUBHEAD e,  FB_TASKACTIVEMEASUREMENT f 
            where c.TASKDATE_ID = f.TASKSECTION_ID AND c.TASK_ID = e.KAMSUB_ID AND nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and e.KAMSUB_TYPE = 'PLUCK' AND
                    trunc(TASK_DATE) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy')
            group by  c.section_id union all
            select SECTION_ID, sum(nvl(SPR_GL,0)) cash_gl
         from FB_SECTIONPLUCKINGROUND where SPR_PLUCCKTYPE = 'C' and trunc(SPR_DATE) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') 
        group by SECTION_ID) f,
       (select VD_SECTION_ID,
               sum(decode(ACSUBLEDGER_COSTNATURE,'D',decode(vd_preferred_mes,'W',decode(nvl(VD_SECTION_ID,'X'),'X',0,nvl(value,0)),0),0)) wages,
               sum(decode(ACSUBLEDGER_COSTNATURE,'D',decode(vd_preferred_mes,'T',decode(nvl(VD_SECTION_ID,'X'),'X',0,nvl(value,0)),0),0)) stores
        from 
        (    select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(value,0)) value
            from
            (    select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(vd_amount,0)) value from fb_vou_det,fb_vou_head 
                where VH_DOC_SRL = VD_DOC_SRL and VD_SECTION_ID not like 'CC%' and trunc(vh_vou_date) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and vd_expsubhead is not null 
                group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID 
                union 
                select 'T',EACSUBHEAD_ID, SECTION_ID, sum(nvl(PRIS_VALUE,0)) from fb_productissuedetails a,fb_productissue b 
                where a.PRIS_ID = b.PRIS_ID and nvl(PRIS_STOCKIND,'N') = 'Y' and trunc(pris_date) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
                group by EACSUBHEAD_ID, SECTION_ID 
                union 
                select 'T',EACSUBHEAD_ID, null, sum(nvl(SA_VALUE,0)) from fb_stores_adjustment 
                where nvl(SA_STOCKIND,'N') = 'Y' and trunc(SA_ADJ_DATE) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
                group by EACSUBHEAD_ID 
                union 
                select 'T',EACSUBHEAD_ID, null, sum(nvl(PRET_VALUE,0)) from fb_productreturndetails a,fb_productreturn b 
                where a.PRET_ID = b.PRET_ID and nvl(PRET_STOCKIND,'N') = 'Y' and trunc(pret_date) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
                group by EACSUBHEAD_ID
                union 
                select 'T',EACSUBHEAD_ID, null, sum(nvl(SPR_UNITPRICE,0) * nvl(SPR_QUANTITY,0)) from fb_supproductreturndetails a,fb_supproductreturn b, 
                       (select distinct EACSUBHEAD_ID,SP_ID from fb_storeproduct, fb_expenseacsubhead where SPC_ID = EACHEAD_ID) c 
                where a.SPR_ID = b.SPR_ID and a.SP_ID = c.SP_ID and nvl(SPR_STOCKIND,'N') = 'Y' and trunc(SPR_DATE) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
                group by EACSUBHEAD_ID
                union 
                select 'W',KAMSUB_ID, LDA_SECTIONID1, sum(nvl(LDA_WAGES,0)) from fb_labourdailyattendance
                where trunc(LDA_DATE) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and KAMSUB_ID is not null 
                group by KAMSUB_ID, LDA_SECTIONID1 
                union 
                select 'W',OT_KAMSUB_ID, null, sum(nvl(OT_AMOUNT,0)) from fb_overtime
                where trunc(OT_DT) between to_date(:ra_frdt_ly,'dd/mm/yyyy') and to_date(:ra_todt_ly,'dd/mm/yyyy') and OT_KAMSUB_ID is not null 
                group by OT_KAMSUB_ID)
            group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID) a,fb_acsubledger b, FB_EXPENSEACSUBHEAD c 
        where a.vd_expsubhead = c.EACSUBHEAD_ID and b.ACSUBLEDGER_ID = c.EACHEAD_ID and VD_SECTION_ID is not null
        group by VD_SECTION_ID)
WHERE a.SECTION_ID = f.SECTION_ID(+) and a.SECTION_ID = b.SECTION_ID(+) and a.SECTION_ID = VD_SECTION_ID(+) and a.SECTION_TYPE ='S';

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During getting Last year data',sqlca.sqlerrtext)
	return 1
end if


SELECT  sum(nvl(a.SECTION_AREA,0)) secarea,  
           round((sum(nvl(totgl,0)) * nvl(:ld_recper_py,0) / 100),2) yieldphec,
           sum(nvl(wages,0)) wages, sum(nvl(stores,0)) stores, sum((nvl(:ld_una_costph_py,0) * a.SECTION_AREA)) unallocated, 
	      sum(nvl(:ld_ind_costph_py,0) * a.SECTION_AREA) Indirect
into :ld_secarea_py, :ld_yieldphec_py, :ld_wages_py, :ld_stores_py, :ld_unallocated_fpy, :ld_Indirect_py			  		  
FROM   FB_SECTION a, (select SECTION_ID, PRUN_STYLE from fb_pruningsession where PRUN_YEAR = to_number(to_char(to_date(:ra_frdt_py,'dd/mm/yyyy'),'yyyy'))) b,
            (select c.section_id,
                    sum(nvl(f.TASK_PMACOUNTTODAYTY,0) + nvl(f.TASK_PFACOUNTTODAYTY,0) + nvl(f.TASK_TMACOUNTTODAYTY,0) + nvl(f.TASK_TFACOUNTTODAYTY,0) + 
                  nvl(f.TASK_OMACOUNTTODAYTY,0) + nvl(f.TASK_OFACOUNTTODAYTY,0) + nvl(f.TASK_PMADCOUNTTODAYTY,0) + nvl(f.TASK_PFADCOUNTTODAYTY,0) + 
                     nvl(f.TASK_TMADCOUNTTODAYTY,0) + nvl(f.TASK_TFADCOUNTTODAYTY,0) + nvl(f.TASK_OMADCOUNTTODAYTY,0) + nvl(f.TASK_OFADCOUNTTODAYTY,0) + 
                 nvl(f.TASK_PMCCOUNTTODAYTY,0) + nvl(f.TASK_PFCCOUNTTODAYTY,0) + nvl(f.TASK_TMCCOUNTTODAYTY,0) + nvl(f.TASK_TFCCOUNTTODAYTY,0) + 
                 nvl(f.TASK_OMCCOUNTTODAYTY,0) + nvl(f.TASK_OFCCOUNTTODAYTY,0))  totgl
            from FB_TASKACTIVEDAILY c, FB_KAMSUBHEAD e,  FB_TASKACTIVEMEASUREMENT f 
            where c.TASKDATE_ID = f.TASKSECTION_ID AND c.TASK_ID = e.KAMSUB_ID AND nvl(KAMSUB_ACTIVE_IND,'N') = 'Y' and e.KAMSUB_TYPE = 'PLUCK' AND
                    trunc(TASK_DATE) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy')
            group by  c.section_id union all
            select SECTION_ID, sum(nvl(SPR_GL,0)) cash_gl
         from FB_SECTIONPLUCKINGROUND where SPR_PLUCCKTYPE = 'C' and trunc(SPR_DATE) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') 
        group by SECTION_ID) f,
       (select VD_SECTION_ID,
               sum(decode(ACSUBLEDGER_COSTNATURE,'D',decode(vd_preferred_mes,'W',decode(nvl(VD_SECTION_ID,'X'),'X',0,nvl(value,0)),0),0)) wages,
               sum(decode(ACSUBLEDGER_COSTNATURE,'D',decode(vd_preferred_mes,'T',decode(nvl(VD_SECTION_ID,'X'),'X',0,nvl(value,0)),0),0)) stores
        from 
        (    select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(value,0)) value
            from
            (    select vd_preferred_mes,vd_expsubhead,VD_SECTION_ID, sum(nvl(vd_amount,0)) value from fb_vou_det,fb_vou_head 
                where VH_DOC_SRL = VD_DOC_SRL and VD_SECTION_ID not like 'CC%' and trunc(vh_vou_date) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and vd_expsubhead is not null 
                group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID 
                union 
                select 'T',EACSUBHEAD_ID, SECTION_ID, sum(nvl(PRIS_VALUE,0)) from fb_productissuedetails a,fb_productissue b 
                where a.PRIS_ID = b.PRIS_ID and nvl(PRIS_STOCKIND,'N') = 'Y' and trunc(pris_date) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
                group by EACSUBHEAD_ID, SECTION_ID 
                union 
                select 'T',EACSUBHEAD_ID, null, sum(nvl(SA_VALUE,0)) from fb_stores_adjustment 
                where nvl(SA_STOCKIND,'N') = 'Y' and trunc(SA_ADJ_DATE) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
                group by EACSUBHEAD_ID 
                union 
                select 'T',EACSUBHEAD_ID, null, sum(nvl(PRET_VALUE,0)) from fb_productreturndetails a,fb_productreturn b 
                where a.PRET_ID = b.PRET_ID and nvl(PRET_STOCKIND,'N') = 'Y' and trunc(pret_date) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
                group by EACSUBHEAD_ID
                union 
                select 'T',EACSUBHEAD_ID, null, sum(nvl(SPR_UNITPRICE,0) * nvl(SPR_QUANTITY,0)) from fb_supproductreturndetails a,fb_supproductreturn b, 
                       (select distinct EACSUBHEAD_ID,SP_ID from fb_storeproduct, fb_expenseacsubhead where SPC_ID = EACHEAD_ID) c 
                where a.SPR_ID = b.SPR_ID and a.SP_ID = c.SP_ID and nvl(SPR_STOCKIND,'N') = 'Y' and trunc(SPR_DATE) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and EACSUBHEAD_ID is not null 
                group by EACSUBHEAD_ID
                union 
                select 'W',KAMSUB_ID, LDA_SECTIONID1, sum(nvl(LDA_WAGES,0)) from fb_labourdailyattendance
                where trunc(LDA_DATE) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and KAMSUB_ID is not null 
                group by KAMSUB_ID, LDA_SECTIONID1 
                union 
                select 'W',OT_KAMSUB_ID, null, sum(nvl(OT_AMOUNT,0)) from fb_overtime
                where trunc(OT_DT) between to_date(:ra_frdt_py,'dd/mm/yyyy') and to_date(:ra_todt_py,'dd/mm/yyyy') and OT_KAMSUB_ID is not null 
                group by OT_KAMSUB_ID)
            group by vd_preferred_mes,vd_expsubhead,VD_SECTION_ID) a,fb_acsubledger b, FB_EXPENSEACSUBHEAD c 
        where a.vd_expsubhead = c.EACSUBHEAD_ID and b.ACSUBLEDGER_ID = c.EACHEAD_ID and VD_SECTION_ID is not null
        group by VD_SECTION_ID)
WHERE a.SECTION_ID = f.SECTION_ID(+) and a.SECTION_ID = b.SECTION_ID(+) and a.SECTION_ID = VD_SECTION_ID(+) and a.SECTION_TYPE ='S';

if sqlca.sqlcode =-1 then
	messagebox('SQL Error During getting Prior year data',sqlca.sqlerrtext)
	return 1
end if

dw_1.retrieve(dp_1.text,dp_2.text,ld_recper,ld_una_costph,ld_ind_costph,ld_teamade,ld_secarea_ly,ld_yieldphec_ly,ld_wages_ly,ld_stores_ly,ld_unallocated_fly,ld_Indirect_ly,ld_secarea_py,ld_yieldphec_py,ld_wages_py,ld_stores_py,ld_unallocated_fpy,ld_Indirect_py)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found !!!')
	return 1
end if
end event

type dw_1 from datawindow within w_gteflr009_mis_old
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 3657
integer height = 1940
string dataobject = "dw_gteflr009_mis_old"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

