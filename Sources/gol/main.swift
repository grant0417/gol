import Foundation

class GolBoard {
    var board: [Bool]
    var xSize: Int
    var ySize: Int

    init(xSize: Int, ySize: Int) {
        self.xSize = xSize;
        self.ySize = ySize;
        self.board = Array(repeating: false, count: xSize * ySize)
    }

    init(board: [Bool], xSize: Int, ySize: Int) {
        self.board = board;
        self.xSize = xSize;
        self.ySize = ySize;
    }

    func getCell(x: Int, y: Int) -> Bool {
        if (x < 0 || x >= xSize || y < 0 || y >= ySize) {
            return false
        }
        return board[x + y * xSize]
    }

    func setCell(x: Int, y: Int, value: Bool) {
        board[x + y * xSize] = value
    }

    func getNeighbours(x: Int, y: Int) -> Int {
        var neighbours = 0
        for i in -1...1 {
            for j in -1...1 {
                if (i == 0 && j == 0) {
                    continue
                } else if (getCell(x: x + i, y: y + j)) {
                    neighbours += 1
                }
            }
        }
        return neighbours
    }

    func getNextState(x: Int, y: Int) -> Bool {
        let neighbours = getNeighbours(x: x, y: y)
        if neighbours < 2 {
            return false
        } else if neighbours == 2 {
            return getCell(x: x, y: y)
        } else if neighbours == 3 {
            return true
        } else {
            return false
        }
    }

    func getNextState() -> GolBoard {
        let nextBoard = GolBoard(xSize: xSize, ySize: ySize)
        for i in 0..<ySize {
            for j in 0..<xSize {
                nextBoard.setCell(x: j, y: i, value: getNextState(x: j, y: i))
            }
        }
        return nextBoard
    }

    func printBoard() {
        for i in 0..<ySize {
            for j in 0..<xSize {
                if (getCell(x: j, y: i)) {
                    print("█", terminator: "")
                } else {
                    print(" ", terminator: "")
                }
            }
            print("")
        }
    }
}

// Bottom right glider
var glider = GolBoard(xSize: 10, ySize: 10)
glider.setCell(x: 0, y: 0, value: true)
glider.setCell(x: 2, y: 0, value: true)
glider.setCell(x: 1, y: 1, value: true)
glider.setCell(x: 2, y: 1, value: true)
glider.setCell(x: 1, y: 2, value: true)

while true {
    print("\u{1B}[2J")
    glider.printBoard()
    Thread.sleep(forTimeInterval: 0.5)
    glider = glider.getNextState()
}

