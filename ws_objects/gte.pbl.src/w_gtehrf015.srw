$PBExportHeader$w_gtehrf015.srw
forward
global type w_gtehrf015 from window
end type
type cbx_1 from checkbox within w_gtehrf015
end type
type cb_11 from commandbutton within w_gtehrf015
end type
type st_3 from statictext within w_gtehrf015
end type
type ddlb_2 from dropdownlistbox within w_gtehrf015
end type
type st_2 from statictext within w_gtehrf015
end type
type em_1 from editmask within w_gtehrf015
end type
type cb_7 from commandbutton within w_gtehrf015
end type
type cb_6 from commandbutton within w_gtehrf015
end type
type st_1 from statictext within w_gtehrf015
end type
type ddlb_1 from dropdownlistbox within w_gtehrf015
end type
type cb_4 from commandbutton within w_gtehrf015
end type
type cb_3 from commandbutton within w_gtehrf015
end type
type cb_2 from commandbutton within w_gtehrf015
end type
type dw_1 from datawindow within w_gtehrf015
end type
end forward

global type w_gtehrf015 from window
integer width = 4581
integer height = 2440
boolean titlebar = true
string title = "Employee Increment Entry Screen"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cbx_1 cbx_1
cb_11 cb_11
st_3 st_3
ddlb_2 ddlb_2
st_2 st_2
em_1 em_1
cb_7 cb_7
cb_6 cb_6
st_1 st_1
ddlb_1 ddlb_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_gtehrf015 w_gtehrf015

type variables
double ld_basic,ld_hra,ld_da,ld_vda,ld_basic_old,ld_inc_rt,ld_inc_rt_old,ld_last_inc_rt,ld_stbasic,ld_electric,ld_crvfpf,ld_fuel, ld_last_inc_per
long ll_noi,ll_user_level
string ls_emp_cd,ls_old_desg,ls_desg_cd,ls_inc_dt,ls_appr_ind, ls_emp_nm
boolean lb_query
double ld_da_rt,ld_vda_rt,ld_hra_rt
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

on w_gtehrf015.create
this.cbx_1=create cbx_1
this.cb_11=create cb_11
this.st_3=create st_3
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.em_1=create em_1
this.cb_7=create cb_7
this.cb_6=create cb_6
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cbx_1,&
this.cb_11,&
this.st_3,&
this.ddlb_2,&
this.st_2,&
this.em_1,&
this.cb_7,&
this.cb_6,&
this.st_1,&
this.ddlb_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_gtehrf015.destroy
destroy(this.cbx_1)
destroy(this.cb_11)
destroy(this.st_3)
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)


dw_1.settransobject(sqlca)
lb_query = false 
cb_3.enabled=false

em_1.text = '01/04/'+string(today(),'yyyy')

string ls_desg_name

ddlb_1.additem('ALL');

	declare c1 cursor for 
	select distinct EMP_GRADE desg_name from fb_employee where emp_type not in ('LP','LT','LO') and nvl(trim(EMP_INACTIVETYPE),'Regular') = 'Regular' and EMP_GRADE is not null	
	order by 1;	
	open c1;
	if sqlca.sqlcode=-1 then
		messagebox('Error during open cursor c1',sqlca.sqlerrtext) 
		return 1
	elseif sqlca.sqlcode=0 then	 
		setnull(ls_desg_name);
		fetch c1 into :ls_desg_name;
		
		do while sqlca.sqlcode<>100
	
			ddlb_1.additem(ls_desg_name);
	
			setnull(ls_desg_name);
			fetch c1 into :ls_desg_name;
		loop
		close c1;
	end if

ddlb_2.additem('ALL');

declare c2 cursor for 
	select distinct emp_id,(emp_name||'['||emp_id||']') name 
	  from fb_employee
	  where  emp_type not in ('LP','LT','LO') and nvl(trim(EMP_INACTIVETYPE),'Regular') = 'Regular'
	order by 1;

