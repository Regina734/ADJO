import 'package:flutter/material.dart';
import 'package:adjo/mock-data/mock-data.dart';

class DailyQuizScreen extends StatefulWidget {
  const DailyQuizScreen({Key? key}) : super(key: key);

  @override
  State<DailyQuizScreen> createState() => _DailyQuizScreenState();
}

class _DailyQuizScreenState extends State<DailyQuizScreen> {
  int _currentQuestionIndex = 0;
  int _selectedAnswerIndex = -1;
  int _totalScore = 0;
  bool _isAnswered = false;

  late List<Map<String, dynamic>> _quizzes;

  @override
  void initState() {
    super.initState();
    _quizzes = List.from(MockData.dailyQuizzes)..shuffle();
  }

  void _submitAnswer() {
    if (_selectedAnswerIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an answer'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isAnswered = true;
      if (_selectedAnswerIndex ==
          _quizzes[_currentQuestionIndex]['correctAnswer']) {
        _totalScore += (_quizzes[_currentQuestionIndex]['points'] as int);
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quizzes.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswerIndex = -1;
        _isAnswered = false;
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text(
            'Quiz Complete!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Text(
                '${((_totalScore / (_quizzes.length * 100)) * 100).toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Color(0xFFFDB834),
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Score: $_totalScore / ${_quizzes.length * 100}',
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDB834).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFDB834), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFDB834), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '+$_totalScore ADJO Points',
                        style: const TextStyle(
                          color: Color(0xFFFDB834),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                'Done',
                style: TextStyle(color: Color(0xFFFDB834)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuiz = _quizzes[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Question ${_currentQuestionIndex + 1}/${_quizzes.length}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / _quizzes.length,
                  minHeight: 4,
                  backgroundColor: Colors.grey[800],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFFDB834),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Difficulty: ${currentQuiz['difficulty'].toString().toUpperCase()}',
                    style: TextStyle(
                      color: _getDifficultyColor(currentQuiz['difficulty']),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFDB834),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '+${currentQuiz['points']} pts',
                        style: const TextStyle(
                          color: Color(0xFFFDB834),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                currentQuiz['question'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(currentQuiz['options'].length, (index) {
                final option = currentQuiz['options'][index];
                final isSelected = _selectedAnswerIndex == index;
                final isCorrect = index == currentQuiz['correctAnswer'];
                final showCorrect = _isAnswered && isCorrect;
                final showIncorrect = _isAnswered && isSelected && !isCorrect;

                return GestureDetector(
                  onTap: _isAnswered
                      ? null
                      : () => setState(() => _selectedAnswerIndex = index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: showCorrect
                            ? Colors.green
                            : showIncorrect
                            ? Colors.red
                            : isSelected
                            ? const Color(0xFFFDB834)
                            : Colors.grey[800]!,
                        width: isSelected || showCorrect || showIncorrect
                            ? 2
                            : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: showCorrect
                          ? Colors.green.withOpacity(0.1)
                          : showIncorrect
                          ? Colors.red.withOpacity(0.1)
                          : isSelected
                          ? const Color(0xFFFDB834).withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: showCorrect
                                  ? Colors.green
                                  : showIncorrect
                                  ? Colors.red
                                  : isSelected
                                  ? const Color(0xFFFDB834)
                                  : Colors.grey[600]!,
                              width: 2,
                            ),
                            color: showCorrect
                                ? Colors.green.withOpacity(0.2)
                                : showIncorrect
                                ? Colors.red.withOpacity(0.2)
                                : isSelected
                                ? const Color(0xFFFDB834).withOpacity(0.2)
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: showCorrect
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 14,
                                  )
                                : showIncorrect
                                ? const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 14,
                                  )
                                : isSelected
                                ? Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFDB834),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              if (_isAnswered) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDB834).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFFDB834),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Explanation:',
                        style: TextStyle(
                          color: Color(0xFFFDB834),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentQuiz['explanation'],
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isAnswered ? _nextQuestion : _submitAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFDB834),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _isAnswered
                        ? (_currentQuestionIndex < _quizzes.length - 1
                              ? 'Next Question'
                              : 'Finish')
                        : 'Submit Answer',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return Colors.red;
      default:
        return Colors.grey[400]!;
    }
  }
}
