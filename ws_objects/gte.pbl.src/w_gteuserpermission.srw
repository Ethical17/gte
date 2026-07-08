$PBExportHeader$w_gteuserpermission.srw
forward
global type w_gteuserpermission from window
end type
type cb_4 from commandbutton within w_gteuserpermission
end type
type st_2 from statictext within w_gteuserpermission
end type
type ddlb_2 from dropdownlistbox within w_gteuserpermission
end type
type cb_3 from commandbutton within w_gteuserpermission
end type
type cb_2 from commandbutton within w_gteuserpermission
end type
type cb_1 from commandbutton within w_gteuserpermission
end type
type st_1 from statictext within w_gteuserpermission
end type
type ddlb_1 from dropdownlistbox within w_gteuserpermission
end type
type dw_1 from datawindow within w_gteuserpermission
end type
end forward

global type w_gteuserpermission from window
integer width = 5947
integer height = 2552
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_option ( )
cb_4 cb_4
st_2 st_2
ddlb_2 ddlb_2
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_1 st_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gteuserpermission w_gteuserpermission

type variables
n_cst_powerfilter iu_powerfilter
string ls_module_name,ls_screen_cd,ls_screen_detail,ls_user_id
long ll_permission
integer li_ColNum,ll_user_level,ll_result

string ls_module,ls_SCREEN_TYPE,ls_SCREEN_CODE,ls_MENU_PATH,ls_MASTER_CHECK
end variables

forward prototypes
public function integer wf_assing_permission (integer fl_row, integer fl_permission)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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

public function integer wf_assing_permission (integer fl_row, integer fl_permission);setnull(ls_module_name);setnull(ls_screen_cd);setnull(ls_screen_detail);
	
	ls_module_name = dw_1.getitemstring(fl_row,'fb_module_master_module')
	ls_screen_cd=dw_1.getitemstring(fl_row,'fb_screen_detail_screen_code')
	ls_screen_detail = dw_1.getitemstring(fl_row,'fb_screen_detail_menu_path')
	
	if ll_user_level <> 1 and fl_permission = 1 then
		messagebox('Warning','Not authorized to Give Admin Role')
		return -1;
	end if
		
	
	
	dw_1.setitem(fl_row,'ld_apps','GTE')
	dw_1.setitem(fl_row,'ld_user_id',ls_user_id)
	dw_1.setitem(fl_row,'ld_module',ls_module_name)
	dw_1.setitem(fl_row,'ld_permission',fl_permission)
	dw_1.setitem(fl_row,'ld_screen',ls_screen_cd)
	dw_1.setitem(fl_row,'ld_menu_detail',ls_screen_detail)

return 1
end function

on w_gteuserpermission.create
this.cb_4=create cb_4
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.st_2,&
this.ddlb_2,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_gteuserpermission.destroy
destroy(this.cb_4)
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;
ddlb_1.reset()

declare c1 cursor for
select trim(user_id)
from fb_login
where nvl(user_active_ind,'Y') = 'Y'
order by user_id;

open c1;

if sqlca.sqlcode = 0 then
   fetch c1 into :ls_user_id;

   do while sqlca.sqlcode = 0
      ddlb_1.additem(ls_user_id)
      fetch c1 into :ls_user_id;
   loop
end if

close c1;



ddlb_2.Reset()

ddlb_2.AddItem("All")
ddlb_2.AddItem("Admin")
ddlb_2.AddItem("User")
ddlb_2.AddItem("Inquiry")
ddlb_2.AddItem("No Permission")

ddlb_2.SelectItem(1)


this.tag = Message.StringParm
ll_user_level = long(this.tag)

end event

type cb_4 from commandbutton within w_gteuserpermission
integer x = 2158
integer y = 28
integer width = 480
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "New Permission"
end type

event clicked;dw_1.reset();
SetPointer(HourGlass!)
string ls_perm
long ll_row
setnull(ls_perm)
ls_user_id = Trim(ddlb_1.Text)
ls_perm    = Trim(ddlb_2.Text)
dw_1.reset();

IF ls_user_id = "" THEN
   MessageBox("Information","Please Select User ID")
   ddlb_1.SetFocus()
   RETURN
END IF

setnull(ll_permission)

CHOOSE CASE ls_perm
   CASE "Admin"
      ll_permission = 1
   CASE "User"
      ll_permission = 2
   CASE "Inquiry"
      ll_permission = 3
   CASE "No Permission"
      ll_permission = 0
   CASE ELSE
      ll_permission = -1     // All
END CHOOSE

