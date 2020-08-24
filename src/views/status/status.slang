h1 Status

h3 Redis Queue
table
    tr
        th Tasks 
    - if tasks
        - tasks.each do | task |
            tr
                td = task
        th Pending
    - if pendings
        - pendings.each do | pending |
            tr
                td = pending

