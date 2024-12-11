//
//  KhulnaSoftConsumerPayload.swift
//  KhulnaSoft
//
//  Created by Manoel Aranda Neto on 13.10.23.
//

import Foundation

struct KhulnaSoftConsumerPayload {
    let events: [KhulnaSoftEvent]
    let completion: (Bool) -> Void
}