if ll_permission = 0 then
 
	DECLARE c2 CURSOR FOR  
		SELECT fmm.MOD_NAME AS MODULE, fsd.SD_TYPE_NAME AS SCREEN_TYPE,	 fsd.SD_SCREEN AS SCREEN_CODE, fsd.SD_MENU_DETAIL AS MENU_PATH, 'N' AS MASTER_CHECK
	FROM ltc.fb_screen_detail fsd
	LEFT OUTER JOIN ltc.fb_module_master fmm ON TO_CHAR(fmm.ID) = TRIM(fsd.SD_MODULE)
	LEFT OUTER JOIN fb_login_detail fld on fld.ld_screen = fsd.SD_SCREEN and ld_user_id=:ls_user_id
	WHERE (:ll_permission = -1 OR NVL(fld.LD_PERMISSION,0) = :ll_permission) order by 1,2;
	open c2;
	
	IF sqlca.sqlcode = 0 THEN
			fetch c2 into :ls_module,:ls_SCREEN_TYPE,:ls_SCREEN_CODE,:ls_MENU_PATH,:ls_MASTER_CHECK;
			
			do while sqlca.sqlcode <> 100
				dw_1.scrolltorow(dw_1.insertrow(0))
				dw_1.setitem(dw_1.getrow(),'fb_module_master_module',ls_module)
				dw_1.setitem(dw_1.getrow(),'fb_screen_detail_screen_type',ls_SCREEN_TYPE)
				dw_1.setitem(dw_1.getrow(),'fb_screen_detail_screen_code',ls_SCREEN_CODE)
				dw_1.setitem(dw_1.getrow(),'fb_screen_detail_menu_path',ls_MENU_PATH)
				dw_1.setitem(dw_1.getrow(),'master_check',ls_MASTER_CHECK)
				
				setnull(ls_module); setnull(ls_SCREEN_TYPE); setnull(ls_SCREEN_CODE); setnull(ls_MENU_PATH); setnull(ls_MASTER_CHECK); 
				
				fetch c2 into :ls_module,:ls_SCREEN_TYPE,:ls_SCREEN_CODE,:ls_MENU_PATH,:ls_MASTER_CHECK;
			loop
		END IF
		close c2;
		dw_1.GroupCalc()
		dw_1.SetRedraw(true)
else
	MessageBox("Information","Only New Permission")
end if

SetPointer(Arrow!)
end event

type st_2 from statictext within w_gteuserpermission
integer x = 1211
integer y = 44
integer width = 352
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Permission :-"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gteuserpermission
integer x = 1568
integer y = 32
integer width = 562
integer height = 472
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_1.Reset()
end event

type cb_3 from commandbutton within w_gteuserpermission
integer x = 2921
integer y = 28
integer width = 229
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "Save"
end type

event clicked;string ls_screen
long   ll_row,ll_count

dw_1.AcceptText()
ls_user_id = Trim(ddlb_1.Text)

IF ls_user_id = "" THEN
   MessageBox("Error","Please Select User ID")
   RETURN
END IF

IF dw_1.ModifiedCount() = 0 THEN
   MessageBox("Information","No Changes Found.")
   RETURN
END IF

SetPointer(HourGlass!)


FOR ll_row = dw_1.RowCount() TO 1 STEP -1
    ll_permission = 0
    IF IsNull(dw_1.GetItemNumber(ll_row, "ld_permission")) THEN
        ll_permission = 0
    ELSE
        ll_permission = dw_1.GetItemNumber(ll_row, "ld_permission")
		
    END IF
	 
	 IF IsNull(dw_1.GetItemString(ll_row, "rowid"))  OR Trim(dw_1.GetItemString(ll_row, "rowid")) = "" THEN
			dw_1.SetItemStatus(ll_row, 0, Primary!, NewModified!)
		END IF
	 
    IF ll_permission = 0 THEN
        dw_1.DeleteRow(ll_row)
    END IF
NEXT

IF dw_1.RowCount() = 0 THEN
    MessageBox("Information", "No records to save.")
    RETURN
END IF

dw_1.SetTransObject(SQLCA)

IF dw_1.Update(TRUE, FALSE) = 1 THEN
    dw_1.ResetUpdate()
    COMMIT USING SQLCA;
	 cb_3.enabled = false
		MessageBox("Success","Permissions Saved Successfully.")
		dw_1.reset()
ELSE
   messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
END IF
 
end event

type cb_2 from commandbutton within w_gteuserpermission
integer x = 3177
integer y = 28
integer width = 229
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Close"
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

type cb_1 from commandbutton within w_gteuserpermission
integer x = 2665
integer y = 28
integer width = 229
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Query"
end type

event clicked;string ls_perm
long ll_row
setnull(ls_perm)
ls_user_id = Trim(ddlb_1.Text)
ls_perm    = Trim(ddlb_2.Text)

IF ls_user_id = "" THEN
   MessageBox("Information","Please Select User ID")
   ddlb_1.SetFocus()
   RETURN
