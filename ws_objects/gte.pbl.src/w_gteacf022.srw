$PBExportHeader$w_gteacf022.srw
forward
global type w_gteacf022 from window
end type
type cb_4 from commandbutton within w_gteacf022
end type
type cb_3 from commandbutton within w_gteacf022
end type
type cb_2 from commandbutton within w_gteacf022
end type
type cb_1 from commandbutton within w_gteacf022
end type
type dw_1 from datawindow within w_gteacf022
end type
end forward

global type w_gteacf022 from window
integer width = 4635
integer height = 2460
boolean titlebar = true
string title = "Gteacf022  (SOE Master)"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacf022 w_gteacf022

type variables
boolean lb_neworder,lb_query
n_cst_powerfilter iu_powerfilter
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (long fl_sm_code)
end prototypes

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if ( isnull(dw_1.getitemnumber(fl_row,'SM_CODE')) or  dw_1.getitemnumber(fl_row,'SM_CODE') = 0 or &
		isnull(dw_1.getitemstring(fl_row,'SM_DESC')) or  len(dw_1.getitemstring(fl_row,'SM_DESC'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'SM_MDAY_IND')) or  len(dw_1.getitemstring(fl_row,'SM_MDAY_IND'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'SM_SO')) or  len(dw_1.getitemstring(fl_row,'SM_SO'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'SM_FACT_IND')) or  len(dw_1.getitemstring(fl_row,'SM_FACT_IND'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'SM_STORE_IND')) or  len(dw_1.getitemstring(fl_row,'SM_STORE_IND'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'SM_SERVICE_IND')) or  len(dw_1.getitemstring(fl_row,'SM_SERVICE_IND'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'SM_SOE_TYPE')) or  len(dw_1.getitemstring(fl_row,'SM_SOE_TYPE'))=0) then
	    messagebox('Warning: One Of The Following Field Is Blank',' Please Check !!!')
		return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (long fl_sm_code);long fl_row
long ll_sm_code
dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ll_sm_code  = dw_1.getitemnumber(fl_row,'SM_CODE')
		if (ll_sm_code = fl_sm_code)  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 
return 1
end function

on w_gteacf022.create
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

on w_gteacf022.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_4 from commandbutton within w_gteacf022
integer x = 891
integer y = 28
integer width = 283
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Exit"
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

type cb_3 from commandbutton within w_gteacf022
integer x = 608
integer y = 28
integer width = 283
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save"
end type

event clicked;long l_ctr,l_temp_var,ix,ll_ctr
integer NET
string  ls_temp_var2,ls_dytp

if dw_1.rowcount() > 0 then
  if lb_neworder = true then
		IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'SM_CODE')) or (len(dw_1.getitemstring(dw_1.rowcount(),'SM_CODE'))=0)) THEN
			dw_1.deleterow(dw_1.rowcount())
		END IF
   else
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
   end if
end if;

Net = MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1)
    IF Net = 1 THEN
		for ll_ctr = 1 to dw_1.rowcount() 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
		next
     lb_neworder = false
	dw_1.update()
	commit using sqlca;
	DW_1.RESET()
	lb_query = false	
	lb_neworder = false
else
	return
end if
cb_4.enabled= true
end event

type cb_2 from commandbutton within w_gteacf022
integer x = 325
integer y = 28
integer width = 283
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
	dw_1.settaborder( 'SM_CODE',10)
	dw_1.settaborder( 'SM_DESC',20)
	dw_1.settaborder( 'SM_UOM',30)
	dw_1.settaborder( 'SM_MDAY_IND',40)
	dw_1.settaborder( 'SM_SO',50)
	dw_1.settaborder( 'SM_FACT_IND',60)
	dw_1.settaborder( 'SM_STORE_IND',70)
	dw_1.settaborder( 'SM_SERVICE_IND',80)
	dw_1.settaborder( 'SM_SOE_TYPE',90)
	dw_1.settaborder( 'SM_ENTRY_BY',100)
	dw_1.settaborder( 'SM_ENTRY_DT',110)
else
	lb_query = false
    dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'NO'
	dw_1.Retrieve()
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	dw_1.settaborder( 'SM_CODE',0)
	dw_1.settaborder( 'SM_DESC',0)
	dw_1.settaborder( 'SM_UOM',0)
	dw_1.settaborder( 'SM_MDAY_IND',0)
	dw_1.settaborder( 'SM_SO',0)
	dw_1.settaborder( 'SM_FACT_IND',0)
	dw_1.settaborder( 'SM_STORE_IND',0)
	dw_1.settaborder( 'SM_SERVICE_IND',0)
	dw_1.settaborder( 'SM_SOE_TYPE',0)
	dw_1.settaborder( 'SM_ENTRY_BY',0)
	dw_1.settaborder( 'SM_ENTRY_DT',0)
	lb_neworder = false
	cb_3.enabled = true
end if
end event

type cb_1 from commandbutton within w_gteacf022
integer x = 37
integer y = 28
integer width = 283
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

event clicked;dw_1.reset()
if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
end if
dw_1.settransobject(sqlca)
lb_neworder = true
if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setitem(dw_1.getrow(),'sm_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sm_entry_dt',datetime(today()))
else
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'sm_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sm_entry_dt',datetime(today()))
end if
lb_neworder = true
cb_3.enabled =true
end event

type dw_1 from datawindow within w_gteacf022
event ue_leftbuttonup pbm_dwnlbuttonup
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 37
integer y = 128
integer width = 4517
integer height = 2188
integer taborder = 30
string title = "none"
string dataobject = "dw_gteacf022"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1
end event

event itemchanged;long l_ctr,ll_sm_cd
if lb_neworder = true or lb_query = false then
	if dw_1.getrow()=dw_1.rowcount() and lb_neworder=true then 
		dw_1.insertrow(0)
		dw_1.setitem(dw_1.getrow(),'sm_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'sm_entry_dt',today())
	end if
end if
If dwo.name = 'SM_CODE' then
	ll_sm_cd = dw_1.getitemnumber(dw_1.getrow(),'sm_code')
	if wf_check_duplicate_rec(ll_sm_cd) = -1 then 
		return 1
	end if;
end if

end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_soe_master');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_soe_master',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;
end event

