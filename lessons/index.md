+++
title = "Lessons"
lessons =  [("lessons/week1.md","week1"),
            ("lessons/week2.md","week2"),
            ("lessons/week3.md","week3"),
            ]
+++

## Lessons
{{for (page,lesson) in lessons }}
- Week {{fill week_num page}}: [{{lesson}}]({{fill topic page}})
{{end}}
