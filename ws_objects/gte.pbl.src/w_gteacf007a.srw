$PBExportHeader$w_gteacf007a.srw
forward
global type w_gteacf007a from window
end type
type st_3 from statictext within w_gteacf007a
end type
type sle_1 from singlelineedit within w_gteacf007a
end type
type em_6 from editmask within w_gteacf007a
end type
type cb_2 from commandbutton within w_gteacf007a
end type
type ddlb_1 from dropdownlistbox within w_gteacf007a
end type
type st_16 from statictext within w_gteacf007a
end type
type st_15 from statictext within w_gteacf007a
end type
type st_14 from statictext within w_gteacf007a
end type
type st_13 from statictext within w_gteacf007a
end type
type st_12 from statictext within w_gteacf007a
end type
type st_11 from statictext within w_gteacf007a
end type
type st_10 from statictext within w_gteacf007a
end type
type st_9 from statictext within w_gteacf007a
end type
type st_8 from statictext within w_gteacf007a
end type
type st_6 from statictext within w_gteacf007a
end type
type st_4 from statictext within w_gteacf007a
end type
type sle_3 from singlelineedit within w_gteacf007a
end type
type cb_1 from commandbutton within w_gteacf007a
end type
type st_2 from statictext within w_gteacf007a
end type
type st_1 from statictext within w_gteacf007a
end type
type em_1 from editmask within w_gteacf007a
end type
type em_2 from editmask within w_gteacf007a
end type
type em_3 from editmask within w_gteacf007a
end type
type em_4 from editmask within w_gteacf007a
end type
type em_5 from editmask within w_gteacf007a
end type
end forward

global type w_gteacf007a from window
integer width = 2510
integer height = 912
boolean titlebar = true
string title = "Advance"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
sle_1 sle_1
em_6 em_6
cb_2 cb_2
ddlb_1 ddlb_1
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_6 st_6
st_4 st_4
sle_3 sle_3
cb_1 cb_1
st_2 st_2
st_1 st_1
em_1 em_1
em_2 em_2
em_3 em_3
em_4 em_4
em_5 em_5
end type
global w_gteacf007a w_gteacf007a

type variables
string ls_empid, ls_pfno
end variables

on w_gteacf007a.create
this.st_3=create st_3
this.sle_1=create sle_1
this.em_6=create em_6
this.cb_2=create cb_2
this.ddlb_1=create ddlb_1
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_6=create st_6
this.st_4=create st_4
this.sle_3=create sle_3
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.em_1=create em_1
this.em_2=create em_2
this.em_3=create em_3
this.em_4=create em_4
this.em_5=create em_5
this.Control[]={this.st_3,&
this.sle_1,&
this.em_6,&
this.cb_2,&
this.ddlb_1,&
this.st_16,&
this.st_15,&
this.st_14,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_6,&
this.st_4,&
this.sle_3,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.em_1,&
this.em_2,&
this.em_3,&
this.em_4,&
this.em_5}
end on

on w_gteacf007a.destroy
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.em_6)
destroy(this.cb_2)
destroy(this.ddlb_1)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.sle_3)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.em_3)
destroy(this.em_4)
destroy(this.em_5)
end on

event open;setpointer(hourglass!)
if gd_loan_type ='PF' or  len(gs_emp_id) = 0 or  isnull(gs_emp_id) then
	ddlb_1.reset()
	declare c1 cursor for
	SELECT   initcap(EMP_NAME)||' ('||EMP_ID||')' Employee
		 FROM FB_EMPLOYEE  WHERE trim(EMP_INACTIVETYPE)='Regular' and nvl(EMP_ACTIVE,'0') = '1' order by 1;
			
	open c1;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c1 into :ls_empid;
		
		do while sqlca.sqlcode <> 100
			ddlb_1.additem(ls_empid)
			fetch c1 into :ls_empid;
		loop
		close c1;
	end if	
end if

setpointer(arrow!)
	
