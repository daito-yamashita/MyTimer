//
//  ContentView.swift
//  MyTimer
//
//  Created by daito yamashita on 2021/03/16.
//

import SwiftUI

struct ContentView: View {
    
    @State var timerHandler : Timer?
    
    @State var count = 0
    
    @AppStorage("timer_value") var timerValue = 10
    
    @State var showAlert = false
    
    var body: some View {
        
        NavigationView {
            ZStack{
                
                // 背景画像
                Image("backgroundTimer")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                
                VStack(spacing: 30.0){
                    Text("残り\(timerValue - count)秒")
                        .font(.largeTitle)
                    
                    HStack{
                        Button(action: {
                            // タイマーカウントダウン開始関数を呼び出す
                            startTimer()
                        }) {
                            Text("スタート")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("startColor"))
                                .clipShape(Circle())
                        }
                        Button(action: {
                            // timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                if unwrapedTimerHandler.isValid == true {
                                    // タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                }
                            }
                        }) {
                            Text("ストップ")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 140, height: 140)
                                .background(Color("stopColor"))
                                .clipShape(Circle())
                        }
                    }
                }
            }
            
            // 画面が表示されるときに実行される
            .onAppear {
                count = 0
            }
            
            .navigationBarItems(trailing:
                NavigationLink(destination: SettingView()) {
                    Text("秒数設定")
                }
            )
            
            // showAlertがtrueのとき実行される
            .alert(isPresented: $showAlert) {
                // アラート表示のためのレイアウトを記述
                // アラート表示
                Alert(title: Text("終了"),
                      message: Text("タイマー終了時間です"),
                      dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // １秒ごとに実行されてカウントダウンする
    func countDownTimer() {
        
        count += 1
        
        // 残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            
            // タイマー停止
            timerHandler?.invalidate()
            
            // アラート表示
            showAlert = true
        }
    }
    
    // タイマーをカウントダウン開始する関数
    func startTimer() {
        // タイマーの値がセットされているか
        if let unwrapedTimerHandler = timerHandler {
            // もしタイマーが実行中なら何もしない
            if unwrapedTimerHandler.isValid == true {
                return
            }
        }
        
        if timerValue - count <= 0 {
            count = 0
        }
        
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            countDownTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
