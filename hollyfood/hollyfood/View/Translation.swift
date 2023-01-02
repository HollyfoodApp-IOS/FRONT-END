//
//  Translation.swift
//  hollyfood
//
//  Created by Khairi on 22/12/2022.
//

import Foundation
import SwiftUI

class Translation: ObservableObject {
    
    @AppStorage("language") var language: String = "EN"
        
    //Authentification
    var Login : String = "Login"
    var Sign_Up : String = "Sign Up"
    var Email : String = "Email"
    var Enter_Email : String = "Enter Email"
    var Password : String = "Password"
    var Enter_Password : String = "Enter Password"
    var Forgot_Password : String = "Forgot Password"
    var Verify_Account : String = "Verify Account"
    var Login_With_FaceID : String = "Login With FaceID"
    var Error : String = "Error"
    var Message : String = "Message"
    var Invalid_email_or_password : String = "Invalid email or password"
    var Account_not_verified_yet : String = "Account not verified yet"
    var fieldsEmptyMessage : String = "Please fill all the fields properly"
    var No_user_has_previously_logged_in : String = "No user has previously logged in"
    var There_is_no_Face_ID_saved_in_the_phone : String = "There is no Face ID saved in the phone"
    var Full_Name : String = "Full Name"
    var Enter_Full_Name : String = "Enter Full Name"
    var Confirm_Password : String = "Confirm Password"
    var Phone_Number : String = "Phone Number"
    var Enter_Phone_Number : String = "Enter Phone Number"
    var Role : String = "Role"
    var fullNameVerification : String = "The full name must be at least 4 letters"
    var passwordVerification : String = "The password name must be at least 4 letters"
    var confirmPasswordVerification : String = "Password and Confirm Password fields must be exactly the same"
    var phoneNumberVerification : String = "The phone number is invalid"
    var roleVerification: String = "Role is required"
    var accountCreatedMessage : String = "Your account has been created successfully"
    var back = "Back"
    
    //ForgotPassword
    var Enter_your_email_to_recieve_a_password_reset_code : String = "Enter your email to recieve a password reset code"
    var Send : String = "Send"
    var Password_reset_code_has_been_sent_successfully : String = "Password reset code has been sent successfully"
    var User_not_found : String = "User not found"
    
    //CodeVerification
    var Enter_your_password_reset_code_to_reset_your_password : String = "Enter your password reset code to reset your password"
    var Enter_Code : String = "Enter Code"
    var Code_Verification : String = "Code Verification"
    var Wrong_code : String = "Wrong code"

    //ResetPassword
    var Reset_Password : String = "Reset Password"
    var Password_reset_successfully : String = "Password reset successfully"

    //VerifyAccount
    var Verification_Code : String = "Verification Code"
    var Enter_Verification_Code : String = "Enter Verification Code"
    var Account_verified_successfully : String = "Account verified successfully"
    var Invalid_email_or_verification_code : String = "Invalid email or code"

    //My Restaurants
    var My_Restaurants = "My Restaurants"
    var See_Menu = "See Menu"
    var See_Orders = "See Orders"
    
    //Settings
    var Edit_Personal_Information = "Edit Personal Information"
    var Edit_Profile = "Edit Profile"
    var Change_Password = "Change Password"
    var Actions = "Actions"
    var Dark_Appearance = "Dark Appearance"
    var Language = "Language"
    var Sign_Out = "Sign_Out"

    //Menu
    var Menu : String = "Menu"
    var Add_Plate : String = "Add Plate"
    var All : String = "All"

    
    //PlateItem
    var DT : String = "DT"
    
    //AddToCart
    var Category : String = "Category"
    var Price : String = "Price"
    var Add_To_Cart : String = "Add To Cart"
    var Edit_Plate : String = "Edit Plate"
    var Delete_Plate : String = "Delete Plate"
    
