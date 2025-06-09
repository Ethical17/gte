$PBExportHeader$w_gtelaf002a.srw
forward
global type w_gtelaf002a from window
end type
type st_2 from statictext within w_gtelaf002a
end type
type ddlb_2 from dropdownlistbox within w_gtelaf002a
end type
type ddlb_1 from dropdownlistbox within w_gtelaf002a
end type
type cb_2 from commandbutton within w_gtelaf002a
end type
type cb_1 from commandbutton within w_gtelaf002a
end type
type st_1 from statictext within w_gtelaf002a
end type
end forward

global type w_gtelaf002a from window
integer width = 3127
integer height = 1092
boolean titlebar = true
string title = "(w_gtelaf002a) Promote To Staff & SubStaff"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
st_2 st_2
ddlb_2 ddlb_2
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_gtelaf002a w_gtelaf002a

type variables
string ls_temp,ls_frdt,ls_todt,ls_chklwf, ls_lwwid,ls_lwwpaidflag, ls_emp,ls_grade
double ld_lwf, ld_subs
long ll_user_level
end variables

on w_gtelaf002a.create
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.st_2,&
this.ddlb_2,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_gtelaf002a.destroy
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;setpointer(hourglass!)
//if f_openwindow(dw_1) = -1 then	
//	close(this)
//	return 1
//end if
if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if

declare c1 cursor for
select initcap(EMP_NAME)||' ('||EMP_ID||')' EMP_NAME from fb_employee 
where nvl(emp_inactivetype,'Regular') in ('Regular','Transfer') and nvl(EMP_ACTIVE,'1') = '1' and EMP_TYPE in ('LP','LT','LO');

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_emp);
	fetch c1 into :ls_emp;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_emp);
	
		setnull(ls_emp);
		fetch c1 into :ls_emp;	
	loop
	close c1;
end if;

setpointer(arrow!)

//messagebox('11',string(ll_user_level))

//this.tag = Message.StringParm
//ll_user_level = long(this.tag)

if gl_temp = 1 then
	cb_1.enabled = true
end if

end event

type st_2 from statictext within w_gtelaf002a
integer x = 1687
integer y = 252
integer width = 210
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Grade"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gtelaf002a
integer x = 1938
integer y = 236
integer width = 736
integer height = 368
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Staff","Sub Staff"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_gtelaf002a
integer x = 343
integer y = 236
integer width = 1147
integer height = 584
integer taborder = 10
integer textsize = -9
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

type cb_2 from commandbutton within w_gtelaf002a
integer x = 2327
integer y = 696
integer width = 311
integer height = 112
integer taborder = 40
integer textsize = -9
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

type cb_1 from commandbutton within w_gtelaf002a
integer x = 1998
integer y = 696
integer width = 320
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Upgrade"
boolean default = true
end type

event clicked;ls_emp = left(right(ddlb_1.text,8),7)

if isnull(ls_emp) then
	messagebox('Warning !','Please Select A Employee, Please Check !!!')
	return 1
end if;

if isnull(ddlb_1.text) then 
	messagebox('Warning !','Please Select A Grade, Please Check !!!')
	return 1
end if;

IF MessageBox("Save  Alert", 'Do You Want To Continue ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	ls_grade = trim(ddlb_2.text)
	
	
	update fb_employee set emp_grade = decode(ls_grade,'Staff','ST','SS')
	where emp_id = :ls_emp;
	
	if sqlca.sqlcode = -1 then
		messagebox('SQL ERROR: During Update Grade ',sqlca.sqlerrtext)
		return 1
	end if;	

	messagebox('Confirmation','The wages Has Been Sucessfully Calculate, Please Check....!',information!)
else
	return 1
end if
end event

type st_1 from statictext within w_gtelaf002a
integer x = 59
integer y = 252
integer width = 242
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Employee"
alignment alignment = right!
boolean focusrectangle = false
end type

