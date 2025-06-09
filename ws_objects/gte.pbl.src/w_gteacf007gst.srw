$PBExportHeader$w_gteacf007gst.srw
forward
global type w_gteacf007gst from window
end type
type ddlb_14 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_13 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_12 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_11 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_10 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_9 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_8 from dropdownlistbox within w_gteacf007gst
end type
type st_9 from statictext within w_gteacf007gst
end type
type ddlb_7 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_6 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_5 from dropdownlistbox within w_gteacf007gst
end type
type em_7 from editmask within w_gteacf007gst
end type
type em_6 from editmask within w_gteacf007gst
end type
type st_8 from statictext within w_gteacf007gst
end type
type em_5 from editmask within w_gteacf007gst
end type
type em_4 from editmask within w_gteacf007gst
end type
type st_7 from statictext within w_gteacf007gst
end type
type ddlb_3 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_4 from dropdownlistbox within w_gteacf007gst
end type
type ddlb_2 from dropdownlistbox within w_gteacf007gst
end type
type st_5 from statictext within w_gteacf007gst
end type
type st_4 from statictext within w_gteacf007gst
end type
type st_3 from statictext within w_gteacf007gst
end type
type cb_2 from commandbutton within w_gteacf007gst
end type
type ddlb_1 from dropdownlistbox within w_gteacf007gst
end type
type st_15 from statictext within w_gteacf007gst
end type
type st_6 from statictext within w_gteacf007gst
end type
type sle_4 from singlelineedit within w_gteacf007gst
end type
type sle_3 from singlelineedit within w_gteacf007gst
end type
type cb_1 from commandbutton within w_gteacf007gst
end type
type st_2 from statictext within w_gteacf007gst
end type
type st_1 from statictext within w_gteacf007gst
end type
type em_1 from editmask within w_gteacf007gst
end type
type em_2 from editmask within w_gteacf007gst
end type
type em_3 from editmask within w_gteacf007gst
end type
type ln_1 from line within w_gteacf007gst
end type
type ln_2 from line within w_gteacf007gst
end type
type ln_3 from line within w_gteacf007gst
end type
type ln_4 from line within w_gteacf007gst
end type
end forward

global type w_gteacf007gst from window
integer width = 3579
integer height = 1520
boolean titlebar = true
string title = "GST"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
ddlb_14 ddlb_14
ddlb_13 ddlb_13
ddlb_12 ddlb_12
ddlb_11 ddlb_11
ddlb_10 ddlb_10
ddlb_9 ddlb_9
ddlb_8 ddlb_8
st_9 st_9
ddlb_7 ddlb_7
ddlb_6 ddlb_6
ddlb_5 ddlb_5
em_7 em_7
em_6 em_6
st_8 st_8
em_5 em_5
em_4 em_4
st_7 st_7
ddlb_3 ddlb_3
ddlb_4 ddlb_4
ddlb_2 ddlb_2
st_5 st_5
st_4 st_4
st_3 st_3
cb_2 cb_2
ddlb_1 ddlb_1
st_15 st_15
st_6 st_6
sle_4 sle_4
sle_3 sle_3
cb_1 cb_1
st_2 st_2
st_1 st_1
em_1 em_1
em_2 em_2
em_3 em_3
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
end type
global w_gteacf007gst w_gteacf007gst

type variables
string ls_empid, ls_hsn_no, ls_hsn_desc
//ls_sgst_leg_rec, ls_igst_leg_rec, ls_cgst_leg_pay, ls_sgst_leg_pay, ls_igst_leg_pay,ls_sund_pay, ls_cgst_leg_rec
string ls_cgstrec_gl,ls_cgstrec_sgl,ls_cgstpay_gl,ls_cgstpay_sgl, ls_sgstrec_gl,ls_sgstrec_sgl,ls_sgstpay_gl,ls_sgstpay_sgl,  ls_igstrec_gl,ls_igstrec_sgl,ls_igstpay_gl,ls_igstpay_sgl, ls_sund_pay, ls_sunpay_gl, ls_sunpay_sgl
double ld_cgst_per, ld_sgst_per, ld_igst_per
end variables

