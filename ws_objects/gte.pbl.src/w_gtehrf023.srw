$PBExportHeader$w_gtehrf023.srw
forward
global type w_gtehrf023 from window
end type
type st_2 from statictext within w_gtehrf023
end type
type st_1 from statictext within w_gtehrf023
end type
type ddlb_1 from dropdownlistbox within w_gtehrf023
end type
type cb_2 from commandbutton within w_gtehrf023
end type
type cb_1 from commandbutton within w_gtehrf023
end type
end forward

global type w_gtehrf023 from window
integer width = 1810
integer height = 1272
boolean titlebar = true
string title = "(w_gtehrf023) Process-Arrear"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
end type
global w_gtehrf023 w_gtehrf023

type variables
string ls_afs_id,ls_ap_id,ls_frdt, ls_todt, ls_temp, ls_temp_ind, ls_emp_id
double ld_totamt, ld_pf,ld_fpf, ld_workdays, ld_matdays, ld_sickwagesdays, ld_hajiradays, ld_holidaypaydays
long ll_user_level
end variables

on w_gtehrf023.create
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.st_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_1}
end on

on w_gtehrf023.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;
if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if

declare c1 cursor for
select to_char(ap_startdate,'dd/mm/yyyy')||' - '|| to_char(ap_ENDDATE,'dd/mm/yyyy')||'   '||ap_id 
from fb_emp_arrearperiod where nvl(ap_confirm, 0) = 0
order by  ap_startdate desc;

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error At Cursor','Error During Opening Cursor');
	return 1;
else
	setnull(ls_frdt);
	fetch c1 into :ls_frdt;	
	do while sqlca.sqlcode <> 100 
	
		ddlb_1.additem(ls_frdt);
	
		setnull(ls_frdt);
		fetch c1 into :ls_frdt;	
	loop
	close c1;
end if;

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level = 3 then
	cb_1.enabled = false
end if

end event

type st_2 from statictext within w_gtehrf023
integer x = 581
integer y = 132
integer width = 517
integer height = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Process Arrear"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtehrf023
integer x = 82
integer y = 420
integer width = 402
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Arrear Period : "
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtehrf023
integer x = 489
integer y = 404
integer width = 1166
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
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtehrf023
integer x = 987
integer y = 612
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

type cb_1 from commandbutton within w_gtehrf023
integer x = 471
integer y = 612
integer width = 485
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Calculate Arrear"
boolean default = true
end type

event clicked;ls_frdt = left(ddlb_1.text,10)
ls_todt = mid(ddlb_1.text,14,10) 
ls_temp =  right(ddlb_1.text,12)

if isnull(ls_frdt) then 
	messagebox('Error At Date','Period Start Date Should Be Entered, Please Check !!!')
	return 1
end if;

select ap_confirm into :ls_temp_ind from fb_emp_arrearperiod where ap_id = :ls_temp;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while checking Arrear Period Details')
	return 1;
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No such period found')
	return 1;
end if 
 
 
if ls_temp_ind = '1' then
	if ll_user_level = 1 then	
		if messagebox('Arrear Period Select ','The arrear against this period has been already calculated, Would You Like to Recalculate the Arrear',question!,yesno!,1) = 1 then
			update fb_emp_arrearperiod set ap_confirm='0' where ap_id = :ls_temp;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Arrear Period (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if
			
			delete from fb_emparrear where ap_id = :ls_temp;
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Employee Arrear Delete',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if;	
		else
			return 1
		end if
	else
		messagebox('Arrear Period Select ','The arrear against this period has been already calculated, You can not Recalculate the Arrear, Please Contact "Admin User"',information!)
		return 1
	end if
end if 


SetPointer(HourGlass!);


declare c1 cursor for 
	
	select c.emp_id, round(sum((((EI_NEW_BASIC - EI_OLD_BASIC)+(EI_NEW_VDA - EI_OLD_VDA)+(EI_NEW_DA - EI_OLD_DA)) * (EP_BASICAMOUNT / EI_OLD_BASIC))),2) arrear_amt,  round(sum((((EI_NEW_BASIC - EI_OLD_BASIC)+(EI_NEW_VDA - EI_OLD_VDA)+(EI_NEW_DA - EI_OLD_DA)) * (EP_BASICAMOUNT / EI_OLD_BASIC)) * (pf_rate/100)),2) pf_amt,
		0 fpf_amt, ap_id
	from fb_emp_arrearperiod a, fb_emp_inc b, fb_employee c, fb_emppayment d, (select sum(PD_VALUE) pf_rate from fb_param_detail where PD_DESC in ('FPF RATE', 'PF RATE') and PD_PERIOD_TO is null) 
	where a.ap_inc_date = b.ei_date and b.ei_emp_id = c.emp_id and c.emp_id = d.emp_id  and nvl(ap_confirm,0) = 0 and a.ap_id = :ls_temp and 
		to_date(EP_YEAR || EP_MONTH,'yyyymm') between ap_startdate and ap_enddate
	group by c.emp_id, ap_id;

open c1; 

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
	rollback using sqlca; 
	return -1; 
else
	setnull(ls_emp_id); ld_totamt = 0;  ld_pf = 0; ld_fpf = 0; setnull(ls_ap_id); 
	
	fetch c1 into :ls_emp_id, :ld_totamt, :ld_pf, :ld_fpf, :ls_ap_id;
	
	if sqlca.sqlcode = -1 then 
		messagebox('Error','Error occured while fetching first record : '+sqlca.sqlerrtext)
		return 1;
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning','No records found for processing')
		return 1;		
	end if
	
	do while sqlca.sqlcode <> 100 
		
		insert into fb_emparrear (EMP_ID, EA_AMOUNT, EA_PF, EA_FPF, AP_ID, EA_VOU_NO, EA_VOU_DT, AP_ENTRY_BY, AP_ENTRY_DT) 
		values(:ls_emp_id,:ld_totamt,:ld_pf, :ld_fpf, :ls_ap_id, null, null, :gs_user, sysdate);
		if sqlca.sqlcode = -1 then
			messagebox('Error occured while inserting records',sqlca.sqlerrtext)
			rollback using sqlca ;
			return 1;
		end if 
		
		setnull(ls_emp_id); ld_totamt = 0;  ld_pf = 0; ld_fpf = 0; setnull(ls_ap_id); 
		
		fetch c1 into :ls_emp_id, :ld_totamt, :ld_pf, :ld_fpf, :ls_ap_id;			
	loop
	
	update fb_emp_arrearperiod set ap_confirm = '1' where ap_id = :ls_temp;
	if sqlca.sqlcode = -1 then
		messagebox('Error occured while updating Arrear Period',sqlca.sqlerrtext)
		rollback using sqlca ;
		return 1;
	end if 
	
	commit using sqlca;
	
end if 
	
messagebox('Confirmation','The Arrear Has Been Sucessfully Calculated, Please Check....!',information!)

SetPointer(Arrow!);
end event

