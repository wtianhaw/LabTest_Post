//
//  PostVM.swift
//  LabTest
//
//  Created by Wong Tian Haw on 06/07/2022.
//

import Foundation
import Combine

final class PostVM: BaseViewModel, ObservableObject {
    
    private lazy var request: PostListRequest = {
        return PostListRequest()
    }()
    
    // MARK: Input
    private let searchSubject = PassthroughSubject<Void, Never>()
    
    enum Input {
        case list
        case getMoreData
    }
    
    func apply(_ input: Input) {
        switch input {
        case .list:
            self.page = 1
            self.isNotfirstPage = false
            self.request.params = ["page" : "\(self.page)", "pageSize" : "10"]
            self.searchSubject.send(())
        case .getMoreData:
            if self.searchResultList.count > self.totalNumber {
                return
            }
            self.page += 1
            self.isNotfirstPage = true
            self.request.params = ["page" : "\(self.page)", "pageSize" : "10"]
            self.searchSubject.send(())
        }
    }
    
    // MARK: Output
    @Published var searchResultList: [Datum] = []
    let responseSubject = PassthroughSubject<PostListResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private lazy var apiService: APIService = {
        return APIService()
    }()
    
    override init() {
        super.init()
        
        self.bindInputs()
        self.bindOutputs()
    }
    
    private func bindInputs() {
        self.bindTableLoading(loading: self.apiService.apiLoading)
        
        self.bindApiService(request: self.request, apiService: self.apiService, trigger: self.searchSubject) { [weak self] data in
            guard let `self` = self else { return }
            self.responseSubject.send(data)
        }
        
    }
    
    private func bindOutputs() {
        self.responseSubject
            .print()
            .map {
//                self.totalNumber = $0.totalCount ?? 0
                
                if self.isNotfirstPage {
                    let new: [Datum] = $0.data ?? []
                    self.searchResultList += new
                }else {
                    self.searchResultList = $0.data ?? []
                    self.footLoading = false
                }
                return self.searchResultList
            }
            .assign(to: \.self.searchResultList, on: self)
            .store(in: &self.cancellables)
    }
    
}