on w_gteacf007gst.create
this.ddlb_14=create ddlb_14
this.ddlb_13=create ddlb_13
this.ddlb_12=create ddlb_12
this.ddlb_11=create ddlb_11
this.ddlb_10=create ddlb_10
this.ddlb_9=create ddlb_9
this.ddlb_8=create ddlb_8
this.st_9=create st_9
this.ddlb_7=create ddlb_7
this.ddlb_6=create ddlb_6
this.ddlb_5=create ddlb_5
this.em_7=create em_7
this.em_6=create em_6
this.st_8=create st_8
this.em_5=create em_5
this.em_4=create em_4
this.st_7=create st_7
this.ddlb_3=create ddlb_3
this.ddlb_4=create ddlb_4
this.ddlb_2=create ddlb_2
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.cb_2=create cb_2
this.ddlb_1=create ddlb_1
this.st_15=create st_15
this.st_6=create st_6
this.sle_4=create sle_4
this.sle_3=create sle_3
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.em_1=create em_1
this.em_2=create em_2
this.em_3=create em_3
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.Control[]={this.ddlb_14,&
this.ddlb_13,&
this.ddlb_12,&
this.ddlb_11,&
this.ddlb_10,&
this.ddlb_9,&
this.ddlb_8,&
this.st_9,&
this.ddlb_7,&
this.ddlb_6,&
this.ddlb_5,&
this.em_7,&
this.em_6,&
this.st_8,&
this.em_5,&
this.em_4,&
this.st_7,&
this.ddlb_3,&
this.ddlb_4,&
this.ddlb_2,&
this.st_5,&
this.st_4,&
this.st_3,&
this.cb_2,&
this.ddlb_1,&
this.st_15,&
this.st_6,&
this.sle_4,&
this.sle_3,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.em_1,&
this.em_2,&
this.em_3,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4}
end on

on w_gteacf007gst.destroy
destroy(this.ddlb_14)
destroy(this.ddlb_13)
destroy(this.ddlb_12)
destroy(this.ddlb_11)
destroy(this.ddlb_10)
destroy(this.ddlb_9)
destroy(this.ddlb_8)
destroy(this.st_9)
destroy(this.ddlb_7)
destroy(this.ddlb_6)
destroy(this.ddlb_5)
destroy(this.em_7)
destroy(this.em_6)
destroy(this.st_8)
destroy(this.em_5)
destroy(this.em_4)
destroy(this.st_7)
destroy(this.ddlb_3)
destroy(this.ddlb_4)
destroy(this.ddlb_2)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.ddlb_1)
destroy(this.st_15)
destroy(this.st_6)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.em_3)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event open;//setpointer(hourglass!)
//	ddlb_1.reset()
//	declare c1 cursor for
//	SELECT   initcap(em_emp_name)||' ('||em_emp_cd||')' Employee
//		 FROM FB_EMP  WHERE nvl(EM_LEFT_TAG,'N')='N' order by 1;
//			
//	open c1;
//	
//	IF sqlca.sqlcode = 0 THEN
//		fetch c1 into :ls_empid;
//		
//		do while sqlca.sqlcode <> 100
//			ddlb_1.additem(ls_empid)
//			fetch c1 into :ls_empid;
//		loop
//		close c1;
//	end if	

//select ACLEDGER_ID,ACLEDGER_MANID from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBCGSTR','ASCGSTR','TPCGSTR')
//select ACLEDGER_ID,ACLEDGER_MANID from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBSGSTR','ASSGSTR','TPSGSTR')
//
//select ACLEDGER_ID,ACLEDGER_MANID from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBIGSTR','ASIGSTR','TPIGSTR')
//
//
//select ACLEDGER_ID,ACLEDGER_MANID from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBCGSTP','ASCGSTP','TPCGSTP')
//
//select ACLEDGER_ID,ACLEDGER_MANID from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBSGSTP','ASSGSTP','TPSGSTP')
//
//select ACLEDGER_ID,ACLEDGER_MANID from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBIGSTP','ASIGSTP','TPIGSTP')

setpointer(arrow!)
	
