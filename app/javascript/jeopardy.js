let currentClue;
let currentCatNum;
let gameId;
let updateUrl;
let questionTimer;
let answerTimer;
let botDifficulty;
let botBuzzInTimeout;

const botSettings = {
    Easy: {
        buzzInChance: 0.35,
        correctAnswerChance: 0.45,
        minBuzzInTime: 3,
        maxBuzzInTime: 7
    },
    Medium: {
        buzzInChance: 0.55,
        correctAnswerChance: 0.6,
        minBuzzInTime: 3,
        maxBuzzInTime: 5
    },
    Hard: {
        buzzInChance: 0.65,
        correctAnswerChance: 0.78,
        minBuzzInTime: 2,
        maxBuzzInTime: 4
    }
};


function initializeGame() {
    console.log("Initializing game");

    botDifficulty = document.querySelector('.game-container').dataset.botDifficulty;
    document.querySelector('.game-overlay').style.display = 'none';
    document.querySelectorAll('.game-board td').forEach(cell => {
        const clueData = JSON.parse(cell.dataset.clue);

        if (clueData == null || clueData['answered']) {
            // If the clue is already answered, set the background color without adding the event listener
            cell.style.backgroundColor = '#000080';
            cell.textContent = '';
        } else {
            const clickHandler = function() {
                showQuestion(this.dataset);
                this.style.backgroundColor = '#000080';
                cell.textContent = '';

                cell.removeEventListener('click', clickHandler);
            };

            cell.addEventListener('click', clickHandler);
        }
    });
}

function showQuestion(dataset) {
    currentClue = JSON.parse(dataset.clue);
    currentCatNum = dataset.catNum;
    gameId = dataset.gameId;
    updateUrl = dataset.updateUrl;

    document.querySelector('.popover-question').textContent = currentClue.question?.replace(/^'|'$/g, "");
    document.querySelector('.overlay').style.display = 'block';
    document.querySelector('.popover').style.display = 'block';
    document.querySelector('.question-timer').style.display = 'block';
    document.querySelector('.question-timer').textContent = '8';
    document.querySelector('.buzzer-btn').style.display = 'inline-block';
    document.querySelector('.bot-buzzed').style.display = 'none';

    clearInterval(questionTimer);
    questionTimer = setInterval(quesTimer, 1000);
    botBuzzInTimeout = setTimeout(botDecideToBuzzIn, getRandomBuzzInTime());
}

function getRandomBuzzInTime() {
    const { minBuzzInTime, maxBuzzInTime } = botSettings[botDifficulty];
    return Math.floor(Math.random() * (maxBuzzInTime - minBuzzInTime + 1) + minBuzzInTime) * 1000;
}

function botDecideToBuzzIn() {
    if (Math.random() < botSettings[botDifficulty].buzzInChance) {
        clearInterval(questionTimer);
        document.querySelector('.question-timer').style.display = 'none';
        document.querySelector('.buzzer-btn').style.display = 'none';
        document.querySelector('.bot-buzzed').style.display = 'block';
        document.querySelector('.bot-buzzed').textContent = 'Bot Buzzed!';

        fetch(`/games/${gameId}/bot_buzzed`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
            },
            body: JSON.stringify({
                clue_id: currentClue['id'],
                cat_num: currentCatNum,
                correct_answer_chance: botSettings[botDifficulty].correctAnswerChance,
                clue_value: currentClue['value']
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.bot_is_correct) {
                    customAlert(`Bot correctly guessed \n${data.correct_answer}`, hidePopover);
                } else {
                    customAlert(`Bot was wrong. Correct answer was\n${data.correct_answer}`, hidePopover);
                }
                document.getElementById('bot-score').textContent = `$${data.bot_new_score}`;
            })
            .catch(error => {
                console.error('Error:', error);
                customAlert('An error occurred while submitting your answer.', hidePopover);
            });
    }
}

function handleBuzzIn() {
    clearTimeout(botBuzzInTimeout);
    clearInterval(questionTimer);

    document.querySelector('.question-timer').style.display = 'none';
    document.querySelector('.answer-timer').style.display = 'block';
    document.querySelector('.answer-timer').textContent = '10';
    document.querySelector('.buzzer-btn').style.display = 'none';
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
        handleQuestionTimeout();
        hidePopover();
    }
}

function handleAnswerSubmit(event, timedOut = false) {
    if (event) event.preventDefault();
    clearInterval(answerTimer);

    const userAnswer = document.querySelector('.answer-input').value;

    fetch(updateUrl, {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
            answer: userAnswer,
            clue_id: currentClue['id'],
            cat_num: currentCatNum,
            clue_value: currentClue['value']
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.correct) {
            customAlert(`Correct!\n${data.correct_answer}`, hidePopover);
        } else {
            customAlert(`Sorry, the correct answer was:\n ${data.correct_answer}`, hidePopover);
        }
        document.getElementById('player-score').textContent = `$${data.new_score}`;
    })
    .catch(error => {
        console.error('Error:', error);
        customAlert('An error occurred while submitting your answer.', hidePopover);
    });
}

function handleQuestionTimeout() {
    clearInterval(questionTimer);

    fetch(updateUrl, {
        method: 'PATCH',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
            time_out: true,
            clue_id: currentClue['id'],
            cat_num: currentCatNum,
            clue_value: currentClue['value']
        })
    })
        .then(response => response.json())
        .then(data => {
            customAlert(`The correct answer was:\n ${data.correct_answer}`, hidePopover);
        })
        .catch(error => {
            console.error('Error:', error);
            customAlert('An error occurred while submitting your answer.', hidePopover);
        });
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

function customAlert(message, callback) {
    alert(message);
    if (callback) callback();
}