if len(gs_emp_id) > 0 then
	double ld_adv_bal
	ld_adv_bal=0
	
	SELECT  distinct   initcap(EMP_NAME)||' ('||EMP_ID||')' , EMP_PFNO,decode(:gd_loan_type,'CO',advbal,pfbal) into :ls_empid,:sle_3.text,:ld_adv_bal
	  FROM FB_EMPLOYEE, (select issue.labour_id, (nvl(issue.advissue,0)-nvl(ded.advded,0)) advbal, ((nvl(issue.pfadvissue,0) - nvl(ded.pfadvded,0))  + (nvl(issue.pfintissue,0) - nvl(ded.pfintded,0))) pfbal
									 from (select decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1) labour_id,sum(nvl(la_amount,0)) advissue,sum(nvl(la_pfadvance,0)) pfadvissue,sum(nvl(la_pfinterest,0)) pfintissue from fb_labouradvance la left outer join fb_labourphase1phase2 lp12 on (la.labour_id=lp12.labour_idphase1 or la.labour_id=lp12.labour_idphase2) where LA_DATE <= trunc(sysdate) group by decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1)) issue,
											(select decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1) labour_id,sum(nvl(advanceded,0)+nvl(ADVANCEDEDCASH,0)) advded,sum(nvl(pfadvanceded,0)+nvl(PFADVDEDCASH,0)) pfadvded,sum(nvl(pfinterestded,0)+nvl(PFINTDEDCASH,0)) pfintded from fb_labadvancededuction lad left outer join fb_labourphase1phase2 lp12 on (lad.labour_id=lp12.labour_idphase1 or lad.labour_id=lp12.labour_idphase2)  group by decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1)) ded
									where issue.labour_id = ded.labour_id(+)) dedn
	WHERE EMP_ID=:gs_emp_id  and emp_id = labour_id(+);
			
	ddlb_1.text=ls_empid
	ddlb_1.enabled = false
	
	if gs_apr_ind ='Y' then
		em_1.text = string(gd_loan_bal)
	else
		if isnull(ld_adv_bal) then ld_adv_bal=0
		em_1.text = string(ld_adv_bal,'0.00')
	end if
	
	//gd_loan_bal
	
end if

if gd_loan_type ='PF' then 
	sle_1.text='PF Advance' 
elseif gd_loan_type ='EL' then 
	sle_1.text='Electricity Advance' 
elseif gd_loan_type ='ME' then 
	sle_1.text='Medical Advance' 
elseif gd_loan_type ='FE' then 
	sle_1.text='Festival Advance' 
else 
	sle_1.text='Company'
end if 


if isnull(gd_amount) then gd_amount = 0;
if isnull(gd_int_amt) then gd_int_amt = 0;

if gs_dc_ind = 'D' then
	st_3.text = 'Advance Payment'
	em_2.text = string(gd_amount)
elseif gs_dc_ind = 'C' then
	st_3.text = 'Advance Realised'
	em_2.text = string(gd_amount - gd_int_amt)
end if 
			
em_3.text = string(gd_int_rate)
em_4.text = string(gd_int_amt)
em_5.text = gs_dedn_dt
em_6.text = string(gd_dedn_emi)

	
if gs_apr_ind ='Y' then
   cb_1.visible = false
end if
end event

type st_3 from statictext within w_gteacf007a
integer x = 178
integer y = 628
integer width = 1870
integer height = 164
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_gteacf007a
integer x = 2080
integer y = 140
integer width = 375
integer height = 76
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
integer limit = 256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type em_6 from editmask within w_gteacf007a
integer x = 1847
integer y = 488
integer width = 256
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,##0.00"
end type

type cb_2 from commandbutton within w_gteacf007a
integer x = 2162
integer y = 468
integer width = 251
integer height = 104
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;gb_retval = false
Close(parent)
end event

type ddlb_1 from dropdownlistbox within w_gteacf007a
integer x = 64
integer y = 128
integer width = 1650
integer height = 496
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty
double ld_adv_bal
string emp_id
 emp_id=ddlb_1.text
//ls_empid = left(right(ddlb_1.text,8),7);
if gs_garden_snm = 'SP' or gs_garden_snm = 'LP' or gs_garden_snm = 'AB' or gs_garden_snm = 'MR'  or gs_garden_snm = 'AD'  or gs_garden_snm= 'MH'  or gs_garden_snm= 'DR'  then
	//ls_empid		= left(right(ddlb_1.text,7),6);
	
	SELECT SUBSTR(:emp_id,INSTR(:emp_id, '(') + 1, INSTR(:emp_id, ')') - INSTR(:emp_id, '(') - 1) into :ls_empid FROM dual;
