#include "types.h"
#include "mmu.h"
#include "param.h"
#include "proc.h"
#include "user.h"
#include "pstat.h"
int main(int argc, char *argv[])
{
    struct pstat info;
    getpinfo(&info);
   //  printf(1, "%d running processes\n", info.num_processes);
    printf(1, "PID\tTICKETS\tTICKS\n");
    for(int i =0; i<NPROC; i++) {
       if(info.pid[i]!=0) {
          printf(1, "%d\t%d\t%d\n", info.pid[i], info.tickets[i], info.ticks[i]);
       }
    }
   //  printf(1, "%d running processes\n", info.num_processes);
   //  printf(1, "PID\tTICKETS\tTICKS\n");
   //  for (int i = 0; i < info.num_processes; ++i) {
   //      printf(1, "%d\t%d\t%d\n", info.pids[i], info.tickets[i], info.ticks[i]);
   //  }
    exit();
}