open c2;
if sqlca.sqlcode=-1 then
	messagebox('Error during open cursor c1',sqlca.sqlerrtext) 
	return 1
elseif sqlca.sqlcode=0 then	 
	setnull(ls_emp_cd);setnull(ls_desg_name);
	fetch c2 into :ls_emp_cd,:ls_desg_name;
	
	do while sqlca.sqlcode<>100

		ddlb_2.additem(ls_desg_name);

		setnull(ls_emp_cd);setnull(ls_desg_name);
		fetch c2 into :ls_emp_cd,:ls_desg_name;
	loop
	close c2;
end if

ddlb_1.text = 'ALL'
ddlb_2.text = 'ALL'
end event

type cbx_1 from checkbox within w_gtehrf015
integer x = 1920
integer y = 120
integer width = 398
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Un Approved"
end type

type cb_11 from commandbutton within w_gtehrf015
integer x = 3387
integer y = 8
integer width = 270
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;string ls_gaden_sname,ls_emp_id,ls_old_grade, ls_new_grade,ls_letter_type,ls_entry_by,ls_pst_ind
double ld_old_da_rt,ld_old_da,ld_old_vda_rt,ld_old_vda,ld_old_cvrforpf,	ld_old_hr_rt,ld_old_hr,ld_old_electric,ld_old_fuel,ld_old_basic,ld_new_da_rt,ld_new_da,ld_new_vda_rt,ld_new_vda,ld_new_cvrforpf,ld_new_hr_rt,ld_new_hr,ld_new_electric,ld_new_fuel,ld_new_basic,ld_last_inc_rate,ld_inc_rate,ld_adhoc
long	ll_noof_inc				  
datetime	 ld_date,ld_entry_dt,ld_last_prom				            
					   
setpointer(hourglass!)

if isnull(ddlb_1.text) or ddlb_1.text=""  then
	messagebox('Designation Selection Error','Please select Designation First')
	return
end if;

if isnull(ddlb_2.text) or ddlb_2.text=""  then
	messagebox('Employee Selection Error','Please select Employee Name First')
	return
end if;

if not isdate(em_1.text) then
	messagebox('Wrong Date','Please Select Inc. Date First !!!')
	return
end if;


ls_desg_cd = ddlb_1.text
ls_inc_dt = em_1.text
ls_emp_cd = left(right(ddlb_2.text,8),7)

setnull(ls_gaden_sname);setnull(ls_emp_id);setnull(ls_old_grade);setnull( ls_new_grade);setnull(ls_letter_type);setnull(ls_entry_by);setnull(ls_pst_ind);
ld_old_da_rt = 0;ld_old_da = 0;ld_old_vda_rt = 0;ld_old_vda = 0;ld_old_cvrforpf = 0;	ld_old_hr_rt = 0;ld_old_hr = 0;ld_old_electric = 0;
ld_old_fuel = 0;ld_old_basic = 0;ld_new_da_rt = 0;ld_new_da = 0;ld_new_vda_rt = 0;ld_new_vda = 0;ld_new_cvrforpf = 0;ld_new_hr_rt = 0;
ld_new_hr = 0;ld_new_electric = 0;ld_new_fuel = 0;ld_new_basic = 0;ld_last_inc_rate = 0;ld_inc_rate = 0;ld_adhoc = 0;ll_noof_inc = 0; ld_last_inc_per = 0;
setnull(ld_date);setnull(ld_entry_dt);setnull(ld_last_prom)
	