em_1.text = string(gd_amount)


			
if gs_apr_ind ='Y' then
   cb_1.visible = false
end if


end event

type ddlb_14 from dropdownlistbox within w_gteacf007gst
integer x = 2286
integer y = 1164
integer width = 1161
integer height = 496
integer taborder = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_13 from dropdownlistbox within w_gteacf007gst
integer x = 2286
integer y = 1064
integer width = 1161
integer height = 496
integer taborder = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_12 from dropdownlistbox within w_gteacf007gst
integer x = 1115
integer y = 1064
integer width = 1161
integer height = 496
integer taborder = 150
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_11 from dropdownlistbox within w_gteacf007gst
integer x = 2286
integer y = 868
integer width = 1161
integer height = 496
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_10 from dropdownlistbox within w_gteacf007gst
integer x = 1115
integer y = 868
integer width = 1161
integer height = 496
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_9 from dropdownlistbox within w_gteacf007gst
integer x = 2286
integer y = 676
integer width = 1161
integer height = 496
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_8 from dropdownlistbox within w_gteacf007gst
integer x = 1115
integer y = 676
integer width = 1161
integer height = 496
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type st_9 from statictext within w_gteacf007gst
integer x = 539
integer y = 1164
integer width = 571
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "GST Sundry Payable :"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_7 from dropdownlistbox within w_gteacf007gst
integer x = 1115
integer y = 1164
integer width = 1161
integer height = 496
integer taborder = 150
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_6 from dropdownlistbox within w_gteacf007gst
integer x = 2286
integer y = 964
integer width = 1161
integer height = 496
integer taborder = 140
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_5 from dropdownlistbox within w_gteacf007gst
integer x = 1115
integer y = 964
integer width = 1161
integer height = 496
integer taborder = 130
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type em_7 from editmask within w_gteacf007gst
integer x = 736
integer y = 964
integer width = 370
integer height = 92
integer taborder = 120
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

type em_6 from editmask within w_gteacf007gst
integer x = 439
integer y = 964
integer width = 288
integer height = 92
integer taborder = 110
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

event modified;//	em_3.text = string(double(em_1.text) * ld_cgst_per / 100)
//	em_5.text = string(double(em_1.text) * ld_sgst_per / 100)
	em_7.text = string(double(em_1.text) * ld_igst_per / 100)
end event

type st_8 from statictext within w_gteacf007gst
integer x = 37
integer y = 964
integer width = 370
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "IGST :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_5 from editmask within w_gteacf007gst
integer x = 736
integer y = 772
integer width = 370
integer height = 92
integer taborder = 80
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

type em_4 from editmask within w_gteacf007gst
integer x = 439
integer y = 772
integer width = 288
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

event modified;//	em_3.text = string(double(em_1.text) * ld_cgst_per / 100)
	em_5.text = string(double(em_1.text) * ld_sgst_per / 100)
//	em_7.text = string(double(em_1.text) * ld_igst_per / 100)
end event

type st_7 from statictext within w_gteacf007gst
integer x = 37
integer y = 772
integer width = 370
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "UT/SGST :"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gteacf007gst
integer x = 1115
integer y = 772
integer width = 1161
integer height = 496
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_4 from dropdownlistbox within w_gteacf007gst
integer x = 2286
integer y = 772
integer width = 1161
integer height = 496
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type ddlb_2 from dropdownlistbox within w_gteacf007gst
integer x = 2286
integer y = 580
integer width = 1161
integer height = 496
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type st_5 from statictext within w_gteacf007gst
integer x = 2286
integer y = 496
integer width = 402
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Payment Ledger"
boolean focusrectangle = false
end type

type st_4 from statictext within w_gteacf007gst
integer x = 1115
integer y = 496
integer width = 402
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Receving Ledger"
boolean focusrectangle = false
end type

type st_3 from statictext within w_gteacf007gst
integer x = 736
integer y = 496
integer width = 352
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Amount (Rs)"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteacf007gst
integer x = 1719
integer y = 1288
integer width = 251
integer height = 104
integer taborder = 170
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
end type

