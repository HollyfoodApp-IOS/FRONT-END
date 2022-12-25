//
//  PlateItem.swift
//  hollyfood
//
//  Created by Khairi on 30/11/2022.
//

import SwiftUI

struct PlateItem: View {
    
    var plate: Plate
    var animation: Namespace.ID
    
    @ObservedObject var translation = Translation()
    @State var DT : String = ""

    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 0)

                Text(String(format: "%.2f \(DT)", plate.price))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
            }

            Image(plate.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 30)
                .padding(.bottom)
                .padding(.horizontal, 10)

            Text(plate.name)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()

        }
        .background(
            Color("PrimaryColor")
                .opacity(0.1)
                .ignoresSafeArea()
        )
        .cornerRadius(15)
        .onAppear(perform: {
            
            translation.Translate()
            DT = translation.DT
        })


    }
}

struct PlateItem_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
/*
 
 قائمة الطعام
 أضف طبق
 رمز qr القائمة
 مسح كود qr
 الإسم
 أدخل إسم الطبق
 الثمن
 أدخل ثمن الطبق
 الفئة
 أضف الطبق
 عربة التسوق
 المجموع
 اطلب الان



 سجل الطلبات
 بحث
 الطلبات
 التاريخ
 الثمن
 العميل
 رقم الهاتف
 تاريخ الطلب
 الطلب
 إسم الطبق
 الفئة
 الكمية
 الثمن
 الثمن الجملي
 إخفاء


 */