dw_1.reset()
dw_1.settransobject(sqlca)
	
	DECLARE c1 CURSOR FOR  
	  SELECT to_date(:ls_inc_dt,'dd/mm/yyyy'),:gs_garden_snm,EMP_ID,emp_name, EMP_GRADE,EAD_DA, round((EBS_BASICAMOUNT * (EAD_DA * 0.01)),0) , 
  			 EAD_VDA,round((EBS_BASICAMOUNT * (EAD_VDA * 0.01)),0) , EAD_CVRFORPF,  EAD_HR, round((EBS_BASICAMOUNT * (EAD_HR * 0.01)),0), 
			 EAD_ELECTRIC, EAD_FUEL,EBS_BASICAMOUNT,
	  		 EMP_GRADE, EAD_DA, round((EBS_BASICAMOUNT * (EAD_DA * 0.01)),0),EAD_VDA ,round((EBS_BASICAMOUNT * (EAD_VDA * 0.01)),0),
			 EAD_CVRFORPF, EAD_HR,round((EBS_BASICAMOUNT * (EAD_HR * 0.01)),0),  EAD_ELECTRIC, EAD_FUEL ,EBS_BASICAMOUNT,
			 0,lst_inc_rt,lst_inc_rt,last_inc_percent,0,'N',:gs_user,sysdate,EMP_PROMOTION_DT,'N'
		 FROM (select * from fb_employee where  
		 			emp_id = decode(nvl(:ls_emp_cd,'ALL'),'ALL',emp_id,:ls_emp_cd) and 
					trim(EMP_GRADE) = decode(nvl(:ls_desg_cd,'ALL'),'ALL',EMP_GRADE,:ls_desg_cd) and 
					emp_type in ('ST','SS','AT') and nvl(EMP_ACTIVE,'1') = '1'),
				(select EAD_GRADE,EAD_DA, EAD_VDA, EAD_CVRFORPF, EAD_HR, EAD_ELECTRIC, EAD_FUEL from fb_empallowancededuction where (EAD_GRADE,((nvl(EAD_YEAR,0) * 100) + nvl(EAD_MONTH,0))) in  (select EAD_GRADE,max((nvl(EAD_YEAR,0) * 100) + nvl(EAD_MONTH,0)) from fb_empallowancededuction group by EAD_GRADE)), 
				(select ei_emp_id emp_no, nvl(EI_INC_PERCENT,0) last_inc_percent, nvl(EI_INC_RATE,0) lst_inc_rt from fb_emp_inc where (ei_emp_id,ei_date) in (select ei_emp_id,max(ei_date) from fb_emp_inc group by ei_emp_id))
	  where EMP_ID = emp_no(+) and trim(EMP_GRADE) = trim(EAD_GRADE) and
			not exists (select * from fb_emp_inc where EI_EMP_ID = emp_id and EI_DATE >= to_date(:ls_inc_dt,'dd/mm/yyyy'));
			
	open c1;

	IF sqlca.sqlcode = 0 THEN
		fetch c1 into :ld_date,:ls_gaden_sname,:ls_emp_id,:ls_emp_nm,:ls_old_grade,:ld_old_da_rt,:ld_old_da,:ld_old_vda_rt,:ld_old_vda,:ld_old_cvrforpf,
					  	:ld_old_hr_rt,:ld_old_hr,:ld_old_electric,:ld_old_fuel,:ld_old_basic,
					   :ls_new_grade,:ld_new_da_rt,:ld_new_da,:ld_new_vda_rt,:ld_new_vda,:ld_new_cvrforpf,:ld_new_hr_rt,:ld_new_hr,
					   :ld_new_electric,:ld_new_fuel,:ld_new_basic,         
					   :ll_noof_inc,:ld_last_inc_rate,:ld_inc_rate,:ld_last_inc_per,:ld_adhoc,:ls_letter_type,:ls_entry_by,:ld_entry_dt,:ld_last_prom,:ls_pst_ind;
		
		do while sqlca.sqlcode <> 100			
			dw_1.scrolltorow(dw_1.insertrow(0))
			dw_1.setitem(dw_1.getrow(),'ei_date',ld_date)
			dw_1.setitem(dw_1.getrow(),'ei_gaden_sname',ls_gaden_sname)
			dw_1.setitem(dw_1.getrow(),'ei_emp_id',ls_emp_id)
			dw_1.setitem(dw_1.getrow(),'emp_name',ls_emp_nm)
			dw_1.setitem(dw_1.getrow(),'ei_old_grade',ls_old_grade)
			dw_1.setitem(dw_1.getrow(),'ei_old_da_rt',ld_old_da_rt)
			dw_1.setitem(dw_1.getrow(),'ei_old_da',ld_old_da)
			dw_1.setitem(dw_1.getrow(),'ei_old_vda_rt',ld_old_vda_rt)
			dw_1.setitem(dw_1.getrow(),'ei_old_vda',ld_old_vda)
			dw_1.setitem(dw_1.getrow(),'ei_old_cvrforpf',ld_old_cvrforpf)
			dw_1.setitem(dw_1.getrow(),'ei_old_hr_rt',ld_old_hr_rt)
			dw_1.setitem(dw_1.getrow(),'ei_old_hr',ld_old_hr)
			dw_1.setitem(dw_1.getrow(),'ei_old_electric',ld_old_electric)
			dw_1.setitem(dw_1.getrow(),'ei_old_fuel',ld_old_fuel)
			dw_1.setitem(dw_1.getrow(),'ei_old_basic',ld_old_basic)
			dw_1.setitem(dw_1.getrow(),'ei_new_grade',ls_new_grade)
			dw_1.setitem(dw_1.getrow(),'ei_new_da_rt',ld_new_da_rt)
			dw_1.setitem(dw_1.getrow(),'ei_new_da',ld_new_da)
			dw_1.setitem(dw_1.getrow(),'ei_new_vda_rt',ld_new_vda_rt)
			dw_1.setitem(dw_1.getrow(),'ei_new_vda',ld_new_vda)
			dw_1.setitem(dw_1.getrow(),'ei_new_cvrforpf',ld_new_cvrforpf)
			dw_1.setitem(dw_1.getrow(),'ei_new_hr_rt',ld_new_hr_rt)
			dw_1.setitem(dw_1.getrow(),'ei_new_hr',ld_new_hr)
			dw_1.setitem(dw_1.getrow(),'ei_new_electric',ld_new_electric)
			dw_1.setitem(dw_1.getrow(),'ei_new_fuel',ld_new_fuel)
			dw_1.setitem(dw_1.getrow(),'ei_new_basic',ld_new_basic)
			dw_1.setitem(dw_1.getrow(),'ei_noof_inc',ll_noof_inc)
			dw_1.setitem(dw_1.getrow(),'ei_last_inc_rate',ld_last_inc_rate)
			dw_1.setitem(dw_1.getrow(),'ei_inc_rate',ld_inc_rt)
			dw_1.setitem(dw_1.getrow(),'ei_oldinc_percent',ld_last_inc_per)			
			dw_1.setitem(dw_1.getrow(),'ei_adhoc',ld_adhoc)
			dw_1.setitem(dw_1.getrow(),'ei_letter_type',ls_letter_type)
			dw_1.setitem(dw_1.getrow(),'ei_entry_by',ls_entry_by)
			dw_1.setitem(dw_1.getrow(),'ei_entry_dt',ld_entry_dt)
			dw_1.setitem(dw_1.getrow(),'ei_last_prom',ld_last_prom)
			dw_1.setitem(dw_1.getrow(),'ei_pst_ind',ls_pst_ind)
			dw_1.setitem(dw_1.getrow(),'ei_logic_ind','AMOUNT')
			
			setnull(ls_gaden_sname);setnull(ls_emp_id);setnull(ls_old_grade);setnull( ls_new_grade);setnull(ls_letter_type);setnull(ls_entry_by);setnull(ls_pst_ind);
			ld_old_da_rt = 0;ld_old_da = 0;ld_old_vda_rt = 0;ld_old_vda = 0;ld_old_cvrforpf = 0;	ld_old_hr_rt = 0;ld_old_hr = 0;ld_old_electric = 0;
			ld_old_fuel = 0;ld_old_basic = 0;ld_new_da_rt = 0;ld_new_da = 0;ld_new_vda_rt = 0;ld_new_vda = 0;ld_new_cvrforpf = 0;ld_new_hr_rt = 0;
			ld_new_hr = 0;ld_new_electric = 0;ld_new_fuel = 0;ld_new_basic = 0;ld_last_inc_rate = 0;ld_inc_rate = 0;ld_adhoc = 0;ll_noof_inc = 0; ld_last_inc_per = 0;
			setnull(ld_date);setnull(ld_entry_dt);setnull(ld_last_prom);setnull(ls_emp_nm);

			fetch c1 into :ld_date,:ls_gaden_sname,:ls_emp_id,:ls_emp_nm,:ls_old_grade,:ld_old_da_rt,:ld_old_da,:ld_old_vda_rt,:ld_old_vda,:ld_old_cvrforpf,
					  	:ld_old_hr_rt,:ld_old_hr,:ld_old_electric,:ld_old_fuel,:ld_old_basic,
					   :ls_new_grade,:ld_new_da_rt,:ld_new_da,:ld_new_vda_rt,:ld_new_vda,:ld_new_cvrforpf,:ld_new_hr_rt,:ld_new_hr,
					   :ld_new_electric,:ld_new_fuel,:ld_new_basic,         
					   :ll_noof_inc,:ld_last_inc_rate,:ld_inc_rate,:ld_last_inc_per,:ld_adhoc,:ls_letter_type,:ls_entry_by,:ld_entry_dt,:ld_last_prom,:ls_pst_ind;
		loop
	END IF
	close c1;