END IF

CHOOSE CASE ls_perm
   CASE "Admin"
      ll_permission = 1
   CASE "User"
      ll_permission = 2
   CASE "Inquiry"
      ll_permission = 3
   CASE "No Permission"
      ll_permission = 0
   CASE ELSE
      ll_permission = -1     // All
END CHOOSE

SetPointer(HourGlass!)
dw_1.reset();
dw_1.SetTransObject(SQLCA)
ll_row = dw_1.Retrieve(ls_user_id, ll_permission)

SetPointer(Arrow!)

IF ll_row <= 0 THEN
   MessageBox("Information","No Data Found")
END IF




















//string ls_user_id
//long ll_row
//
//ls_user_id = trim(ddlb_1.text)
//
//if ls_user_id = "" then
//   messagebox("information","please select user id")
//   ddlb_1.setfocus()
//   return
//end if
//
//setpointer(hourglass!)
//dw_1.settransobject(sqlca)
//ll_row = dw_1.retrieve(ls_user_id)
//setpointer(arrow!)
//
//if ll_row <= 0 then
//   messagebox("information","no data found for user : " + ls_user_id)
//else
//   messagebox("information",string(ll_row) + " rows retrieved")
//end if
end event

type st_1 from statictext within w_gteuserpermission
integer x = 105
integer y = 44
integer width = 261
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "User ID :-"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteuserpermission
integer x = 370
integer y = 32
integer width = 773
integer height = 1160
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_1.Reset()
end event

type dw_1 from datawindow within w_gteuserpermission
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 37
integer y = 152
integer width = 4475
integer height = 2292
string title = "none"
string dataobject = "dw_gteuserpermission"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event itemchanged;IF dwo.Name = "master_check" THEN
   string ls_type
   long   i
   ls_module = dw_1.GetItemString(row, "fb_module_master_module")
   ls_type   = dw_1.GetItemString(row, "fb_screen_detail_screen_type")
   IF data = "Y" THEN
      FOR i = 1 TO dw_1.RowCount()
         IF dw_1.GetItemString(i,"fb_module_master_module") = ls_module AND dw_1.GetItemString(i,"fb_screen_detail_screen_type") = ls_type THEN
            dw_1.SetItem(i,"permission",1)
         END IF
      NEXT
   ELSE
      FOR i = 1 TO dw_1.RowCount()
         IF dw_1.GetItemString(i,"fb_module_master_module") = ls_module AND dw_1.GetItemString(i,"fb_screen_detail_screen_type") = ls_type THEN
            dw_1.SetItem(i,"permission", dw_1.GetItemNumber(i,"org_permission"))
         END IF
      NEXT
   END IF
END IF

if dwo.Name = "permission" then
	ll_permission =long(data)	
	 ll_result=wf_assing_permission(row,ll_permission)	
	 if ll_result =-1 then 
		dw_1.setitem(row,"permission",0)
		return -1;
	end if	 
end if


if ll_user_level <> 3 then
	cb_3.enabled=true
else 
	cb_3.enabled=False
end if




end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

event clicked;	setnull(li_ColNum)
	li_ColNum = getclickedcolumn()
	integer i
	
if dw_1.getrow() > 0 then
	if li_ColNum= 2 then
		ls_module=dw_1.getitemstring(dw_1.getclickedrow(),'fb_module_master_module')
		
		FOR i = 1 TO dw_1.RowCount()
         IF dw_1.GetItemString(i,"fb_module_master_module") = ls_module THEN
		   ll_permission =2
		  
			if  dw_1.getItemnumber(i,"permission")<>2 then
					  ll_result=wf_assing_permission(row,ll_permission)	
	 					if ll_result =-1 then 
							return -1;
						else
							dw_1.SetItem(i,"permission",2)
						end if
					 
					 
				    dw_1.SetItem(i,"permission",2)
			end if
         END IF
      NEXT	
	end if
	
	if li_ColNum= 3 then
		ls_module=dw_1.getitemstring(dw_1.getclickedrow(),'fb_module_master_module')
		ls_screen_type=dw_1.getitemstring(dw_1.getclickedrow(),'fb_screen_detail_screen_type')
		
		FOR i = 1 TO dw_1.RowCount()
         IF dw_1.GetItemString(i,"fb_module_master_module") = ls_module and dw_1.GetItemString(i,"fb_screen_detail_screen_type") = ls_screen_type THEN
            
			ll_permission =2
			
			if  dw_1.getItemnumber(i,"permission")<>2 then
					 ll_result= wf_assing_permission(row,ll_permission)	
					 if ll_result =-1 then 
							return -1;
						else
							dw_1.SetItem(i,"permission",2)
						end if
					 
				    
			end if
         END IF
		next
	end if
end if
end event

