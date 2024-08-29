let currentClue;
let currentCatNum;
let gameId;
let updateUrl;

let questionTimer;
let answerTimer;

function initializeGame() {
    console.log("Initializing game");
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
    document.querySelector('.question-timer').textContent = '10';
    document.querySelector('.buzzer-btn').style.display = 'inline-block';

    clearInterval(questionTimer);
    questionTimer = setInterval(quesTimer, 1000);
}

function handleBuzzIn() {
    clearInterval(questionTimer);

    document.querySelector('.question-timer').style.display = 'none';
    document.querySelector('.answer-timer').style.display = 'block';
    document.querySelector('.answer-timer').textContent = '15';
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
            alert(`Correct! (${data.correct_answer})`);
        } else {
            alert("Sorry, the correct answer was: " + data.correct_answer);
        }
        document.getElementById('player-score').textContent = `$${data.new_score}`;
    })
    .catch(error => {
        console.error('Error:', error);
        alert('An error occurred while submitting your answer.');
    });

    hidePopover();
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