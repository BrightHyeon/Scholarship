//
//  BusanCustomView.swift
//  ADAAssessment
//
//  Created by Hyeonsoo Kim on 2022/06/24.
//

import SwiftUI
import SwiftUIX //SearchBar 사용하려고 가져온 외부 framework

struct ContentView: View {
    
    @State private var searchText: String = "" //SearchBar에 들어갈 text
    
    //title과 searchBar가 지정한 위치보다 위로 올라가면 true로 변환 -> custom NavBar형성
    @State private var isTitleUp: Bool = false
    @State private var isSearchBarUp: Bool = false
    
    var shipList = [ //fetch Data
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 hello hello hello hello hihihihihiihihihihi[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 hello hello hello",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
        "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원"
    ]
    
    //searchBar filtering.
    var filteredList: [String] {
        shipList.filter { content in
            if !searchText.isEmpty {
                return content.lowercased().contains(searchText.lowercased())
            } else {
                return true
            }
        }
    }
    
    //학교 공홈에 대한 것도 위와 같은 방식으로 filtering해서 뿌리깅.
    
    var body: some View {
        ZStack {
            
            Color.secondary.opacity(0.1) //배경
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Spacer().frame(height: 50)
                    
                    HStack {
                        Text("장학금 목록") //NavigationTitle인 척하는 놈.
                            .font(.largeTitle).bold()
                            .foregroundColor(Color("busan"))
                            .overlay( //해당 Text의 화면 상에서의 위치를 읽도록.
                                GeometryReader { geome -> Color in
                                    let offset = geome.frame(in: .global).minY
                                    calculateOffset(offset)
                                    return .clear
                                }
                            )
                        
                        Image(systemName: "book.fill")
                            .font(.title)
                            .foregroundColor(Color("busan"))
                    }
                    
                    //SearchBar
                    SearchBar("Search", text: $searchText)
                        .foregroundColor(.black)
                        .textFieldBackgroundColor(.white.withAlphaComponent(0.2))
                        .padding(.horizontal, -10)
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("동물생명공학전공")
                            Spacer()
                            Image(systemName: "chevron.down.circle.fill")
                        }
                        .font(.title2.bold())
                        .foregroundColor(.green)
                        .padding(20)
                        .padding(.top, 10)
                        
                        Divider()
                            .padding(.horizontal, 20)
                        
                        //filtering한 list를 뿌려줌.
                        ForEach(filteredList, id: \.self) { content in
                            Text(content)
                                .fontWeight(.semibold)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(20)
                            
                            Divider()
                                .padding(.horizontal, 20)
                        }
                        
                    }
                    .background()
                    .cornerRadius(30, style: .continuous)
                }
                
                Spacer().frame(height: 50)
                
                Text("학과 변경")
                    .foregroundColor(.secondary)
                    .underline()
                
                Spacer().frame(height: 50)
                
            }
            .padding(20)
            .ignoresSafeArea()
            
            VStack {
                NavBar(isTitleUp: $isTitleUp, isSearchBarUp: $isSearchBarUp, searchText: $searchText)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
    
    //"장학금 목록" title의 위치값에 따라 NavBar가 활성화되도록. Animation부여.
    private func calculateOffset(_ offset: CGFloat) {
        if offset < 30 {
            DispatchQueue.main.async {
                withAnimation {
                    self.isTitleUp = true
                }
            }
        } else {
            DispatchQueue.main.async {
                withAnimation {
                    self.isTitleUp = false
                }
            }
        }
        if offset < 20 {
            DispatchQueue.main.async {
                withAnimation {
                    self.isSearchBarUp = true
                }
            }
        } else {
            DispatchQueue.main.async {
                withAnimation {
                    self.isSearchBarUp = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct NavBar: View { //Scroll Up시 나타나는 NavBar. 천천히 올리다보면 title먼저 들어가고 SearchBar가 이후에 들어가는 모습 보일겁니당
    @Binding var isTitleUp: Bool
    @Binding var isSearchBarUp: Bool
    @Binding var searchText: String
    
    var body: some View {
        if isTitleUp {
            VStack(spacing: 0) {
                Spacer().frame(height: 50)
                HStack {
                    Spacer()
                    Text("장학금 목록")
                        .bold()
                        .padding(.bottom, 5)
                    Spacer()
                }
                if isSearchBarUp {
                    SearchBar("Search", text: $searchText)
                        .foregroundColor(.black)
                        .textFieldBackgroundColor(.white.withAlphaComponent(0.2))
                        .padding(.horizontal, 20)
                        .offset(y: -5)
                }
            }
            .background(
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white.opacity(0.1))
                    .blur(radius: 10)
                    .background(
                        VisualEffectBlurView(blurStyle: .systemUltraThinMaterialLight)
                    )
            )
        }
    }
}