end event

type st_3 from statictext within w_gtehrf015
integer x = 1998
integer y = 20
integer width = 320
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Emp Name:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gtehrf015
integer x = 2331
integer y = 12
integer width = 1042
integer height = 884
integer taborder = 30
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

type st_2 from statictext within w_gtehrf015
integer x = 23
integer y = 20
integer width = 274
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inc. Date:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtehrf015
integer x = 320
integer y = 4
integer width = 389
integer height = 100
integer taborder = 10
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

type cb_7 from commandbutton within w_gtehrf015
integer x = 855
integer y = 104
integer width = 320
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Letter-Print"
end type

event clicked;if isnull(ddlb_1.text) or ddlb_1.text="" then
	messagebox('Grade Selection Error','Please select Grade First')
	return
end if;

ls_desg_cd = ddlb_1.text
gs_inc_dt = em_1.text

setpointer(hourglass!)

string ls_desg

 DECLARE c1 CURSOR FOR  
  SELECT ei_old_grade, EI_EMP_ID
  FROM fb_emp_inc,fb_employee
  where ei_emp_id = emp_id and emp_type not in ('LP','LT','LO') and nvl(trim(EMP_INACTIVETYPE),'Regular') = 'Regular' and 
		  (ei_old_grade = :ls_desg_cd or :ls_desg_cd  = 'ALL') and ei_date = to_date(:gs_inc_dt,'dd/mm/yyyy') 
  order by 1,2;