else
	ls_empid		= left(right(ddlb_1.text,8),7);
end if


ld_adv_bal=0

isnull(ls_pfno)

SELECT  distinct  EMP_NAME, EMP_PFNO,decode(:gd_loan_type,'CO',advbal,pfbal) into :ls_name,:ls_pfno,:ld_adv_bal
  FROM FB_EMPLOYEE, (select issue.labour_id, (nvl(issue.advissue,0)-nvl(ded.advded,0)) advbal, ((nvl(issue.pfadvissue,0) - nvl(ded.pfadvded,0))  + (nvl(issue.pfintissue,0) - nvl(ded.pfintded,0))) pfbal
								 from (select decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1) labour_id,sum(nvl(la_amount,0)) advissue,sum(nvl(la_pfadvance,0)) pfadvissue,sum(nvl(la_pfinterest,0)) pfintissue from fb_labouradvance la left outer join fb_labourphase1phase2 lp12 on (la.labour_id=lp12.labour_idphase1 or la.labour_id=lp12.labour_idphase2) where LA_DATE <= trunc(sysdate) group by decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1)) issue,
										(select decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1) labour_id,sum(nvl(advanceded,0)+nvl(ADVANCEDEDCASH,0)) advded,sum(nvl(pfadvanceded,0)+nvl(PFADVDEDCASH,0)) pfadvded,sum(nvl(pfinterestded,0)+nvl(PFINTDEDCASH,0)) pfintded from fb_labadvancededuction lad left outer join fb_labourphase1phase2 lp12 on (lad.labour_id=lp12.labour_idphase1 or lad.labour_id=lp12.labour_idphase2)  group by decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1)) ded
								where issue.labour_id = ded.labour_id(+)) dedn
WHERE EMP_ID=:ls_empid  and emp_id = labour_id(+);
	
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee ',sqlca.sqlerrtext)
   return 1
end if	

sle_3.text=""
 //messagebox('PF NO',ls_pfno)
 
sle_3.text=trim(ls_pfno);


if isnull(ld_adv_bal) then ld_adv_bal=0
em_1.text = string(ld_adv_bal,'0.00')
end event

type st_16 from statictext within w_gteacf007a
integer x = 837
integer y = 412
integer width = 256
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rate"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_15 from statictext within w_gteacf007a
integer x = 174
integer y = 352
integer width = 320
integer height = 136
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "O/s Advance Balance"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_14 from statictext within w_gteacf007a
integer x = 1093
integer y = 412
integer width = 338
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Amount"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_13 from statictext within w_gteacf007a
integer x = 1815
integer y = 412
integer width = 338
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "EWI/EMI"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_12 from statictext within w_gteacf007a
integer x = 1467
integer y = 412
integer width = 306
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date"
boolean focusrectangle = false
end type

type st_11 from statictext within w_gteacf007a
integer x = 1815
integer y = 348
integer width = 338
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deduction"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_10 from statictext within w_gteacf007a
integer x = 1467
integer y = 348
integer width = 306
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deduction"
boolean focusrectangle = false
end type

type st_9 from statictext within w_gteacf007a
integer x = 1093
integer y = 348
integer width = 338
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "PF Interest"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_gteacf007a
integer x = 837
integer y = 348
integer width = 256
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Interest"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_gteacf007a
integer x = 590
integer y = 364
integer width = 242
integer height = 124
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Advance Amount"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_gteacf007a
integer x = 2107
integer y = 72
integer width = 256
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Type "
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_gteacf007a
integer x = 1737
integer y = 144
integer width = 329
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
integer limit = 256
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_name,ls_ty
double ld_adv_bal

ls_pfno = sle_3.text;

ld_adv_bal=0

