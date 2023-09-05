String dateDifference(String date) {
  final now = DateTime.now();
  try {
    final other = DateTime.parse(date);
    final difference = other.difference(now);

    if (difference.inMinutes <= 59) {
      return '${difference.inMinutes} minutes';
    } else if (difference.inHours <= 24) {
      return '${difference.inHours} hours';
    } else {
      return '${difference.inDays} days';
    }
  } catch (e) {
    return "Invalid Date";
  }
}

int foldNumber(List<int> numbs) {
  return numbs.fold(0, (previousValue, element) => previousValue + element);
}

final questions = [
  {
    'type': 'The Perfectionist',
    'question': 'I spend a lot of time analyzing the things I do'
  },
  {
    'type': 'The Creative avoider',
    'question': 'I tend to have unrealistic dreams about the future'
  },
  {
    'type': 'The Pleasure seeker',
    'question': 'I get bored easily and need constant stimulation'
  },
  {
    'type': 'The Perfectionist',
    'question': 'I put a lot of pressure on myself when accomplishing things'
  },
  {
    'type': 'The Creative avoider',
    'question': 'I have a hard time saying no when someone ask for help'
  },
  {
    'type': 'The Pleasure seeker',
    'question':
        'I find it hard to finish a project without being distracted by other ideas'
  },
  {
    'type': 'The Perfectionist',
    'question':
        'I tend to avoid starting a project unless I am certain the outcome will match my expectation'
  },
  {
    'type': 'The Creative avoider',
    'question': 'I always find myself busy all the time'
  },
  {
    'type': 'The Pleasure seeker',
    'question': 'I hate to take risks even if they come with great rewards'
  },
  {'type': 'The Perfectionist', 'question': 'I am very detail- focused'},
  {
    'type': 'The Creative avoider',
    'question': 'I tend to focus on the big picture instead of the details'
  },
  {'type': 'The Pleasure seeker', 'question': 'I work better under pressure'},
  {
    'type': 'The Perfectionist',
    'question':
        'I spend a lot of time preparing before starting a task or project.'
  },
  {
    'type': 'The Creative avoider',
    'question': 'I have a hard time prioritizing my tasks'
  },
  {
    'type': 'The Pleasure seeker',
    'question':
        'I wait until the last minute to start important tasks and projects.'
  },
];

final Map<String, List<String>> personalitySuggestions = {
  "The Perfectionist": [
    "Create a step-by-step plan to achieve this task",
    "Ask yourself one question that will just get you started e.g. What can I need to do right now in the next 10 minutes as part of this project? (And then start with it)",
    "Don’t pay too much attention to the finished result more than the little steps"
  ],
  "The Creative avoider": [
    "Create a step-by-step plan to achieve this task",
    "There are a few warning signs you should look out for to avoid procrastination on this task e.g. \r\n\tI have so many more important things to do than this\r\n\tI am not sure what to do, I’ll wait for more information\r\n\tI work better under the pressure of time.",
    "Identify the words you say to yourself when you are about to procrastinate and change the action you will take in favor of your project when you hear yourself saying those words."
  ],
  "The Pleasure seeker": [
    "Create a step-by-step plan to achieve this task",
    "Be ready to make some sacrifices by taking responsibility for this project e.g. \r\n\tCreating time for this project\r\n\tTurn off things that you enjoy doing during this time",
    "Celebrate your little successes on and during this project."
  ]
};
