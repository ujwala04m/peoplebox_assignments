const grid = document.getElementById('grid');
const info = document.getElementById('info');
const restartButton = document.getElementById('restart');

let currentPlayer = 'X';
let board = Array(9).fill(null);
let gameActive = true;

const winningCombinations = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  [0, 4, 8], [2, 4, 6]
];

function createGrid() {
  grid.innerHTML = '';
  board.forEach((_, index) => {
    const cell = document.createElement('div');
    cell.classList.add('cell');
    cell.dataset.index = index;
    cell.addEventListener('click', handleCellClick);
    grid.appendChild(cell);
  });
}

function handleCellClick(e) {
  const cell = e.target;
  const index = cell.dataset.index;

  if (board[index] || !gameActive) return;

  board[index] = currentPlayer;
  cell.textContent = currentPlayer;
  cell.classList.add('disabled');
  cell.classList.add(currentPlayer === 'X' ? 'player-x' : 'player-o');

  if (checkWinner()) {
    info.innerHTML = `Player <span class="player-${currentPlayer.toLowerCase()}">${currentPlayer}</span> wins!`;
    highlightWinningCells();
    gameActive = false;
  } else if (board.every(cell => cell)) {
    info.textContent = 'It’s a draw!';
    gameActive = false;
  } else {
    currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
    info.innerHTML = `Player <span class="player-${currentPlayer.toLowerCase()}">${currentPlayer}</span>'s turn`;
  }
}

function checkWinner() {
  return winningCombinations.some(combination => {
    const [a, b, c] = combination;
    return board[a] && board[a] === board[b] && board[a] === board[c];
  });
}

function highlightWinningCells() {
  winningCombinations.forEach(combination => {
    const [a, b, c] = combination;
    if (board[a] && board[a] === board[b] && board[a] === board[c]) {
      document.querySelectorAll('.cell')[a].classList.add('winning');
      document.querySelectorAll('.cell')[b].classList.add('winning');
      document.querySelectorAll('.cell')[c].classList.add('winning');
    }
  });
}

function restartGame() {
  board = Array(9).fill(null);
  currentPlayer = 'X';
  gameActive = true;
  info.innerHTML = `Player <span class="player-x">${currentPlayer}</span>'s turn`;
  createGrid();
}

restartButton.addEventListener('click', restartGame);

createGrid();
