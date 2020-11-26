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

br
br

h3 Logs
h4 Error Logs
    pre
        code = error_logs 

h4 Informational Logs
    pre
        code = info_logs

