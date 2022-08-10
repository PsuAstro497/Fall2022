+++
lessons =  ["lessons/week1.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            "lessons/week2.md",
            ]
+++

## Course Topics
~~~
<ul>
{{for page in lessons }}
  <li>
    {{fill topic page }}
  </li>
{{end}}
</ul>
~~~
