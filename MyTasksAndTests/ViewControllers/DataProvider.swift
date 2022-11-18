//
//  DataProvider.swift
//  MyTasksAndTests
//
//  Created by Артем Павлов on 16.11.2022.
//

//нужен, чтобы разгрузить логику taskListViewControllera
import UIKit

//тип NSObject так как мы подгружаем со сториборда
class DataProvider: NSObject {
    
}

extension DataProvider: UITableViewDelegate {
}

extension DataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