    //AddPlate
    var Plate_Name : String = "Plate Name"
    var Enter_Plate_Name : String = "Enter plate name"
    var Enter_Plate_Price : String = "Enter plate price"
    var plateNameVerification : String = "The plate name must be at least 4 letters"
    var Plate_price_invalid : String = "Plate price invalid"
    var Plate_Added_Successfully : String = "Plate added successfully"
    var Plate_Edited_Successfully : String = "Plate edited successfully"

    //Cart
    var Total : String = "Total"
    var Order_Now : String = "Order Now"
    var Cart : String = "Cart"

    //QRCode Page
    var Scan : String = "Scan"
    var QR_Code : String = "QR Code"
    var Menu_QR_Code : String = "Menu QR Code"

    //Order History
    var Order : String = "Order"
    var History : String = "History"
    var Search : String = "Search"
    var ORDERS : String = "ORDERS"
    var Order_History : String = "Order History"

    //OrderRowView
    var Order_Date : String = "Order Date"
    var Order_Price : String = "Order Price"

    //OrderDetail
    var Cancel : String = "Cancel"
    var Client : String = "Client"
    var Quantity : String = "Quantity"
    var Total_Price : String = "Total Price"

    //Edit Profile
    var Email_already_exist : String = "Email already exist"
    var Profile_updated_successfully : String = "Profile updated successfully"

