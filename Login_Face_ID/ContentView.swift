//
//  ContentView.swift
//  Login_Face_ID
//
//  Created by 山田滉暁 on 2022/03/09.
//

import SwiftUI
//生体認証を使用するためのライブラリ
import LocalAuthentication

struct ContentView: View {
    @AppStorage("status") var logged = false
    var body: some View {
        NavigationView {
            
            if logged {
                
                Text("User Logged In...")
                    .navigationTitle("Home")
                    .navigationBarHidden(false)
                    .preferredColorScheme(.light)
            }
            else {
                
                Home()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var userName = ""
    @State var password = ""
    //初めてユーザーが電子メールでログインしたとき、以降の生体認証ログインのためにこれを保存します...
    //@AppStorageはUserDefaultsを使用してデータを保持する
    @AppStorage("stored_User") var user = "yamadakoki0124@icloud.com"
    @AppStorage("status") var logged = false
    
    var body: some View {
        VStack {
            
            Spacer(minLength: 0)
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 35)
                .padding(.vertical)
            
            VStack{
                HStack {
                    
                    VStack(alignment: .leading, spacing: 12, content: {
                        
                        Text("Login")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Please sign in to continue")
                            .foregroundColor(Color.black.opacity(0.6))
                    })
                    
                    Spacer(minLength: 0)
                }
                .padding()
                
                HStack {
                    
                    Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 35)
                    
                    TextField("E-mail", text: $userName)
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                }
                .padding()
                .background(
                    Color.black.opacity(userName == "" ? 0.1 : 0.2)
                )
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack {
                    
                    Image(systemName: "lock")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 35)
                    
                    SecureField("password", text: $password)
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                        .keyboardType(.default)
                }
                .padding()
                .background(
                    Color.black.opacity(password == "" ? 0.1 : 0.2)
                )
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack {
                    //Login Button...
                    Button(action: {}, label: {
                        Text("Login")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color(red: 0.2, green: 0.97, blue: 0.78))
                            .cornerRadius(8)
                            .shadow(color: Color(red: 0.2, green: 0.97, blue: 0.78).opacity(0.7), radius: 5, x: 3, y: 3)
                    })
                        .opacity(userName != "" && password != "" ? 1 : 0.5)
                    .disabled(userName != "" && password != "" ? false : true)
                    
                    if getBioMetricStatus(){
                        
                        Button(action: authenticateUser, label: {
                            //認証処理の実行
                            Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(red: 0.2, green: 0.97, blue: 0.78))
                                .clipShape(Circle())
                        })
                    }
                    
                }
                .padding(.top)
                
                
                //Forget Button...
                Button(action: {}, label: {
                    Text("Forget password?")
                        .foregroundColor(Color(red: 0.2, green: 0.97, blue: 0.78))
                })
                    .padding(.top, 8)
                    .padding(.bottom, 10)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 400)
            .background(Color.white)
            .cornerRadius(15)
            .padding(25)
            
            //Sign up...
            Spacer(minLength: 0)
            
            HStack(spacing: 5) {
                
                Text("Don't have account?")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action: {}, label: {
                    Text("Signup")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white)
                })
            }
        }
        .background(
            Color(red: 0.32, green: 0.34, blue: 0.95)
                .ignoresSafeArea(.all, edges: .all)
        )
        .animation(.easeOut)
    }
    
    //Getting BioMetricType...
    func getBioMetricStatus()->Bool {
        //生体認証を管理クラスを生成
        let scanner = LAContext()
        //顔認証が利用できるかチェック
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            
            return true
        }
        return false
    }
    
    func authenticateUser(){
        
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To unlock \(userName)") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            //setting logged status as true...
            withAnimation(.easeOut){logged = true}
        }
    }
}
