+++
title = "Lessons"
lessons =  [("lessons/week1.md","week1"),
            ("lessons/week2.md","week2"),
            ("lessons/week3.md","week3"),
            ("lessons/week4.md","week4"),
            ("lessons/week5.md","week5"),
            ("lessons/week6.md","week6"),
            ("lessons/week7.md","week7"),
            ("lessons/week8.md","week8"),
            ("lessons/week9.md","week9"),
            ("lessons/week10.md","week10"),
            ("lessons/week11.md","week11"),
            ("lessons/week12.md","week12"),
            ("lessons/week13.md","week13"),
            ("lessons/week14.md","week14"),
            ("lessons/week15.md","week15"),
            ("lessons/week16.md","week16"),
            ]
+++

## Lessons
{{for (page,lesson) in lessons }}
- Week {{fill week_num page}}: [{{lesson}}]({{fill topic page}})
{{end}}

\\

See also [labs](/labs/).
