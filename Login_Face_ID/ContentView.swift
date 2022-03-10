//
//  ContentView.swift
//  Login_Face_ID
//
//  Created by 山田滉暁 on 2022/03/09.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    var body: some View {
        NavigationView {
            
            Home()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
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
    @AppStorage("stored_User") var user = "reply.kavsoft@gmail.com"
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
                }
                .padding()
                .background(
                    Color.black.opacity(password == "" ? 0.1 : 0.2)
                )
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
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
                .padding(.top)
                .opacity(userName != "" && password != "" ? 1 : 0)
                .disabled(userName != "" && password != "" ? false : true)
                
                
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
    }
    
    //Getting BioMetricType...
    
}
