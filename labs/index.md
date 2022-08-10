+++
title = "Labs"
tags = ["labs", "logistics"]
lab_list = [("labs/lab1.md","lab1"),
            ("labs/lab2.md","lab2"),
            ("labs/lab3.md","lab3"),
            ("labs/lab4.md","lab4"),
            ("labs/lab5.md","lab5"),
            ("labs/lab6.md","lab6"),
            ("labs/lab7.md","lab7"),
            ("labs/lab8.md","lab8"),
            ("labs/lab9.md","lab9"),
             ]
+++

## Lab/Homework Exercises

{{for (page,lab) in lab_list }}
- Lab {{fill lab_num page}}: [{{lab}}]({{fill title page}})
{{end}}