event clicked;gb_retvalg = false
Close(parent)
end event

type ddlb_1 from dropdownlistbox within w_gteacf007gst
integer x = 1115
integer y = 580
integer width = 1161
integer height = 496
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
boolean allowedit = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_name,ls_ty,ls_pfno

ls_empid = left(right(ddlb_1.text,8),7);

SELECT  distinct  EM_EMP_NAME, EM_POSITION EMP_TYPE, EM_PF_CODE into :ls_name,:ls_ty,:ls_pfno
  FROM FB_EMP
WHERE EM_EMP_CD=:ls_empid and EM_PF_CODE IS NOT NULL ;
	 
if sqlca.sqlcode = -1 then
   messagebox('Error During Select Of Employee details',sqlca.sqlerrtext)
   return 1
end if	


sle_4.text=ls_ty;	
sle_3.text=ls_pfno;

end event

type st_15 from statictext within w_gteacf007gst
integer x = 434
integer y = 496
integer width = 288
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "%Age"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_gteacf007gst
integer x = 37
integer y = 580
integer width = 370
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "CGST :"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_4 from singlelineedit within w_gteacf007gst
integer x = 832
integer y = 248
integer width = 1627
integer height = 188
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

type sle_3 from singlelineedit within w_gteacf007gst
integer x = 2121
integer y = 148
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 16777215
integer limit = 256
borderstyle borderstyle = stylelowered!
end type

event modified;ls_hsn_no = trim(sle_3.text)
if isnull(gs_party_gstin) then gs_party_gstin = 'X'
if isnull(gs_party_gstin_stcd) then gs_party_gstin_stcd = 'X'
//gs_gstn_stcd,gs_gstnno

if gs_party_gstin <> gs_gstnno then
	select HM_HSN_DESC, nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ls_hsn_desc, :ld_cgst_per, :ld_sgst_per, :ld_igst_per
	from fb_hsn_master where HM_HSN_code = :ls_hsn_no and trunc(:gd_date) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
	if sqlca.sqlcode = -1 then 
		messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
		return 1
	elseif sqlca.sqlcode = 100 then 
		messagebox('Error','Item HSN Code/Rate Is Missing, Please Check !!!')
		return 1
	end if;	
	if gs_gstn_stcd = gs_party_gstin_stcd then
		setnull(ls_cgstrec_gl); setnull(ls_cgstrec_sgl); setnull(ls_cgstpay_gl); setnull(ls_cgstpay_sgl); setnull(ls_sgstrec_gl); setnull(ls_sgstrec_sgl); setnull(ls_sgstpay_gl); setnull(ls_sgstpay_sgl); setnull(ls_sund_pay);
		ld_igst_per = 0;
		if gs_revchg_ind = 'Y' then		
			if gs_revcatg = 'I' then
	
				select ACLEDGER_MANID||' ('||DR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||DR_ACSUBLEDGER_ID||')' into :ls_cgstrec_gl,:ls_cgstrec_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where DR_ACLEDGER_ID = a.acledger_id and DR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'CGST RECOVERABLE';
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting CGST Recoverable GL : '+sqlca.sqlerrtext)
					return 1
				end if
				select ACLEDGER_MANID||' ('||CR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||CR_ACSUBLEDGER_ID||')'  into :ls_cgstpay_gl,:ls_cgstpay_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where CR_ACLEDGER_ID = a.acledger_id and CR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'CGST PAYABLE';				
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting CGST Payable GL : '+sqlca.sqlerrtext)
					return 1
				end if
				select ACLEDGER_MANID||' ('||DR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||DR_ACSUBLEDGER_ID||')' into :ls_sgstrec_gl,:ls_sgstrec_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where DR_ACLEDGER_ID = a.acledger_id and DR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'SGST RECOVERABLE';
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting SGST Recoverable GL : '+sqlca.sqlerrtext)
					return 1
				end if
						
				select ACLEDGER_MANID||' ('||CR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||CR_ACSUBLEDGER_ID||')'  into :ls_sgstpay_gl,:ls_sgstpay_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where CR_ACLEDGER_ID = a.acledger_id and CR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'SGST PAYABLE';				
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting SGST Payable GL : '+sqlca.sqlerrtext)
					return 1
				end if				
			elseif gs_revcatg = 'N' then