SELECT  distinct  initcap(EMP_NAME)||' ('||EMP_ID||')' EMP_NAME, EMP_PFNO,decode(:gd_loan_type,'CO',advbal,pfbal) into :ls_name,:ls_pfno,:ld_adv_bal
  FROM FB_EMPLOYEE, (select issue.labour_id, (nvl(issue.advissue,0)-nvl(ded.advded,0)) advbal, ((nvl(issue.pfadvissue,0) - nvl(ded.pfadvded,0))  + (nvl(issue.pfintissue,0) - nvl(ded.pfintded,0))) pfbal
								 from (select decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1) labour_id,sum(nvl(la_amount,0)) advissue,sum(nvl(la_pfadvance,0)) pfadvissue,sum(nvl(la_pfinterest,0)) pfintissue from fb_labouradvance la left outer join fb_labourphase1phase2 lp12 on (la.labour_id=lp12.labour_idphase1 or la.labour_id=lp12.labour_idphase2) where LA_DATE <= trunc(sysdate) group by decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1)) issue,
										(select decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1) labour_id,sum(nvl(advanceded,0)+nvl(ADVANCEDEDCASH,0)) advded,sum(nvl(pfadvanceded,0)+nvl(PFADVDEDCASH,0)) pfadvded,sum(nvl(pfinterestded,0)+nvl(PFINTDEDCASH,0)) pfintded from fb_labadvancededuction lad left outer join fb_labourphase1phase2 lp12 on (lad.labour_id=lp12.labour_idphase1 or lad.labour_id=lp12.labour_idphase2)  group by decode(lp12.labour_idphase1,NULL,labour_id,lp12.labour_idphase1)) ded
								where issue.labour_id = ded.labour_id(+)) dedn
WHERE EMP_PFNO =:ls_pfno  and emp_id = labour_id(+);
	
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee ',sqlca.sqlerrtext)
   return 1
end if	

ddlb_1.text = ls_name;
if isnull(ld_adv_bal) then ld_adv_bal=0
em_1.text = string(ld_adv_bal,'0.00')
end event

type cb_1 from commandbutton within w_gteacf007a
integer x = 2162
integer y = 344
integer width = 251
integer height = 104
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
end type

event clicked;gb_retval 		= true
if gs_garden_snm = 'SP' or gs_garden_snm = 'LP' or gs_garden_snm = 'AB' or gs_garden_snm = 'MR'  or gs_garden_snm = 'AD'  or gs_garden_snm= 'MH'  or gs_garden_snm= 'DR' then
	gs_emp_id		= left(right(ddlb_1.text,7),6);
else
	gs_emp_id		= left(right(ddlb_1.text,8),7);
end if
gs_emp_pfno 	= sle_3.text;
gd_int_rate     	= double(em_3.text);
gd_adv_amt		=double(em_2.text );
gd_int_amt     	= double(em_4.text);
gd_loan_bal   	= double(em_1.text);
gd_dedn_emi 	= double(em_6.text);
gs_dedn_dt    	= em_5.text

if gs_dc_ind = 'C' then
	if isnull(gd_int_amt) then gd_int_amt=0;
	if isnull(gd_adv_amt) then gd_adv_amt=0;
	if isnull(gd_amount) then gd_amount=0;
	
	if gd_adv_amt  + gd_int_amt  <> gd_amount then
		messagebox('Warnning:', 'Advance Amount + Intrest Amount Should be Equal to to total Credit Amount,Please check')
		return 1	
     end if;
end if;

em_2.text = string(gd_amount)
close(parent)
end event

type st_2 from statictext within w_gteacf007a
integer x = 1774
integer y = 80
integer width = 210
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "PF No. "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteacf007a
integer x = 366
integer y = 40
integer width = 453
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour / Employee"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gteacf007a
integer x = 128
integer y = 488
integer width = 370
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "#,##0.00"
end type

type em_2 from editmask within w_gteacf007a
integer x = 503
integer y = 488
integer width = 334
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,##0.00"
end type

type em_3 from editmask within w_gteacf007a
integer x = 837
integer y = 488
integer width = 256
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,##0.00"
end type

type em_4 from editmask within w_gteacf007a
integer x = 1093
integer y = 488
integer width = 338
integer height = 92
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,##0.00"
end type

type em_5 from editmask within w_gteacf007a
integer x = 1431
integer y = 488
integer width = 411
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

