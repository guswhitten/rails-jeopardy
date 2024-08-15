// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


console.log("Script is running");

const gameContainer = document.querySelector('.game-container');
const roundData = JSON.parse(gameContainer.dataset.round1);

document.querySelectorAll('.game-board td').forEach(cell => {
    cell.addEventListener('click', function() {
        const category = this.dataset.category;
        const value = this.dataset.value;
        showQuestion(category, value);
        this.style.backgroundColor = '#000080';
        this.innerHTML = '';
    });
});

function showQuestion(category, value) {
    const clue = roundData[category][value];

    document.querySelector('.popover-question').textContent = clue.question;
    document.querySelector('.overlay').style.display = 'block';
    document.querySelector('.popover').style.display = 'block';

    startTimer();
}

function startTimer() {
    let timeLeft = 5;
    const timerElement = document.querySelector('.popover-timer');

    const timerId = setInterval(() => {
        timeLeft--;
        timerElement.textContent = timeLeft;

        if (timeLeft <= 0) {
            clearInterval(timerId);
            hidePopover();
        }
    }, 1000);
}

function hidePopover() {
    document.querySelector('.overlay').style.display = 'none';
    document.querySelector('.popover').style.display = 'none';
}

document.querySelector('.overlay').addEventListener('click', hidePopover);