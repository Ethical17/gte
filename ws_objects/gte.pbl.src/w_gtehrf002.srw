$PBExportHeader$w_gtehrf002.srw
forward
global type w_gtehrf002 from window
end type
type cb_4 from commandbutton within w_gtehrf002
end type
type cb_3 from commandbutton within w_gtehrf002
end type
type cb_2 from commandbutton within w_gtehrf002
end type
type cb_1 from commandbutton within w_gtehrf002
end type
type dw_1 from datawindow within w_gtehrf002
end type
end forward

global type w_gtehrf002 from window
integer width = 4448
integer height = 1972
boolean titlebar = true
string title = "(w_gtehrf002) Census Record (Employee)"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtehrf002 w_gtehrf002

type variables
long  ll_cnt,ll_user_level
string ls_temp,ls_del_ind,ls_mac_id,ls_tmp_id,ls_appr_ind,ls_entry_user, ls_appr_by,ls_ref, ls_cons,ls_last,ls_count,ls_sup_id,ls_lpo_id,ls_supname
boolean lb_neworder, lb_query
double ld_net_amt,ld_tot_val,ld_freight,ld_insurance,ld_other,ld_saletax,ld_qnty,ld_unit_price,ld_amount,ld_discount,ld_old_qnty
datetime ld_rundt,ld_appr_dt,ld_startdt,ld_enddt, ld_pluckdt,ld_lpo_dt
datawindowchild idw_prod

string ls_child_name,ls_labour_id,ls_child_gender,ls_dob
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_con_id)
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	 if (isnull(dw_1.getitemstring(fl_row,'emp_id')) or  len(dw_1.getitemstring(fl_row,'emp_id'))=0 or &
	    isnull(dw_1.getitemstring(fl_row,'empd_name')) or  len(dw_1.getitemstring(fl_row,'empd_name'))=0 or &
	    isnull(dw_1.getitemdatetime(fl_row,'empd_dob')) ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, Quantity, Please Check !!!')
	    return -1
	end if
end if
return 1


end function

public function integer wf_check_duplicate_rec (string fs_con_id);long fl_row
string ls_con_id1
datetime ld_run_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_con_id1 = dw_1.getitemstring(fl_row,'empd_name')
		
		if ls_con_id1 = fs_con_id  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtehrf002.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtehrf002.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)

lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type cb_4 from commandbutton within w_gtehrf002
integer x = 809
integer y = 12
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gtehrf002
integer x = 544
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
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_1.getitemdatetime(dw_1.rowcount(),'empd_dob')) ) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		for ll_cnt = 1 to dw_1.rowcount( ) 
			
			IF wf_check_fillcol(ll_cnt) = -1 THEN 
				return 1
			end if

		next	
	end if

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

type cb_2 from commandbutton within w_gtehrf002
integer x = 279
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	cb_3.enabled = false
  	cb_1.enabled = false
	dw_1.settaborder('emp_id',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('emp_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_appr_ind)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
   	cb_1.enabled = true	
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtehrf002
integer x = 14
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'empd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'empd_entry_dt',datetime(today()))
	dw_1.setcolumn('emp_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'empd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'empd_entry_dt',datetime(today()))
	dw_1.setcolumn('emp_id')
end if

cb_1.enabled = false
end event

type dw_1 from datawindow within w_gtehrf002
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 9
integer y = 116
integer width = 4375
integer height = 1732
integer taborder = 30
string dataobject = "dw_gtehrf002"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'empd_entry_by',gs_user)
		dw_1.setitem(newrow,'empd_entry_dt',datetime(today()))
		dw_1.setcolumn('emp_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'labour_id'  then
	ls_labour_id = data	
	if isnull(ls_labour_id)=true or len(ls_labour_id)<1 then
		messagebox('Warrnig:','Please select a valid Labour Id')
          rollback using sqlca;
	      return 1
	end if;
end if;

if dwo.name = 'child_name'  then
	ls_child_name = data	
	if isnull(ls_child_name)=true or len(ls_child_name)<1 then
		messagebox('Warrnig:','Please Enter a valid Child Name')
          rollback using sqlca;
	      return 1
	end if;
end if;

if dwo.name = 'child_gender'  then
	ls_child_gender = data	
	if isnull(ls_child_gender)=true or len(ls_child_gender)<1 then
		messagebox('Warrnig:','Please Enter a valid Child gender')
          rollback using sqlca;
	      return 1
	end if;
end if;

if dwo.name = 'child_dob'  and lb_query = false then
	ls_dob=data
	
	if isnull(ls_dob) = true or ls_dob='00/00/0000'  then
		messagebox('Warning!', 'Child DOB Should Be Enter , Please Check !!!')
		return 1
	end if
	
	if Date(ls_dob) > date(string(today(),'dd/mm/yyyy'))  then
		messagebox('Alert!','Child DOB Should Be <= Current Date  !!!')
		return 1
	end if
	
	select distinct 'x'  into :ls_temp
	   from fb_labourdependent
      where labour_id=:ls_labour_id and child_name=:ls_child_name and trunc(child_dob)=to_date(:ls_dob,'dd/mm/yyyy');
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During Getting Labour Child Detail  : '+sqlca.sqlerrtext)
	      rollback using sqlca;
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Labour & Child Already Present In Child Detail Master  : '+sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if;	
end if;

cb_3.enabled = true 

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			ls_ref = dw_1.getitemstring(dw_1.getrow(),'emp_id')
			dw_1.reset()
			dw_1.retrieve(ls_ref)
		end if
	end if
end if
end event

