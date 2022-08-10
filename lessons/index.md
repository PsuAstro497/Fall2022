+++
title = "Lessons"
lessons =  [("lessons/week1.md","week1"),
            ("lessons/week2.md","week2"),
            ("lessons/week3.md","week3"),
            ("lessons/week4.md","week4"),
            ("lessons/week5.md","week5"),
            ("lessons/week6.md","week6"),
            ("lessons/week7.md","week7"),
                                                ]
+++

## Lessons
{{for (page,lesson) in lessons }}
- Week {{fill week_num page}}: [{{lesson}}]({{fill topic page}})
{{end}}
