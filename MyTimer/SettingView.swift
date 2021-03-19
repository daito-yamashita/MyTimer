//
//  SettingView.swift
//  MyTimer
//
//  Created by daito yamashita on 2021/03/16.
//

import SwiftUI

struct SettingView: View {
    // 永続化する秒数設定
    @AppStorage("timer_value") var timerValue = 10
    
    var body: some View {
        ZStack{
            Color("backgroundSetting")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer()
                
                Text("\(timerValue)秒")
                    .font(.largeTitle)
                
                Spacer()
                
                Picker(selection: $timerValue, label: Text("選択")) {
                    Text("10").tag(10)
                    Text("20").tag(20)
                    Text("30").tag(30)
                    Text("40").tag(40)
                    Text("50").tag(50)
                    Text("60").tag(60)
                }
                
                Spacer()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
