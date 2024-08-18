let currentClueValue = 0;
let currentClueAnswer = '';
let questionTimer;
let answerTimer;
let roundData;

function initializeGame() {
    debugger;
    console.log("Initializing game");
    const gameContainer = document.querySelector('.game-container');

    try {
        roundData = JSON.parse(gameContainer.dataset.round1);
    } catch (error) {
        console.error("Error parsing round data:", error);
        return;
    }

    document.querySelectorAll('.game-board td').forEach(cell => {
        cell.addEventListener('click', function() {
            const category = this.dataset.category;
            const value = this.dataset.value;
            showQuestion(category, value);
            this.style.backgroundColor = '#000080';
            this.innerHTML = '';
        });
    });
}

function showQuestion(category, value) {
    const clue = roundData[category][value];

    currentClueValue = value;
    currentClueAnswer = clue.answer;
    document.querySelector('.popover-question').textContent = clue.question;
    document.querySelector('.overlay').style.display = 'block';
    document.querySelector('.popover').style.display = 'block';
    document.querySelector('.question-timer').style.display = 'block';
    document.querySelector('.question-timer').textContent = '10';
    document.querySelector('.buzzer').style.display = 'block';

    clearInterval(questionTimer);
    questionTimer = setInterval(quesTimer, 1000);
}

function handleBuzzIn() {
    clearInterval(questionTimer);
    document.querySelector('.answer-timer').style.display = 'block';
    document.querySelector('.answer-timer').textContent = '15';
    document.querySelector('.buzzer').style.display = 'none';
    document.querySelector('.answer-form').style.display = 'block';
    document.querySelector('.answer-input').focus();

    clearInterval(answerTimer);
    answerTimer = setInterval(ansTimer, 1000);
}

function ansTimer() {
    const timer = document.querySelector('.answer-timer');
    let timeLeft = parseInt(timer.textContent);
    timeLeft--;
    timer.textContent = timeLeft.toString();
    if (timeLeft <= 0) {
        clearInterval(answerTimer);
        handleAnswerSubmit(null, true); // Time's up, handle as incorrect answer
    }
}

function quesTimer() {
    const timer = document.querySelector('.question-timer');
    let timeLeft = parseInt(timer.textContent);
    timeLeft--;
    timer.textContent = timeLeft.toString();
    if (timeLeft <= 0) {
        hidePopover();
        alert("The correct answer was: " + currentClueAnswer);
    }
}

function handleAnswerSubmit(event, timedOut = false) {
    if (event) event.preventDefault();
    clearInterval(answerTimer);

    const userAnswer = timedOut ? "" : document.querySelector('.answer-input').value.trim().toLowerCase();
    const correctAnswer = currentClueAnswer.toLowerCase();

    if (userAnswer === correctAnswer) {
        updateScore(currentClueValue);
        alert("Correct! You won " + currentClueValue + " points.");
    } else {
        updateScore(-currentClueValue);
        alert("Sorry, that's incorrect. The correct answer was: " + correctAnswer);
    }

    hidePopover();
}

function updateScore(points) {
    const playerScore = document.getElementById('player-score');
    playerScore.textContent = parseInt(playerScore.textContent) + parseInt(points);
}

function hidePopover() {
    clearInterval(questionTimer);
    clearInterval(answerTimer);
    document.querySelector('.answer-form').style.display = 'none';
    document.querySelector('.answer-input').value = '';
    document.querySelector('.answer-timer').style.display = 'none';
    document.querySelector('.overlay').style.display = 'none';
    document.querySelector('.popover').style.display = 'none';
}

document.addEventListener('turbo:load', initializeGame);