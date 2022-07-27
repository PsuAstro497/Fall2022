+++
title = "Lessons"
lessons =  [(1,"lessons/week1.md","week1"),
            (2,"lessons/week2.md","week2"),
            (3,"lessons/week3.md","week3"),
            ]
+++

## Lessons
{{for (week,page,url) in lessons }}
- Week {{week}}: [{{url}}]({{fill topic page }})
{{end}}
