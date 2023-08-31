String dateDifference(String date) {
  final now = DateTime.now();
  final other = DateTime.parse(date);
  final difference = other.difference(now);

  if (difference.inMinutes <= 59) {
    return '${difference.inMinutes} minutes';
  } else if (difference.inHours <= 24) {
    return '${difference.inHours} hours';
  } else {
    return '${difference.inDays} days';
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