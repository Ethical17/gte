$PBExportHeader$w_gtehrf008.srw
forward
global type w_gtehrf008 from window
end type
type cbx_2 from checkbox within w_gtehrf008
end type
type cbx_1 from checkbox within w_gtehrf008
end type
type em_1 from editmask within w_gtehrf008
end type
type cb_2 from commandbutton within w_gtehrf008
end type
type cb_1 from commandbutton within w_gtehrf008
end type
type st_1 from statictext within w_gtehrf008
end type
end forward

global type w_gtehrf008 from window
integer width = 1792
integer height = 1020
boolean titlebar = true
string title = "(w_gtehrf008) Process-Payroll Calculation"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean center = true
cbx_2 cbx_2
cbx_1 cbx_1
em_1 em_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
end type
global w_gtehrf008 w_gtehrf008

type variables
string ls_temp,ls_frdt,ls_chklwf,ls_empid, ls_name,ls_chkration, ls_calflag
long ll_days, ll_cnt, ll_actworkdays,ll_attendays, ll_user_level
date ld_stdt,ld_enddt
end variables

on w_gtehrf008.create
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.em_1=create em_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.cbx_2,&
this.cbx_1,&
this.em_1,&
this.cb_2,&
this.cb_1,&
this.st_1}
end on

on w_gtehrf008.destroy
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
end on

event open;
if date(gd_dt) <> today() then
	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
	return 1
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level = 3 then
	cb_1.enabled = false
end if

if gs_garden_snm = 'MT' then
	cbx_2.visible = false
end if
end event

type cbx_2 from checkbox within w_gtehrf008
integer x = 517
integer y = 396
integer width = 549
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
string text = "Calculate Ration"
end type

type cbx_1 from checkbox within w_gtehrf008
integer x = 517
integer y = 284
integer width = 425
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
boolean enabled = false
string text = "Deduction LWF"
end type

type em_1 from editmask within w_gtehrf008
integer x = 1070
integer y = 140
integer width = 251
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
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

event modified;if right(em_1.text,2) = '06' or right(em_1.text,2) = '12' then
	cbx_1.enabled = true
	cbx_1.checked = true
else
	cbx_1.enabled = false
	cbx_1.checked = false
end if
end event

type cb_2 from commandbutton within w_gtehrf008
integer x = 1019
integer y = 516
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

type cb_1 from commandbutton within w_gtehrf008
integer x = 338
integer y = 516
integer width = 622
integer height = 112
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Payment Calculation"
boolean default = true
end type

event clicked;SetPointer(HourGlass!);
 n_wagept luo_wagept
 luo_wagept = Create n_wagept


ls_frdt = em_1.text

if len(ls_frdt) <> 6 or isnull(ls_frdt) then 
	messagebox('Error At Date','Year/Month Should Be Entered')
	return 1
end if;

select to_number(to_char(last_day(trunc(to_date(:ls_frdt,'yyyymm'))),'dd')), trunc(to_date(:ls_frdt,'yyyymm')), last_day(trunc(to_date(:ls_frdt,'yyyymm')))  
into :ll_days, :ld_stdt, :ld_enddt from dual;

if sqlca.sqlcode = -1 then 
	messagebox('Sql Error','Error During Calculating Working Days In a Month : '+sqlca.sqlerrtext)
	return 1
end if
		
//ll_cnt  = f_count_weekends(ld_stdt,ld_enddt)

//ll_actworkdays = ll_days - ll_cnt

DECLARE c1 CURSOR FOR  
select EMP_ID, EMP_NAME from fb_employee where nvl(emp_inactivetype,'Regular') in ('Regular','Transfer') and nvl(EMP_ACTIVE,'1') = '1' and 
		EMP_TYPE not in ('LP','LT','LO','EXE')
order by 2;

open c1;
	
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_empid,:ls_name;
	
	do while sqlca.sqlcode <> 100
		
		select count(EATTEN_STATUS) into :ll_attendays from fb_empattendance	where EMP_ID = :ls_empid and to_char(EATTEN_DATE,'YYYYMM') = :ls_frdt;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Maternity Availed Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		if ll_attendays <> ll_days then
			messagebox('Warning!','Attendance Is Incomplete For The Employee '+ls_name + ' (' + ls_empid + ') For This Month, Please Check !!!')
			return 1
		end if
		
		fetch c1 into :ls_empid,:ls_name;
	loop
END IF
close c1;



//select distinct eps_paidflag  into :ls_temp from fb_emppaymentstatus
//where ((eps_year * 100) + eps_month) = to_char(add_months(to_date(:ls_frdt,'YYYYMM'),-1),'yyyymm');
//
//if sqlca.sqlcode = -1 then 
//	messagebox('Sql Error','Error During Checking Payment Indicator Previous Month : '+sqlca.sqlerrtext)
//	return 1
//end if
//
//if ls_temp = '0' Then
//	messagebox('Last Month Payment Pending','The payment for last month Is still pending, Please check Pay Last Month First...!')
//	return 1
//End If

setnull(ls_temp)

select distinct eps_paidflag  into :ls_temp from fb_emppaymentstatus where ((eps_year * 100) + eps_month) = :ls_frdt;
if sqlca.sqlcode = -1 then 
	messagebox('Sql Error','Error During Checking Payment Indicator Current Month : '+sqlca.sqlerrtext)
	return 1
end if

if ls_temp = '1' then
	messagebox('Payment Error','The Payment has already been paid against this month and year, Would You Like to Recalculate the Wages')
	return 1
end if

select distinct EPS_PAYCALFLAG  into :ls_calflag from fb_emppaymentstatus where ((eps_year * 100) + eps_month) = :ls_frdt;
if sqlca.sqlcode = -1 then 
	messagebox('Sql Error','Error During Checking Payment Indicator Current Month : '+sqlca.sqlerrtext)
	return 1
end if


if  ls_calflag = '1' Then
	if ll_user_level = 1 then	
		if messagebox('Payment Error','The Payment has already been calculated for this month and year, Would You Like to Recalculate',question!,yesno!,1) = 1 then
			update fb_emppaymentstatus set EPS_PAYCALFLAG ='0',eps_paidflag='0' where ((eps_year * 100) + eps_month) = :ls_frdt;
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Employee Payment Year Month (Update) ',sqlca.sqlerrtext); 
				rollback using sqlca; 
				return 1; 
			end if
			delete from fb_emppayment where ((ep_year * 100) + ep_month) = :ls_frdt;
			
			if sqlca.sqlcode = -1 then
				messagebox('SQL ERROR: During Employee Payment Delete',sqlca.sqlerrtext)
				return 1
			end if;	
		else
			return 1
		end if
	else
		messagebox('Wages Week Select ','The wages against this week has been already paid, You can not Recalculate the Wages, Please Contact "Admin User"',information!)
		return 1
	end if
end if	



if cbx_1.checked = true then
	ls_chklwf = 'Y'
else
	ls_chklwf = 'N'
end if

if cbx_2.checked = true then
	ls_chkration = 'Y'
else
	ls_chkration = 'N'
end if

if luo_wagept.wf_emp_wagecal(ls_frdt,ls_chklwf,ls_chkration) = -1 then 
	rollback using sqlca;
	return 1;
end if;

SetPointer(Arrow!);
end event

type st_1 from statictext within w_gtehrf008
integer x = 78
integer y = 144
integer width = 960
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
string text = "Payment For Year/Month [YYYYMM] :"
alignment alignment = right!
boolean focusrectangle = false
end type