open c1;
if sqlca.sqlcode = 0 then
	do while true
		setnull(gs_emp_id);setnull(ls_desg);
		fetch c1 into :ls_desg,:gs_emp_id;
		if sqlca.sqlcode <> 0 then exit
//			if ls_letter = 'P2' then
				opensheet(w_gtehrr008,w_mdi,1,layered!) 
				w_gtehrr008.dw_1.print();close(w_gtehrr008)
//			elseif ls_letter = 'I1' then
//				opensheet(w_pr_p3,w_mdi,1,layered!) 
//				w_pr_p3.dw_1.print();close(w_pr_p3)
//			elseif ls_letter= 'I2' then
//				opensheet(w_pr_p4,w_mdi,1,layered!) 
//				w_pr_p4.dw_1.print();close(w_pr_p4)
//			elseif ls_letter = 'I3' then
//				opensheet(w_pr_p5,w_mdi,1,layered!) 
//				w_pr_p5.dw_1.print();close(w_pr_p5)
//			elseif ls_letter = 'C1' then
//				opensheet(w_pr_p6,w_mdi,1,layered!) 
//				w_pr_p6.dw_1.print();close(w_pr_p6)
//			end if;
	loop
	close c1;
else	
	messagebox('SQL Error: During Open Cursor',sqlca.sqlerrtext)
	return 1
