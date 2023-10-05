//
//  Publisher+Extension.swift
//  AppStoreCloneTest
//
//  Created by DOYEON JEONG on 2023/10/06.
//

import Combine

extension Publisher {
    /// 실패하는 Publisher를 쉽게 생성하기 위한 메서드
    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error).eraseToAnyPublisher()
    }
}