    //Change Password
    var Old_Password : String = "Old Password"
    var Enter_Old_Password : String = "Enter Old Password"
    var New_Password : String = "New Password"
    var Enter_New_Password : String = "Enter New Password"
    var Conifrm_Password : String = "Conifrm Password"
    var Repeat_New_Password : String = "Repeat New Password"
    var Wrong_password : String = "Wrong password"
    var Password_changed_successfully : String = "Password changed successfully"

    
    func Translate() -> Void {
        
        if language == "AR"
        {
            //Authentification
            Login = "تسجيل الدخول"
            Sign_Up = "اشتراك"
            Email = "البريد الإلكتروني"
            Enter_Email = "أدخل البريد الإلكتروني"
            Password = "كلمة المرور"
            Enter_Password = "أدخل كلمة المرور"
            Forgot_Password = "هل نسيت كلمة المرور"
            Verify_Account = "التحقق من الحساب"
            Login_With_FaceID = "تسجيل الدخول عن طريق معرف الوجه"
            Error = "خطأ"
            Message = "رسالة"
            Invalid_email_or_password = "البريد الإلكتروني أو كلمة السر خاطئة"
            Account_not_verified_yet = "لم يتم تأكيد هذا الحساب بعد"
            fieldsEmptyMessage = "يرجى ملء جميع الحقول بشكل صحيح"
            No_user_has_previously_logged_in = "لم يسجل أي مستخدم الدخول من قبل"
            There_is_no_Face_ID_saved_in_the_phone = "لا يوجد معرف وجه محفوظ في الهاتف"
            Full_Name = "الإسم الكامل"
            Enter_Full_Name = "أدخل الإسم الكامل"
            Confirm_Password = "تأكيد كلمة المرور"
            Phone_Number = "رقم الهاتف"
            Enter_Phone_Number = "أدخل رقم الهاتف"
            Role = "الدور"
            fullNameVerification = "يجب ألا يقل الاسم الكامل عن 4 أحرف"
            passwordVerification = "يجب أن تتكون كلمة المرور من 4 أحرف على الأقل"
            confirmPasswordVerification = "يجب أن يكون حقل كلمة المرور وحقل تأكيد كلمة المرور متطابقين تمامًا"
            phoneNumberVerification = "رقم الهاتف غير صالح"
            roleVerification = "الدور مطلوب"
            accountCreatedMessage = "تم إنشاء حسابك بنجاح"
            back = "إلى الخلف"
            
            //ForgotPassword
            Enter_your_email_to_recieve_a_password_reset_code = "أدخل بريدك الإلكتروني لتلقي رمز إعادة تعيين كلمة المرور"
            Send = "أرسل"
            Password_reset_code_has_been_sent_successfully = "تم إرسال رمز إعادة تعيين كلمة المرور بنجاح"
            User_not_found = "لم يتم العثور على المستخدم"
            
            //CodeVerification
            Enter_your_password_reset_code_to_reset_your_password = "أدخل رمز إعادة تعيين كلمة المرور لإعادة تعيين كلمة المرور الخاصة بك"
            Enter_Code = "أدخل الرمز"
            Code_Verification = "التحقق من الرمز"
            Wrong_code = "رمز خاطئ"

            //ResetPassword
            Reset_Password = "إعادة تعيين كلمة المرور"
            Password_reset_successfully = "تم إعادة تعيين كلمة المرور بنجاح"

            //VerifyAccount
            Verification_Code = "رمز التحقق"
            Enter_Verification_Code = "أدخل رمز التحقق"
            Account_verified_successfully = "تم التحقق من الحساب بنجاح"
            Invalid_email_or_verification_code = "البريد الإلكتروني أو رمز التحقق غير صالح"

            //My Restaurants
            My_Restaurants = "مطاعمي"
            See_Menu = "أنظر قائمة الطعام"
            See_Orders = "أنظر سجل الطلبات"
            
            //Settings
            Edit_Personal_Information = "تعديل المعلومات الشخصية"
            Edit_Profile = "تعديل الملف الشخصي"
            Change_Password = "تغيير كلمة المرور"
            Actions = "إجراءات"
            Dark_Appearance = "مظهر مظلم"
            Language = "اللغة"
            Sign_Out = "تسجيل الخروج"
            
            //Menu
            Menu = "قائمة الطعام"
            Add_Plate = "أضف طبق"
            DT = "دت"
            All = "الكل"
            
            //AddToCart
            Category = "الفئة"
            Price = "الثمن"
            Add_To_Cart = "أضف إلى السلة"
            Edit_Plate = "تعديل الطبق"
            Delete_Plate = "حذف الطبق"
            
            //AddPlate
            Plate_Name = "إسم الطبق"
            Enter_Plate_Name = "أدخل إسم الطبق"
            Enter_Plate_Price = "أدخل  ثمن الطبق"
            plateNameVerification = "يجب أن لا يقل إسم الطبق عن 4 أحرف"
            Plate_price_invalid = "ثمن الطبق غير صالح"
            Plate_Added_Successfully = "تم إضافة الطبق بنجاح"
            Plate_Edited_Successfully = "تم تعديل الطبق بنجاح"
            
            //Cart
            Total = "المجموع"
            Order_Now = "أطلب الان"
            Cart = "عربة التسوق"
            
            //QRCode Page
            Scan = "مسح"
            QR_Code = "رمز qr"
            Menu_QR_Code = "رمز qr القائمة"

            //Order History
            Order = "الطلبات"
            History = "سجل"
            Search = "بحث"
            ORDERS = "الطلبات"
            Order_History = "سجل الطلبات"

            //OrderRowView
            Order_Date = "تاريخ الطلب"
            Order_Price = "الثمن"

            //OrderDetail
            Cancel = "إخفاء"
            Client = "العميل"
            Quantity = "الكمية"
            Total_Price = "الثمن الجملي"
            
            //Edit Profile
            Email_already_exist = "البريد الإلكتروني موجود مسبقا"
            Profile_updated_successfully = "تم تعديل الملف الشخصي بنجاح"
            
            //Change Password
            Old_Password = "كلمة المرور القديمة"
            Enter_Old_Password = "أدخل كلمة المرور القديمة"
            New_Password = "كلمة المرور الجديدة"
            Enter_New_Password = "أدخل كلمة المرور الجديدة"
            Conifrm_Password = "تأكيد كلمة المرور"
            Repeat_New_Password  = "أعد كتابة كلمة المرور الجديدة"
            Wrong_password = "كلمة المرور خاطئة"
            Password_changed_successfully = "تم تغيير كلمة المرور بنجاح"

        }
        
    }

}