end if;

setpointer(arrow!)

end event

type cb_6 from commandbutton within w_gtehrf015
integer x = 1445
integer y = 104
integer width = 416
integer height = 100
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Final Approval"
end type

event clicked;string ls_emp_name,LS_ENTRY_DT,LS_APPROVED_DT,ls_desg_old,ls_cla_flag,ls_cla_old,ls_cla_new,ls_temp, ls_new_grade, ls_old_grade
long ll_repto,LL_ENTRY_BY,LL_APPROVED_BY
datetime ld_inc_date
//
select distinct 'x' into :ls_temp FROM fb_emp_inc WHERE nvl(EI_PST_IND,'N') = 'N' and ei_logic_ind = 'AMOUNT' ;
if sqlca.sqlcode = -1 then 
	messagebox('Error During Getting Record',sqlca.sqlerrtext)
	return 
elseif sqlca.sqlcode = 100 then 
	messagebox('Error','No Data Available For Processing')
	return 
else	
	
	if messagebox('Confirmation','Are You Sure To Run The Final Approval',question!,yesno!,1) = 2 then
		return
	end if
	
	if messagebox('Re-Confirmation','Are You Sure To Run The Final Approval ..............! ',question!,yesno!,1) = 2 then
		return
	end if
	
	setnull(ls_emp_cd); ld_basic = 0;
	setpointer(hourglass!)
	
	 DECLARE c1 CURSOR FOR  
		select EI_EMP_ID, EI_NEW_BASIC,EI_DATE, EI_NEW_GRADE, EI_OLD_GRADE from fb_emp_inc where nvl(EI_PST_IND,'N') = 'N' and ei_logic_ind = 'AMOUNT' ;
	
	open c1; 
	if sqlca.sqlcode = 0 then
		do while true
			setnull(ls_emp_cd); ld_basic = 0; setnull(ld_inc_date); setnull(ls_new_grade); setnull(ls_old_grade);
			fetch c1 into :ls_emp_cd, :ld_basic, :ld_inc_date, :ls_new_grade, :ls_old_grade;
			
				if sqlca.sqlcode <> 0 then	exit		
				
				if ls_new_grade <> ls_old_grade then
					update FB_EMPLOYEE	 set EBS_BASICAMOUNT = :ld_basic, EMP_PROMOTION_DT =  :ld_inc_date, emp_grade = :ls_new_grade where EMP_ID = :ls_emp_cd;
				else
					update FB_EMPLOYEE	 set EBS_BASICAMOUNT = :ld_basic, emp_grade = :ls_new_grade where EMP_ID = :ls_emp_cd;
				end if

			
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error: During Employee Master Update',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
				
				UPDATE fb_emp_inc SET EI_PST_IND = 'Y',EI_APPROVED_BY = :gs_user, EI_APPROVED_DT = sysdate WHERE EI_EMP_ID = :ls_emp_cd AND nvl(EI_PST_IND,'N') = 'N';
	
				if sqlca.sqlcode = -1 then
					messagebox('SQL Error: During Employee Incriment Update',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				end if
	
			loop
		close c1;
		commit using sqlca;
	else	
		messagebox('SQL Error: During Open Cursor',sqlca.sqlerrtext)
		return 1
	end if;
	messagebox('Confirmation','Data Has been Sucessfully Posted',information!)
	dw_1.reset();
end if;

setpointer(arrow!)

end event

type st_1 from statictext within w_gtehrf015
integer x = 864
integer y = 20
integer width = 229
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Grade:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtehrf015
integer x = 1111
integer width = 878
integer height = 884
integer taborder = 20
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

type cb_4 from commandbutton within w_gtehrf015
integer x = 1175
integer y = 104
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string pointer = "AppStarting!"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_gtehrf015
integer x = 590
integer y = 104
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string pointer = "AppStarting!"
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 
long ll_row
for ll_row = dw_1.rowcount() to 1 step -1
	if dw_1.getitemstring(ll_row,'delind') = 'Y' then
		dw_1.deleterow(ll_row)
	end if
next	


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 


end event

type cb_2 from commandbutton within w_gtehrf015
integer x = 320
integer y = 104
integer width = 270
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string pointer = "AppStarting!"
string text = "&Query"
end type

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if

if isnull(ddlb_1.text) or ddlb_1.text="" then
	messagebox('Designation Selection Error','Please select Designation First')
	return
end if;

if isnull(ddlb_2.text) or ddlb_2.text="" then
	messagebox('Employee Selection Error','Please select Employee First')
	return
end if;

ls_desg_cd =ddlb_1.text
//ll_emp_cd = long(left(right(ddlb_2.text,4),3)) 
ls_inc_dt = em_1.text

if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if	  
	dw_1.reset()
 	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_11.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.retrieve(ls_appr_ind,ls_desg_cd)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_11.enabled = true
end if



end event

type dw_1 from datawindow within w_gtehrf015
integer x = 5
integer y = 204
integer width = 4530
integer height = 2116
string dataobject = "dw_gtehrf015"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event itemchanged;if lb_query = false then 
	cb_3.enabled=true

	if dwo.name = 'ei_new_grade' then
		ls_desg_cd =  data
	else
		ls_desg_cd = dw_1.getitemstring(row,'ei_new_grade')
	end if
	
	if dwo.name = 'ei_noof_inc' then
		ll_noi = long(data)
	else
		ll_noi = dw_1.getitemnumber(row,'ei_noof_inc')
	end if;
	
		ls_old_desg =  dw_1.getitemstring(row,'ei_old_grade')
		ld_last_inc_rt = dw_1.getitemnumber(row,'ei_last_inc_rate')
		ld_basic_old = dw_1.getitemnumber(row,'ei_old_basic')
		
		select nvl(decode(sign(:ld_basic_old - EAB_2NDBASIC),-1,EAB_INCREMENT1, decode(sign(:ld_basic_old - EAB_ENDBASIC),-1,EAB_INCREMENT2,0)),0)
			into :ld_inc_rt_old
			from fb_empallowancededuction 
		where (EAD_GRADE,((nvl(EAD_YEAR,0) * 100) + nvl(EAD_MONTH,0))) in 
			(select EAD_GRADE,max((nvl(EAD_YEAR,0) * 100) + nvl(EAD_MONTH,0))  from fb_empallowancededuction
				where  EAD_GRADE = :ls_old_desg group by EAD_GRADE) ;
	 
		 if sqlca.sqlcode = -1 then
			messagebox('Warning : Error During Increment Rate Select',sqlca.sqlerrtext);
			return;
		  end if
		  
   		select nvl(decode(sign(:ld_basic_old - EAB_2NDBASIC),-1,EAB_INCREMENT1, decode(sign(:ld_basic_old - EAB_ENDBASIC),-1,EAB_INCREMENT2,0)),0),
				nvl(EAB_STBASIC,0)
		into :ld_inc_rt,:ld_stbasic
		from fb_empallowancededuction 
		where (EAD_GRADE,((nvl(EAD_YEAR,0) * 100) + nvl(EAD_MONTH,0))) in 
				(select EAD_GRADE,max((nvl(EAD_YEAR,0) * 100) + nvl(EAD_MONTH,0))  from fb_empallowancededuction
					where  EAD_GRADE = :ls_desg_cd group by EAD_GRADE) ;
		

		 if sqlca.sqlcode = -1 then
			messagebox('Warning : Error During Increment Rate Select',sqlca.sqlerrtext);
			return;
		  end if
		if gs_garden_snm <>'AD' then
			if ld_inc_rt_old > ld_inc_rt then
				ld_inc_rt = ld_inc_rt_old	
			end if;
			
			if isnull(ld_last_inc_rt) then ld_last_inc_rt=0;
			if ld_last_inc_rt > ld_inc_rt then
				ld_inc_rt = ld_last_inc_rt
			end if;		
		end if
		dw_1.setitem(row,'ei_inc_rate',ld_inc_rt)
		
		
		if ll_noi > 0 then
			if ld_stbasic > ld_basic_old then	// For Initial Basic check in that Post
				ld_basic_old = ld_stbasic
			end if;
			ld_basic = ld_basic_old + round((ld_inc_rt * ll_noi),0)
		ELSE
			if ld_stbasic > ld_basic_old then	// For Initial Basic check in that Post
				ld_basic_old = ld_stbasic
			end if;
			ld_basic = ld_basic_old 
		END IF

			select nvl(EAD_DA,0), nvl(EAD_VDA,0), nvl(EAD_HR,0), nvl(EAD_ELECTRIC,0), nvl(EAD_FUEL,0), nvl(EAD_CVRFORPF,0) 
			into :ld_da_rt,:ld_vda_rt,:ld_hra_rt,:ld_electric,:ld_fuel,:ld_crvfpf
			from fb_empallowancededuction 
			where (EAD_GRADE,((nvl(EAD_YEAR,0) * 100) + nvl(EAD_MONTH,0))) in 
							(select EAD_GRADE,max((nvl(EAD_YEAR,0) * 100) + nvl(EAD_MONTH,0))  from fb_empallowancededuction
								where  EAD_GRADE = :ls_desg_cd group by EAD_GRADE) ;
		
		 if sqlca.sqlcode = -1 then
			messagebox('Warning : Error During DA/VDA/HRA Rate Select',sqlca.sqlerrtext);
			return;
		  end if
	  
		ld_da = round((ld_basic * (ld_da_rt * 0.01)),0)
		ld_vda = round((ld_basic * (ld_vda_rt * 0.01)),0) 
		ld_hra = round((ld_basic * (ld_hra_rt * 0.01)),0) 

			 
			dw_1.setitem(row,'ei_new_basic',ld_basic)
			dw_1.setitem(row,'ei_new_da',ld_da)
			dw_1.setitem(row,'ei_new_vda',ld_vda)
			dw_1.setitem(row,'ei_new_hr',ld_hra)
			dw_1.setitem(row,'ei_new_electric',ld_electric)
			dw_1.setitem(row,'ei_new_fuel',ld_fuel)
			dw_1.setitem(row,'ei_new_cvrforpf',ld_crvfpf)	
			dw_1.setitem(row,'ei_new_da_rt',ld_da_rt)
			dw_1.setitem(row,'ei_new_vda_rt',ld_vda_rt)
			dw_1.setitem(row,'ei_new_hr_rt',ld_hra_rt)
end if	


end event

event clicked;//if row > 0 then
//		gs_inc_dt   = string(dw_1.getitemdatetime(dw_1.getclickedrow( ),'ei_date'),'dd/mm/yyyy')
//		gs_emp_id = dw_1.getitemstring(dw_1.getclickedrow(),'ei_emp_id')
////		if (dw_1.getitemstring(row,'pei_letter_type') = 'P2') then
//			opensheet(w_gtehrr008,w_mdi,1,layered!) 
////		elseif (dw_1.getitemstring(row,'pei_letter_type') = 'I1' ) then
////			opensheet(w_pr_p3,w_mdi,1,layered!) 
////		elseif (dw_1.getitemstring(row,'pei_letter_type') = 'I2') then
////			opensheet(w_pr_p4,w_mdi,1,layered!) 
////		elseif (dw_1.getitemstring(row,'pei_letter_type') = 'I3') then
////			opensheet(w_pr_p5,w_mdi,1,layered!) 
////		elseif (dw_1.getitemstring(row,'pei_letter_type') = 'C1') then
////			opensheet(w_pr_p6,w_mdi,1,layered!) 
////		end if;
//end if;
end event

