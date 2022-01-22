#include "types.h"
#include "mmu.h"
#include "param.h"
#include "proc.h"
#include "user.h"
#include "pstat.h"

#undef USE_YIELD
#define MAX_CHILDREN 32
#define LARGE_TICKET_COUNT 100000
#define MAX_YIELDS_FOR_SETUP 100

__attribute__((noreturn))
void yield_forever() {
    while (1) {
        yield();
    }
}

__attribute__((noreturn))
void run_forever() {
    while (1) {
        __asm__("");
    }
}

int spawn(int tickets) {
    int pid = fork();
    if (pid == 0) {
        settickets(tickets);
        yield();
#ifdef USE_YIELD
        yield_forever();
#else
        run_forever();
#endif
    } else if (pid != -1) {
        return pid;
    } else {
        printf(2, "error in fork\n");
        return -1;
    }
}

int find_index_of_pid(int *list, int list_size, int pid) {
    for (int i = 0; i < list_size; ++i) {
        if (list[i] == pid)
            return i;
    }
    return -1;
}

void wait_for_ticket_counts(int num_children, int *pids, int *tickets) {
    for (int yield_count = 0; yield_count < MAX_YIELDS_FOR_SETUP; ++yield_count) {
        yield();
        int done = 1;
        struct pstat info;
        getpinfo(&info);
        for (int i = 0; i < num_children; ++i) {
            int index = find_index_of_pid(info.pid, NPROC, pids[i]);
            if (info.tickets[index] != tickets[i]) done = 0;
        }
        if (done)
            break;
    }
}

int num_of_proc(struct pstat *p)
{
    int ans = 0;
    for(int i = 0; i<NPROC; i++)
    {
        if(p->pid[i]!=0) ans++;
    }
    return ans;
}

int main(int argc, char *argv[])
{
    if (argc < 3) {
        printf(2, "usage: %s seconds tickets1 tickets2 ... ticketsN\n"
                  "       seconds is the number of time units to run for\n"
                  "       ticketsX is the number of tickets to give to subprocess N\n",
                  argv[0]);
        exit();
    }
    int tickets_for[MAX_CHILDREN];
    int active_pids[MAX_CHILDREN];
    int num_seconds = atoi(argv[1]);
    int num_children = argc - 2;
    if (num_children > MAX_CHILDREN) {
        printf(2, "only up to %d supported\n", MAX_CHILDREN);
        exit();
    }
    /* give us a lot of ticket so we don't get starved */
    settickets(LARGE_TICKET_COUNT);
    for (int i = 0; i < num_children; ++i) {
        int tickets = atoi(argv[i + 2]);
        tickets_for[i] = tickets;
        active_pids[i] = spawn(tickets);
    }
    wait_for_ticket_counts(num_children, active_pids, tickets_for);
    struct pstat before, after;
    // before.num_processes = after.num_processes = -1;
    getpinfo(&before);
    sleep(num_seconds);
    getpinfo(&after);
    for (int i = 0; i < num_children; ++i) {
        kill(active_pids[i]);
    }
    for (int i = 0; i < num_children; ++i) {
        wait();
    }
    if (num_of_proc(&before) >= NPROC || num_of_proc(&after) >= NPROC) {
        printf(2, "getprocessesinfo's num_processes is greater than NPROC before parent slept\n");
        return 1;
    }
    if (num_of_proc(&before) < 0 || num_of_proc(&after) < 0) {
        printf(2, "getprocessesinfo's num_processes is negative -- not changed by syscall?\n");
        return 1;
    }
    printf(1, "TICKETS\tTICKS\n");
    for (int i = 0; i < num_children; ++i) {
        int before_index = find_index_of_pid(before.pid, num_of_proc(&before), active_pids[i]);
        int after_index = find_index_of_pid(after.pid, num_of_proc(&after), active_pids[i]);
        if (before_index == -1)
            printf(2, "child %d did not exist for getprocessesinfo before parent slept\n", i);
        if (after_index == -1)
            printf(2, "child %d did not exist for getprocessesinfo after parent slept\n", i);
        if (before_index == -1 || after_index == -1) {
            printf(1, "%d\t--unknown--\n", tickets_for[i]);
        } else {
            if (before.tickets[before_index] != tickets_for[i]) {
                printf(2, "child %d had wrong number of tickets in getprocessinfo before parent slept\n", i);
            }
            if (after.tickets[after_index] != tickets_for[i]) {
                printf(2, "child %d had wrong number of tickets in getprocessinfo after parent slept\n", i);
            }
            printf(1, "%d\t%d\n", tickets_for[i], after.ticks[after_index] - before.ticks[before_index]);
        }
    }
    exit();
}