//				if gs_gstn_stcd = '19' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBCGSTP'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBSGSTP'); 
//				elseif gs_gstn_stcd = '18' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 	
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('ASCGSTP'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('ASSGSTP'); 			
//				elseif gs_gstn_stcd = '16' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TPCGSTP'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TPSGSTP'); 
//				end if				
			end if	//if gs_revcatg = 'I' then
		else
			if gs_revcatg = 'I' then

				select ACLEDGER_MANID||' ('||DR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||DR_ACSUBLEDGER_ID||')' into :ls_cgstrec_gl,:ls_cgstrec_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where DR_ACLEDGER_ID = a.acledger_id and DR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'CGST RECOVERABLE';
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting CGST Recoverable GL : '+sqlca.sqlerrtext)
					return 1
				end if
				select ACLEDGER_MANID||' ('||DR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||DR_ACSUBLEDGER_ID||')' into :ls_sgstrec_gl,:ls_sgstrec_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where DR_ACLEDGER_ID = a.acledger_id and DR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'SGST RECOVERABLE';
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting SGST Recoverable GL : '+sqlca.sqlerrtext)
					return 1
				end if
				select ACLEDGER_MANID||' ('||CR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||CR_ACSUBLEDGER_ID||')'  into :ls_sunpay_gl,:ls_sunpay_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where CR_ACLEDGER_ID = a.acledger_id and CR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'SUNDRY CREDITORS GST PAYABLE';				
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting Sundry Payable GL : '+sqlca.sqlerrtext)
					return 1
				end if
			elseif gs_revcatg = 'N' then
//				if gs_gstn_stcd = '19' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sund_pay FROM fb_acautoeffect a, fb_acledger b WHERE a.ACLEDGER_ID = b.ACLEDGER_ID  and MANUAL_LEDGER in('SNDPAY'); 
//				elseif gs_gstn_stcd = '18' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 	
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sund_pay FROM fb_acautoeffect a, fb_acledger b WHERE a.ACLEDGER_ID = b.ACLEDGER_ID  and MANUAL_LEDGER in('SNDPAY'); 
//				elseif gs_gstn_stcd = '16' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_cgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sgst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sund_pay FROM fb_acautoeffect a, fb_acledger b WHERE a.ACLEDGER_ID = b.ACLEDGER_ID  and MANUAL_LEDGER in('SNDPAY'); 
//				end if						
			end if //if gs_revcatg = 'I' then
		end if //if gs_revchg_ind = 'Y' then	
		ddlb_1.text = ls_cgstrec_gl
		ddlb_2.text = ls_cgstpay_gl
		ddlb_8.text = ls_cgstrec_sgl
		ddlb_9.text = ls_cgstpay_sgl
		ddlb_3.text = ls_sgstrec_gl
		ddlb_4.text = ls_sgstpay_gl	
		ddlb_10.text = ls_sgstrec_sgl
		ddlb_11.text = ls_sgstpay_sgl	
		//ddlb_7.text = ls_sunpay_gl
		//ddlb_14.text = ls_sunpay_sgl	
		ddlb_7.text = gs_party_gl
		ddlb_14.text = gs_party_sgl		
	elseif gs_gstn_stcd <> gs_party_gstin_stcd then
		setnull(ls_igstrec_gl); setnull(ls_igstrec_sgl); setnull(ls_igstpay_gl); setnull(ls_igstpay_sgl); setnull(ls_sunpay_gl); setnull(ls_sunpay_sgl);
		ld_cgst_per = 0; ld_sgst_per = 0;
		if gs_revchg_ind = 'Y' then	
			if gs_revcatg = 'I' then
				select ACLEDGER_MANID||' ('||DR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||DR_ACSUBLEDGER_ID||')' into :ls_igstrec_gl,:ls_igstrec_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where DR_ACLEDGER_ID = a.acledger_id and DR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'IGST RECOVERABLE';
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting IGST Recoverable GL : '+sqlca.sqlerrtext)
					return 1
				end if
				select ACLEDGER_MANID||' ('||CR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||CR_ACSUBLEDGER_ID||')'  into :ls_igstpay_gl,:ls_igstpay_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where CR_ACLEDGER_ID = a.acledger_id and CR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'IGST PAYABLE';				
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting IGST Payable GL : '+sqlca.sqlerrtext)
					return 1
				end if				
			elseif gs_revcatg = 'N' then
//				if gs_gstn_stcd = '19' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('WBIGSTP'); 
//				elseif gs_gstn_stcd = '18' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('ASIGSTP'); 	
//				elseif gs_gstn_stcd = '16' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_pay from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TPIGSTP'); 
//				end if					
			end if //if gs_revcatg = 'I' then
		else
			if gs_revcatg = 'I' then
				select ACLEDGER_MANID||' ('||DR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||DR_ACSUBLEDGER_ID||')' into :ls_igstrec_gl,:ls_igstrec_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where DR_ACLEDGER_ID = a.acledger_id and DR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'IGST RECOVERABLE';
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting IGST Recoverable GL : '+sqlca.sqlerrtext)
					return 1
				end if
				select ACLEDGER_MANID||' ('||CR_ACLEDGER_ID||')' , ACSUBLEDGER_MANID||' ('||CR_ACSUBLEDGER_ID||')'  into :ls_sunpay_gl,:ls_sunpay_sgl from fb_acautoprocess, fb_acledger a, fb_acsubledger b 
				where CR_ACLEDGER_ID = a.acledger_id and CR_ACSUBLEDGER_ID = acsubledger_id and AC_PROCESS = 'GST TO ACCOUNT' and AC_PROCESS_DETAIL = 'SUNDRY CREDITORS GST PAYABLE';				
				if sqlca.sqlcode = -1 then 
					messagebox('Sql Error','Error During Getting Sundry Payable GL : '+sqlca.sqlerrtext)
					return 1
				end if				

			elseif gs_revcatg = 'N' then
//				if gs_gstn_stcd = '19' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sund_pay FROM fb_acautoeffect a, fb_acledger b WHERE a.ACLEDGER_ID = b.ACLEDGER_ID  and MANUAL_LEDGER in('SNDPAY');  
//				elseif gs_gstn_stcd = '18' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sund_pay FROM fb_acautoeffect a, fb_acledger b WHERE a.ACLEDGER_ID = b.ACLEDGER_ID  and MANUAL_LEDGER in('SNDPAY');  	
//				elseif gs_gstn_stcd = '16' then 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_igst_leg_rec from fb_acautoeffect a, fb_acledger b where a.ACLEDGER_ID = b.ACLEDGER_ID and MANUAL_LEDGER in ('TRANRENTRATES'); 
//					select ACLEDGER_MANID||' ('||a.ACLEDGER_ID||')' into :ls_sund_pay FROM fb_acautoeffect a, fb_acledger b WHERE a.ACLEDGER_ID = b.ACLEDGER_ID  and MANUAL_LEDGER in('SNDPAY'); 
//				end if					
			end if //if gs_revcatg = 'I' then
		end if //if gs_revchg_ind = 'Y' then
		ddlb_5.text = ls_igstrec_gl
		ddlb_6.text = ls_igstpay_gl
		ddlb_12.text = ls_igstrec_sgl
		ddlb_13.text = ls_igstpay_sgl
		//ddlb_7.text = ls_sunpay_gl
		//ddlb_14.text = ls_sunpay_sgl	
		ddlb_7.text = gs_party_gl
		ddlb_14.text = gs_party_sgl		
	end if
	
	sle_4.text = ls_hsn_desc
	em_2.text = string(ld_cgst_per)
	em_4.text = string(ld_sgst_per)
	em_6.text = string(ld_igst_per)
	em_3.text = string(double(em_1.text) * ld_cgst_per / 100)
	em_5.text = string(double(em_1.text) * ld_sgst_per / 100)
	em_7.text = string(double(em_1.text) * ld_igst_per / 100)
end if

end event

type cb_1 from commandbutton within w_gteacf007gst
integer x = 1440
integer y = 1288
integer width = 251
integer height = 104
integer taborder = 160
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "OK"
end type

event clicked;gb_retvalg 			= true
gs_hsn_cd			=	sle_3.text
gs_CGST_RECGL	=	left(right(ddlb_1.text,8),7)
gs_SGST_RECGL	=	left(right(ddlb_3.text,8),7)
gs_IGST_RECGL	=	left(right(ddlb_5.text,8),7)
gs_CGST_PAYGL	=	left(right(ddlb_2.text,8),7)
gs_SGST_PAYGL	=	left(right(ddlb_4.text,8),7)
gs_IGST_PAYGL	=	left(right(ddlb_6.text,8),7)
gs_GST_SUNDRY_PAY	=	left(right(ddlb_7.text,8),7)

gs_CGST_RECSGL	=	left(right(ddlb_8.text,9),8)//+Space(10 - Len(left(right(ddlb_8.text,10),9)))
gs_SGST_RECSGL	=	left(right(ddlb_10.text,9),8)//+Space(10 - Len(left(right(ddlb_10.text,10),9)))
gs_IGST_RECSGL =  left(right(ddlb_12.text,9),8)//+Space(10 - Len(left(right(ddlb_12.text,10),9)))
gs_CGST_PAYSGL	=	left(right(ddlb_9.text,9),8)//+Space(10 - Len(left(right(ddlb_9.text,10),9)))
gs_SGST_PAYSGL =	left(right(ddlb_11.text,9),8)//+Space(10 - Len(left(right(ddlb_11.text,10),9)))
gs_IGST_PAYSGL = left(right(ddlb_13.text,9),8)//+Space(10 - Len(left(right(ddlb_13.text,10),9)))
gs_GST_SUNDRY_PAYSGL = left(right(ddlb_14.text,10),9)+Space(10 - Len(left(right(ddlb_14.text,10),9)))

gd_BILL_AMT		=	double(em_1.text);
gd_CGST_PRCNT	=	double(em_2.text);
gd_SGST_PRCNT	=	double(em_4.text);
gd_IGST_PRCNT	=	double(em_6.text);
gd_CGST_AMT		=	double(em_3.text);
gd_SGST_AMT		=	double(em_3.text);
gd_IGST_AMT		=	double(em_7.text);

close(parent)


end event

type st_2 from statictext within w_gteacf007gst
integer x = 1705
integer y = 148
integer width = 398
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "SAC / HSN No :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteacf007gst
integer x = 832
integer y = 148
integer width = 238
integer height = 92
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Amount :"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gteacf007gst
integer x = 1093
integer y = 148
integer width = 576
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##,##,##,##,##0.00"
end type

type em_2 from editmask within w_gteacf007gst
integer x = 439
integer y = 580
integer width = 288
integer height = 92
integer taborder = 30
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

event modified;	em_3.text = string(double(em_1.text) * ld_cgst_per / 100)
//	em_5.text = string(double(em_1.text) * ld_sgst_per / 100)
//	em_7.text = string(double(em_1.text) * ld_igst_per / 100)
end event

type em_3 from editmask within w_gteacf007gst
integer x = 736
integer y = 580
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
borderstyle borderstyle = stylelowered!
string mask = "#,##0.00"
end type

type ln_1 from line within w_gteacf007gst
long linecolor = 33554432
integer linethickness = 5
integer beginx = 23
integer beginy = 12
integer endx = 3566
integer endy = 12
end type

type ln_2 from line within w_gteacf007gst
long linecolor = 33554432
integer linethickness = 5
integer beginx = 23
integer beginy = 1428
integer endx = 3561
integer endy = 1428
end type

type ln_3 from line within w_gteacf007gst
long linecolor = 33554432
integer linethickness = 4
integer beginx = 23
integer beginy = 16
integer endx = 23
integer endy = 1432
end type

type ln_4 from line within w_gteacf007gst
long linecolor = 33554432
integer linethickness = 4
integer beginx = 3561
integer beginy = 16
integer endx = 3561
integer endy = 1432
end type

