
_masum4:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    }
    return ans;
}

int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	81 ec 18 09 00 00    	sub    $0x918,%esp
  1b:	8b 01                	mov    (%ecx),%eax
  1d:	8b 79 04             	mov    0x4(%ecx),%edi
  20:	89 85 dc f6 ff ff    	mov    %eax,-0x924(%ebp)
  26:	89 bd e0 f6 ff ff    	mov    %edi,-0x920(%ebp)
    if (argc < 3) {
  2c:	83 f8 02             	cmp    $0x2,%eax
  2f:	0f 8e 5f 02 00 00    	jle    294 <main+0x294>
                  argv[0]);
        exit();
    }
    int tickets_for[MAX_CHILDREN];
    int active_pids[MAX_CHILDREN];
    int num_seconds = atoi(argv[1]);
  35:	8b 85 e0 f6 ff ff    	mov    -0x920(%ebp),%eax
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	ff 70 04             	pushl  0x4(%eax)
  41:	e8 ca 06 00 00       	call   710 <atoi>
    int num_children = argc - 2;
    if (num_children > MAX_CHILDREN) {
  46:	83 c4 10             	add    $0x10,%esp
    int num_seconds = atoi(argv[1]);
  49:	89 85 d8 f6 ff ff    	mov    %eax,-0x928(%ebp)
    int num_children = argc - 2;
  4f:	8b 85 dc f6 ff ff    	mov    -0x924(%ebp),%eax
  55:	83 e8 02             	sub    $0x2,%eax
  58:	89 85 e4 f6 ff ff    	mov    %eax,-0x91c(%ebp)
    if (num_children > MAX_CHILDREN) {
  5e:	83 f8 20             	cmp    $0x20,%eax
  61:	0f 8f 19 02 00 00    	jg     280 <main+0x280>
        printf(2, "only up to %d supported\n", MAX_CHILDREN);
        exit();
    }
    /* give us a lot of ticket so we don't get starved */
    settickets(LARGE_TICKET_COUNT);
  67:	83 ec 0c             	sub    $0xc,%esp
    for (int i = 0; i < num_children; ++i) {
  6a:	31 f6                	xor    %esi,%esi
  6c:	8d bd 68 f7 ff ff    	lea    -0x898(%ebp),%edi
    settickets(LARGE_TICKET_COUNT);
  72:	68 a0 86 01 00       	push   $0x186a0
  77:	89 f3                	mov    %esi,%ebx
  79:	e8 a5 07 00 00       	call   823 <settickets>
    for (int i = 0; i < num_children; ++i) {
  7e:	8b b5 e0 f6 ff ff    	mov    -0x920(%ebp),%esi
  84:	83 c4 10             	add    $0x10,%esp
  87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8e:	66 90                	xchg   %ax,%ax
        int tickets = atoi(argv[i + 2]);
  90:	83 ec 0c             	sub    $0xc,%esp
  93:	ff 74 9e 08          	pushl  0x8(%esi,%ebx,4)
  97:	e8 74 06 00 00       	call   710 <atoi>
        tickets_for[i] = tickets;
  9c:	89 84 9d e8 f6 ff ff 	mov    %eax,-0x918(%ebp,%ebx,4)
        active_pids[i] = spawn(tickets);
  a3:	89 04 24             	mov    %eax,(%esp)
  a6:	e8 f5 02 00 00       	call   3a0 <spawn>
    for (int i = 0; i < num_children; ++i) {
  ab:	83 c4 10             	add    $0x10,%esp
        active_pids[i] = spawn(tickets);
  ae:	89 04 9f             	mov    %eax,(%edi,%ebx,4)
    for (int i = 0; i < num_children; ++i) {
  b1:	89 d8                	mov    %ebx,%eax
  b3:	8d 5b 01             	lea    0x1(%ebx),%ebx
  b6:	3b 9d e4 f6 ff ff    	cmp    -0x91c(%ebp),%ebx
  bc:	75 d2                	jne    90 <main+0x90>
    }
    wait_for_ticket_counts(num_children, active_pids, tickets_for);
  be:	83 ec 04             	sub    $0x4,%esp
  c1:	89 c3                	mov    %eax,%ebx
  c3:	8d 85 e8 f6 ff ff    	lea    -0x918(%ebp),%eax
  c9:	50                   	push   %eax
  ca:	57                   	push   %edi
  cb:	ff b5 e4 f6 ff ff    	pushl  -0x91c(%ebp)
  d1:	e8 6a 03 00 00       	call   440 <wait_for_ticket_counts>
    struct pstat before, after;
    // before.num_processes = after.num_processes = -1;
    getpinfo(&before);
  d6:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
  dc:	89 04 24             	mov    %eax,(%esp)
  df:	e8 47 07 00 00       	call   82b <getpinfo>
    sleep(num_seconds);
  e4:	58                   	pop    %eax
  e5:	ff b5 d8 f6 ff ff    	pushl  -0x928(%ebp)
  eb:	e8 23 07 00 00       	call   813 <sleep>
    getpinfo(&after);
  f0:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
  f6:	89 04 24             	mov    %eax,(%esp)
  f9:	e8 2d 07 00 00       	call   82b <getpinfo>
    for (int i = 0; i < num_children; ++i) {
  fe:	8b 85 dc f6 ff ff    	mov    -0x924(%ebp),%eax
 104:	89 9d e0 f6 ff ff    	mov    %ebx,-0x920(%ebp)
 10a:	83 c4 10             	add    $0x10,%esp
 10d:	89 fb                	mov    %edi,%ebx
 10f:	8d 84 85 60 f7 ff ff 	lea    -0x8a0(%ebp,%eax,4),%eax
 116:	89 c6                	mov    %eax,%esi
 118:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11f:	90                   	nop
        kill(active_pids[i]);
 120:	83 ec 0c             	sub    $0xc,%esp
 123:	ff 33                	pushl  (%ebx)
 125:	83 c3 04             	add    $0x4,%ebx
 128:	e8 86 06 00 00       	call   7b3 <kill>
    for (int i = 0; i < num_children; ++i) {
 12d:	83 c4 10             	add    $0x10,%esp
 130:	39 de                	cmp    %ebx,%esi
 132:	75 ec                	jne    120 <main+0x120>
 134:	8b 9d e0 f6 ff ff    	mov    -0x920(%ebp),%ebx
    }
    for (int i = 0; i < num_children; ++i) {
 13a:	31 f6                	xor    %esi,%esi
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        wait();
 140:	e8 46 06 00 00       	call   78b <wait>
    for (int i = 0; i < num_children; ++i) {
 145:	89 f0                	mov    %esi,%eax
 147:	83 c6 01             	add    $0x1,%esi
 14a:	39 c3                	cmp    %eax,%ebx
 14c:	75 f2                	jne    140 <main+0x140>
 14e:	8d 85 e8 f9 ff ff    	lea    -0x618(%ebp),%eax
 154:	8d 8d e8 fa ff ff    	lea    -0x518(%ebp),%ecx
    int ans = 0;
 15a:	31 d2                	xor    %edx,%edx
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(p->pid[i]!=0) ans++;
 160:	83 38 01             	cmpl   $0x1,(%eax)
 163:	83 da ff             	sbb    $0xffffffff,%edx
    for(int i = 0; i<NPROC; i++)
 166:	83 c0 04             	add    $0x4,%eax
 169:	39 c8                	cmp    %ecx,%eax
 16b:	75 f3                	jne    160 <main+0x160>
    }
    if (num_of_proc(&before) >= NPROC || num_of_proc(&after) >= NPROC) {
 16d:	83 fa 3f             	cmp    $0x3f,%edx
 170:	0f 8f ea 00 00 00    	jg     260 <main+0x260>
 176:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 17c:	8d 8d e8 fe ff ff    	lea    -0x118(%ebp),%ecx
    int ans = 0;
 182:	31 d2                	xor    %edx,%edx
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(p->pid[i]!=0) ans++;
 188:	83 38 01             	cmpl   $0x1,(%eax)
 18b:	83 da ff             	sbb    $0xffffffff,%edx
    for(int i = 0; i<NPROC; i++)
 18e:	83 c0 04             	add    $0x4,%eax
 191:	39 c8                	cmp    %ecx,%eax
 193:	75 f3                	jne    188 <main+0x188>
    if (num_of_proc(&before) >= NPROC || num_of_proc(&after) >= NPROC) {
 195:	83 fa 3f             	cmp    $0x3f,%edx
 198:	0f 8f c2 00 00 00    	jg     260 <main+0x260>
    }
    if (num_of_proc(&before) < 0 || num_of_proc(&after) < 0) {
        printf(2, "getprocessesinfo's num_processes is negative -- not changed by syscall?\n");
        return 1;
    }
    printf(1, "TICKETS\tTICKS\n");
 19e:	50                   	push   %eax
    for (int i = 0; i < num_children; ++i) {
 19f:	31 db                	xor    %ebx,%ebx
    printf(1, "TICKETS\tTICKS\n");
 1a1:	50                   	push   %eax
 1a2:	68 80 0c 00 00       	push   $0xc80
 1a7:	6a 01                	push   $0x1
 1a9:	e8 42 07 00 00       	call   8f0 <printf>
 1ae:	83 c4 10             	add    $0x10,%esp
        int before_index = find_index_of_pid(before.pid, num_of_proc(&before), active_pids[i]);
 1b1:	8b 0c 9f             	mov    (%edi,%ebx,4),%ecx
    int ans = 0;
 1b4:	31 d2                	xor    %edx,%edx
    for(int i = 0; i<NPROC; i++)
 1b6:	31 c0                	xor    %eax,%eax
        if(p->pid[i]!=0) ans++;
 1b8:	83 bc 85 e8 f9 ff ff 	cmpl   $0x0,-0x618(%ebp,%eax,4)
 1bf:	00 
 1c0:	74 03                	je     1c5 <main+0x1c5>
 1c2:	83 c2 01             	add    $0x1,%edx
    for(int i = 0; i<NPROC; i++)
 1c5:	83 c0 01             	add    $0x1,%eax
 1c8:	83 f8 40             	cmp    $0x40,%eax
 1cb:	75 eb                	jne    1b8 <main+0x1b8>
    for (int i = 0; i < list_size; ++i) {
 1cd:	31 f6                	xor    %esi,%esi
 1cf:	eb 0c                	jmp    1dd <main+0x1dd>
        if (list[i] == pid)
 1d1:	3b 8c b5 e8 f9 ff ff 	cmp    -0x618(%ebp,%esi,4),%ecx
 1d8:	74 0a                	je     1e4 <main+0x1e4>
    for (int i = 0; i < list_size; ++i) {
 1da:	83 c6 01             	add    $0x1,%esi
 1dd:	39 d6                	cmp    %edx,%esi
 1df:	75 f0                	jne    1d1 <main+0x1d1>
    return -1;
 1e1:	83 ce ff             	or     $0xffffffff,%esi
    int ans = 0;
 1e4:	31 d2                	xor    %edx,%edx
    for(int i = 0; i<NPROC; i++)
 1e6:	31 c0                	xor    %eax,%eax
        if(p->pid[i]!=0) ans++;
 1e8:	83 bc 85 e8 fd ff ff 	cmpl   $0x0,-0x218(%ebp,%eax,4)
 1ef:	00 
 1f0:	74 03                	je     1f5 <main+0x1f5>
 1f2:	83 c2 01             	add    $0x1,%edx
    for(int i = 0; i<NPROC; i++)
 1f5:	83 c0 01             	add    $0x1,%eax
 1f8:	83 f8 40             	cmp    $0x40,%eax
 1fb:	75 eb                	jne    1e8 <main+0x1e8>
    for (int i = 0; i < list_size; ++i) {
 1fd:	31 c0                	xor    %eax,%eax
 1ff:	eb 10                	jmp    211 <main+0x211>
        if (list[i] == pid)
 201:	3b 8c 85 e8 fd ff ff 	cmp    -0x218(%ebp,%eax,4),%ecx
 208:	0f 84 9a 00 00 00    	je     2a8 <main+0x2a8>
    for (int i = 0; i < list_size; ++i) {
 20e:	83 c0 01             	add    $0x1,%eax
 211:	39 d0                	cmp    %edx,%eax
 213:	75 ec                	jne    201 <main+0x201>
        int after_index = find_index_of_pid(after.pid, num_of_proc(&after), active_pids[i]);
        if (before_index == -1)
 215:	83 c6 01             	add    $0x1,%esi
 218:	0f 84 2d 01 00 00    	je     34b <main+0x34b>
            printf(2, "child %d did not exist for getprocessesinfo before parent slept\n", i);
        if (after_index == -1)
            printf(2, "child %d did not exist for getprocessesinfo after parent slept\n", i);
 21e:	50                   	push   %eax
 21f:	53                   	push   %ebx
 220:	68 a0 0d 00 00       	push   $0xda0
 225:	6a 02                	push   $0x2
 227:	e8 c4 06 00 00       	call   8f0 <printf>
 22c:	83 c4 10             	add    $0x10,%esp
        if (before_index == -1 || after_index == -1) {
            printf(1, "%d\t--unknown--\n", tickets_for[i]);
 22f:	50                   	push   %eax
 230:	ff b4 9d e8 f6 ff ff 	pushl  -0x918(%ebp,%ebx,4)
 237:	68 8f 0c 00 00       	push   $0xc8f
 23c:	6a 01                	push   $0x1
 23e:	e8 ad 06 00 00       	call   8f0 <printf>
 243:	83 c4 10             	add    $0x10,%esp
    for (int i = 0; i < num_children; ++i) {
 246:	83 c3 01             	add    $0x1,%ebx
 249:	39 9d e4 f6 ff ff    	cmp    %ebx,-0x91c(%ebp)
 24f:	0f 8f 5c ff ff ff    	jg     1b1 <main+0x1b1>
                printf(2, "child %d had wrong number of tickets in getprocessinfo after parent slept\n", i);
            }
            printf(1, "%d\t%d\n", tickets_for[i], after.ticks[after_index] - before.ticks[before_index]);
        }
    }
    exit();
 255:	e8 29 05 00 00       	call   783 <exit>
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(2, "getprocessesinfo's num_processes is greater than NPROC before parent slept\n");
 260:	83 ec 08             	sub    $0x8,%esp
 263:	68 54 0d 00 00       	push   $0xd54
 268:	6a 02                	push   $0x2
 26a:	e8 81 06 00 00       	call   8f0 <printf>
 26f:	8d 65 f0             	lea    -0x10(%ebp),%esp
 272:	b8 01 00 00 00       	mov    $0x1,%eax
 277:	59                   	pop    %ecx
 278:	5b                   	pop    %ebx
 279:	5e                   	pop    %esi
 27a:	5f                   	pop    %edi
 27b:	5d                   	pop    %ebp
 27c:	8d 61 fc             	lea    -0x4(%ecx),%esp
 27f:	c3                   	ret    
        printf(2, "only up to %d supported\n", MAX_CHILDREN);
 280:	52                   	push   %edx
 281:	6a 20                	push   $0x20
 283:	68 67 0c 00 00       	push   $0xc67
 288:	6a 02                	push   $0x2
 28a:	e8 61 06 00 00       	call   8f0 <printf>
        exit();
 28f:	e8 ef 04 00 00       	call   783 <exit>
        printf(2, "usage: %s seconds tickets1 tickets2 ... ticketsN\n"
 294:	51                   	push   %ecx
 295:	ff 37                	pushl  (%edi)
 297:	68 a8 0c 00 00       	push   $0xca8
 29c:	6a 02                	push   $0x2
 29e:	e8 4d 06 00 00       	call   8f0 <printf>
        exit();
 2a3:	e8 db 04 00 00       	call   783 <exit>
        if (before_index == -1)
 2a8:	83 fe ff             	cmp    $0xffffffff,%esi
 2ab:	0f 84 84 00 00 00    	je     335 <main+0x335>
            if (before.tickets[before_index] != tickets_for[i]) {
 2b1:	8b 94 9d e8 f6 ff ff 	mov    -0x918(%ebp,%ebx,4),%edx
 2b8:	39 94 b5 e8 f8 ff ff 	cmp    %edx,-0x718(%ebp,%esi,4)
 2bf:	74 1d                	je     2de <main+0x2de>
 2c1:	89 85 e0 f6 ff ff    	mov    %eax,-0x920(%ebp)
                printf(2, "child %d had wrong number of tickets in getprocessinfo before parent slept\n", i);
 2c7:	50                   	push   %eax
 2c8:	53                   	push   %ebx
 2c9:	68 e0 0d 00 00       	push   $0xde0
 2ce:	6a 02                	push   $0x2
 2d0:	e8 1b 06 00 00       	call   8f0 <printf>
 2d5:	8b 85 e0 f6 ff ff    	mov    -0x920(%ebp),%eax
 2db:	83 c4 10             	add    $0x10,%esp
            if (after.tickets[after_index] != tickets_for[i]) {
 2de:	8b 94 9d e8 f6 ff ff 	mov    -0x918(%ebp,%ebx,4),%edx
 2e5:	39 94 85 e8 fc ff ff 	cmp    %edx,-0x318(%ebp,%eax,4)
 2ec:	74 1d                	je     30b <main+0x30b>
                printf(2, "child %d had wrong number of tickets in getprocessinfo after parent slept\n", i);
 2ee:	51                   	push   %ecx
 2ef:	53                   	push   %ebx
 2f0:	68 2c 0e 00 00       	push   $0xe2c
 2f5:	6a 02                	push   $0x2
 2f7:	89 85 e0 f6 ff ff    	mov    %eax,-0x920(%ebp)
 2fd:	e8 ee 05 00 00       	call   8f0 <printf>
 302:	8b 85 e0 f6 ff ff    	mov    -0x920(%ebp),%eax
 308:	83 c4 10             	add    $0x10,%esp
            printf(1, "%d\t%d\n", tickets_for[i], after.ticks[after_index] - before.ticks[before_index]);
 30b:	8b 84 85 e8 fe ff ff 	mov    -0x118(%ebp,%eax,4),%eax
 312:	2b 84 b5 e8 fa ff ff 	sub    -0x518(%ebp,%esi,4),%eax
 319:	50                   	push   %eax
 31a:	ff b4 9d e8 f6 ff ff 	pushl  -0x918(%ebp,%ebx,4)
 321:	68 9f 0c 00 00       	push   $0xc9f
 326:	6a 01                	push   $0x1
 328:	e8 c3 05 00 00       	call   8f0 <printf>
 32d:	83 c4 10             	add    $0x10,%esp
 330:	e9 11 ff ff ff       	jmp    246 <main+0x246>
            printf(2, "child %d did not exist for getprocessesinfo before parent slept\n", i);
 335:	50                   	push   %eax
 336:	53                   	push   %ebx
 337:	68 78 0e 00 00       	push   $0xe78
 33c:	6a 02                	push   $0x2
 33e:	e8 ad 05 00 00       	call   8f0 <printf>
 343:	83 c4 10             	add    $0x10,%esp
 346:	e9 e4 fe ff ff       	jmp    22f <main+0x22f>
 34b:	52                   	push   %edx
 34c:	53                   	push   %ebx
 34d:	68 78 0e 00 00       	push   $0xe78
 352:	6a 02                	push   $0x2
 354:	e8 97 05 00 00       	call   8f0 <printf>
 359:	83 c4 10             	add    $0x10,%esp
 35c:	e9 bd fe ff ff       	jmp    21e <main+0x21e>
 361:	66 90                	xchg   %ax,%ax
 363:	66 90                	xchg   %ax,%ax
 365:	66 90                	xchg   %ax,%ax
 367:	66 90                	xchg   %ax,%ax
 369:	66 90                	xchg   %ax,%ax
 36b:	66 90                	xchg   %ax,%ax
 36d:	66 90                	xchg   %ax,%ax
 36f:	90                   	nop

00000370 <yield_forever>:
void yield_forever() {
 370:	f3 0f 1e fb          	endbr32 
 374:	55                   	push   %ebp
 375:	89 e5                	mov    %esp,%ebp
 377:	83 ec 08             	sub    $0x8,%esp
 37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        yield();
 380:	e8 ae 04 00 00       	call   833 <yield>
    while (1) {
 385:	eb f9                	jmp    380 <yield_forever+0x10>
 387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 38e:	66 90                	xchg   %ax,%ax

00000390 <run_forever>:
void run_forever() {
 390:	f3 0f 1e fb          	endbr32 
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while (1) {
 398:	eb fe                	jmp    398 <run_forever+0x8>
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <spawn>:
int spawn(int tickets) {
 3a0:	f3 0f 1e fb          	endbr32 
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	53                   	push   %ebx
 3a8:	83 ec 04             	sub    $0x4,%esp
    int pid = fork();
 3ab:	e8 cb 03 00 00       	call   77b <fork>
    if (pid == 0) {
 3b0:	85 c0                	test   %eax,%eax
 3b2:	74 0e                	je     3c2 <spawn+0x22>
 3b4:	89 c3                	mov    %eax,%ebx
    } else if (pid != -1) {
 3b6:	83 f8 ff             	cmp    $0xffffffff,%eax
 3b9:	74 25                	je     3e0 <spawn+0x40>
}
 3bb:	89 d8                	mov    %ebx,%eax
 3bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3c0:	c9                   	leave  
 3c1:	c3                   	ret    
        settickets(tickets);
 3c2:	83 ec 0c             	sub    $0xc,%esp
 3c5:	ff 75 08             	pushl  0x8(%ebp)
 3c8:	e8 56 04 00 00       	call   823 <settickets>
        yield();
 3cd:	e8 61 04 00 00       	call   833 <yield>
 3d2:	83 c4 10             	add    $0x10,%esp
    while (1) {
 3d5:	eb fe                	jmp    3d5 <spawn+0x35>
 3d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3de:	66 90                	xchg   %ax,%ax
        printf(2, "error in fork\n");
 3e0:	83 ec 08             	sub    $0x8,%esp
 3e3:	68 58 0c 00 00       	push   $0xc58
 3e8:	6a 02                	push   $0x2
 3ea:	e8 01 05 00 00       	call   8f0 <printf>
 3ef:	83 c4 10             	add    $0x10,%esp
 3f2:	eb c7                	jmp    3bb <spawn+0x1b>
 3f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3ff:	90                   	nop

00000400 <find_index_of_pid>:
int find_index_of_pid(int *list, int list_size, int pid) {
 400:	f3 0f 1e fb          	endbr32 
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
 407:	53                   	push   %ebx
 408:	8b 55 0c             	mov    0xc(%ebp),%edx
 40b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 40e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    for (int i = 0; i < list_size; ++i) {
 411:	85 d2                	test   %edx,%edx
 413:	7e 1b                	jle    430 <find_index_of_pid+0x30>
 415:	31 c0                	xor    %eax,%eax
 417:	eb 0e                	jmp    427 <find_index_of_pid+0x27>
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 420:	83 c0 01             	add    $0x1,%eax
 423:	39 c2                	cmp    %eax,%edx
 425:	74 09                	je     430 <find_index_of_pid+0x30>
        if (list[i] == pid)
 427:	39 1c 81             	cmp    %ebx,(%ecx,%eax,4)
 42a:	75 f4                	jne    420 <find_index_of_pid+0x20>
}
 42c:	5b                   	pop    %ebx
 42d:	5d                   	pop    %ebp
 42e:	c3                   	ret    
 42f:	90                   	nop
    return -1;
 430:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 435:	5b                   	pop    %ebx
 436:	5d                   	pop    %ebp
 437:	c3                   	ret    
 438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop

00000440 <wait_for_ticket_counts>:
void wait_for_ticket_counts(int num_children, int *pids, int *tickets) {
 440:	f3 0f 1e fb          	endbr32 
 444:	55                   	push   %ebp
 445:	89 e5                	mov    %esp,%ebp
 447:	57                   	push   %edi
 448:	56                   	push   %esi
 449:	53                   	push   %ebx
 44a:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
 450:	81 ec 1c 04 00 00    	sub    $0x41c,%esp
 456:	8b 75 0c             	mov    0xc(%ebp),%esi
 459:	c7 85 e4 fb ff ff 64 	movl   $0x64,-0x41c(%ebp)
 460:	00 00 00 
 463:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 467:	90                   	nop
        yield();
 468:	e8 c6 03 00 00       	call   833 <yield>
        getpinfo(&info);
 46d:	83 ec 0c             	sub    $0xc,%esp
 470:	53                   	push   %ebx
 471:	e8 b5 03 00 00       	call   82b <getpinfo>
        for (int i = 0; i < num_children; ++i) {
 476:	8b 45 08             	mov    0x8(%ebp),%eax
 479:	83 c4 10             	add    $0x10,%esp
 47c:	85 c0                	test   %eax,%eax
 47e:	7e 58                	jle    4d8 <wait_for_ticket_counts+0x98>
 480:	31 c9                	xor    %ecx,%ecx
        int done = 1;
 482:	bf 01 00 00 00       	mov    $0x1,%edi
 487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48e:	66 90                	xchg   %ax,%ax
            int index = find_index_of_pid(info.pid, NPROC, pids[i]);
 490:	8b 14 8e             	mov    (%esi,%ecx,4),%edx
    for (int i = 0; i < list_size; ++i) {
 493:	31 c0                	xor    %eax,%eax
 495:	8d 76 00             	lea    0x0(%esi),%esi
        if (list[i] == pid)
 498:	3b 94 83 00 02 00 00 	cmp    0x200(%ebx,%eax,4),%edx
 49f:	74 0d                	je     4ae <wait_for_ticket_counts+0x6e>
    for (int i = 0; i < list_size; ++i) {
 4a1:	83 c0 01             	add    $0x1,%eax
 4a4:	83 f8 40             	cmp    $0x40,%eax
 4a7:	75 ef                	jne    498 <wait_for_ticket_counts+0x58>
    return -1;
 4a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
            if (info.tickets[index] != tickets[i]) done = 0;
 4ae:	8b 55 10             	mov    0x10(%ebp),%edx
 4b1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
 4b4:	39 94 85 e8 fc ff ff 	cmp    %edx,-0x318(%ebp,%eax,4)
 4bb:	b8 00 00 00 00       	mov    $0x0,%eax
 4c0:	0f 45 f8             	cmovne %eax,%edi
        for (int i = 0; i < num_children; ++i) {
 4c3:	83 c1 01             	add    $0x1,%ecx
 4c6:	39 4d 08             	cmp    %ecx,0x8(%ebp)
 4c9:	75 c5                	jne    490 <wait_for_ticket_counts+0x50>
        if (done)
 4cb:	85 ff                	test   %edi,%edi
 4cd:	75 09                	jne    4d8 <wait_for_ticket_counts+0x98>
    for (int yield_count = 0; yield_count < MAX_YIELDS_FOR_SETUP; ++yield_count) {
 4cf:	83 ad e4 fb ff ff 01 	subl   $0x1,-0x41c(%ebp)
 4d6:	75 90                	jne    468 <wait_for_ticket_counts+0x28>
}
 4d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4db:	5b                   	pop    %ebx
 4dc:	5e                   	pop    %esi
 4dd:	5f                   	pop    %edi
 4de:	5d                   	pop    %ebp
 4df:	c3                   	ret    

000004e0 <num_of_proc>:
{
 4e0:	f3 0f 1e fb          	endbr32 
 4e4:	55                   	push   %ebp
    int ans = 0;
 4e5:	31 d2                	xor    %edx,%edx
{
 4e7:	89 e5                	mov    %esp,%ebp
 4e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4ec:	8d 81 00 02 00 00    	lea    0x200(%ecx),%eax
 4f2:	81 c1 00 03 00 00    	add    $0x300,%ecx
 4f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ff:	90                   	nop
        if(p->pid[i]!=0) ans++;
 500:	83 38 01             	cmpl   $0x1,(%eax)
 503:	83 da ff             	sbb    $0xffffffff,%edx
    for(int i = 0; i<NPROC; i++)
 506:	83 c0 04             	add    $0x4,%eax
 509:	39 c8                	cmp    %ecx,%eax
 50b:	75 f3                	jne    500 <num_of_proc+0x20>
}
 50d:	89 d0                	mov    %edx,%eax
 50f:	5d                   	pop    %ebp
 510:	c3                   	ret    
 511:	66 90                	xchg   %ax,%ax
 513:	66 90                	xchg   %ax,%ax
 515:	66 90                	xchg   %ax,%ax
 517:	66 90                	xchg   %ax,%ax
 519:	66 90                	xchg   %ax,%ax
 51b:	66 90                	xchg   %ax,%ax
 51d:	66 90                	xchg   %ax,%ax
 51f:	90                   	nop

00000520 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 520:	f3 0f 1e fb          	endbr32 
 524:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 525:	31 c0                	xor    %eax,%eax
{
 527:	89 e5                	mov    %esp,%ebp
 529:	53                   	push   %ebx
 52a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 52d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 530:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 534:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 537:	83 c0 01             	add    $0x1,%eax
 53a:	84 d2                	test   %dl,%dl
 53c:	75 f2                	jne    530 <strcpy+0x10>
    ;
  return os;
}
 53e:	89 c8                	mov    %ecx,%eax
 540:	5b                   	pop    %ebx
 541:	5d                   	pop    %ebp
 542:	c3                   	ret    
 543:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000550 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 550:	f3 0f 1e fb          	endbr32 
 554:	55                   	push   %ebp
 555:	89 e5                	mov    %esp,%ebp
 557:	53                   	push   %ebx
 558:	8b 4d 08             	mov    0x8(%ebp),%ecx
 55b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 55e:	0f b6 01             	movzbl (%ecx),%eax
 561:	0f b6 1a             	movzbl (%edx),%ebx
 564:	84 c0                	test   %al,%al
 566:	75 19                	jne    581 <strcmp+0x31>
 568:	eb 26                	jmp    590 <strcmp+0x40>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 570:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 574:	83 c1 01             	add    $0x1,%ecx
 577:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 57a:	0f b6 1a             	movzbl (%edx),%ebx
 57d:	84 c0                	test   %al,%al
 57f:	74 0f                	je     590 <strcmp+0x40>
 581:	38 d8                	cmp    %bl,%al
 583:	74 eb                	je     570 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 585:	29 d8                	sub    %ebx,%eax
}
 587:	5b                   	pop    %ebx
 588:	5d                   	pop    %ebp
 589:	c3                   	ret    
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 590:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 592:	29 d8                	sub    %ebx,%eax
}
 594:	5b                   	pop    %ebx
 595:	5d                   	pop    %ebp
 596:	c3                   	ret    
 597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59e:	66 90                	xchg   %ax,%ax

000005a0 <strlen>:

uint
strlen(const char *s)
{
 5a0:	f3 0f 1e fb          	endbr32 
 5a4:	55                   	push   %ebp
 5a5:	89 e5                	mov    %esp,%ebp
 5a7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 5aa:	80 3a 00             	cmpb   $0x0,(%edx)
 5ad:	74 21                	je     5d0 <strlen+0x30>
 5af:	31 c0                	xor    %eax,%eax
 5b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5b8:	83 c0 01             	add    $0x1,%eax
 5bb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 5bf:	89 c1                	mov    %eax,%ecx
 5c1:	75 f5                	jne    5b8 <strlen+0x18>
    ;
  return n;
}
 5c3:	89 c8                	mov    %ecx,%eax
 5c5:	5d                   	pop    %ebp
 5c6:	c3                   	ret    
 5c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ce:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 5d0:	31 c9                	xor    %ecx,%ecx
}
 5d2:	5d                   	pop    %ebp
 5d3:	89 c8                	mov    %ecx,%eax
 5d5:	c3                   	ret    
 5d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5dd:	8d 76 00             	lea    0x0(%esi),%esi

000005e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 5e0:	f3 0f 1e fb          	endbr32 
 5e4:	55                   	push   %ebp
 5e5:	89 e5                	mov    %esp,%ebp
 5e7:	57                   	push   %edi
 5e8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 5eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5ee:	8b 45 0c             	mov    0xc(%ebp),%eax
 5f1:	89 d7                	mov    %edx,%edi
 5f3:	fc                   	cld    
 5f4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 5f6:	89 d0                	mov    %edx,%eax
 5f8:	5f                   	pop    %edi
 5f9:	5d                   	pop    %ebp
 5fa:	c3                   	ret    
 5fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ff:	90                   	nop

00000600 <strchr>:

char*
strchr(const char *s, char c)
{
 600:	f3 0f 1e fb          	endbr32 
 604:	55                   	push   %ebp
 605:	89 e5                	mov    %esp,%ebp
 607:	8b 45 08             	mov    0x8(%ebp),%eax
 60a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 60e:	0f b6 10             	movzbl (%eax),%edx
 611:	84 d2                	test   %dl,%dl
 613:	75 16                	jne    62b <strchr+0x2b>
 615:	eb 21                	jmp    638 <strchr+0x38>
 617:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61e:	66 90                	xchg   %ax,%ax
 620:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 624:	83 c0 01             	add    $0x1,%eax
 627:	84 d2                	test   %dl,%dl
 629:	74 0d                	je     638 <strchr+0x38>
    if(*s == c)
 62b:	38 d1                	cmp    %dl,%cl
 62d:	75 f1                	jne    620 <strchr+0x20>
      return (char*)s;
  return 0;
}
 62f:	5d                   	pop    %ebp
 630:	c3                   	ret    
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 638:	31 c0                	xor    %eax,%eax
}
 63a:	5d                   	pop    %ebp
 63b:	c3                   	ret    
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000640 <gets>:

char*
gets(char *buf, int max)
{
 640:	f3 0f 1e fb          	endbr32 
 644:	55                   	push   %ebp
 645:	89 e5                	mov    %esp,%ebp
 647:	57                   	push   %edi
 648:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 649:	31 f6                	xor    %esi,%esi
{
 64b:	53                   	push   %ebx
 64c:	89 f3                	mov    %esi,%ebx
 64e:	83 ec 1c             	sub    $0x1c,%esp
 651:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 654:	eb 33                	jmp    689 <gets+0x49>
 656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	8d 45 e7             	lea    -0x19(%ebp),%eax
 666:	6a 01                	push   $0x1
 668:	50                   	push   %eax
 669:	6a 00                	push   $0x0
 66b:	e8 2b 01 00 00       	call   79b <read>
    if(cc < 1)
 670:	83 c4 10             	add    $0x10,%esp
 673:	85 c0                	test   %eax,%eax
 675:	7e 1c                	jle    693 <gets+0x53>
      break;
    buf[i++] = c;
 677:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 67b:	83 c7 01             	add    $0x1,%edi
 67e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 681:	3c 0a                	cmp    $0xa,%al
 683:	74 23                	je     6a8 <gets+0x68>
 685:	3c 0d                	cmp    $0xd,%al
 687:	74 1f                	je     6a8 <gets+0x68>
  for(i=0; i+1 < max; ){
 689:	83 c3 01             	add    $0x1,%ebx
 68c:	89 fe                	mov    %edi,%esi
 68e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 691:	7c cd                	jl     660 <gets+0x20>
 693:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 695:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 698:	c6 03 00             	movb   $0x0,(%ebx)
}
 69b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 69e:	5b                   	pop    %ebx
 69f:	5e                   	pop    %esi
 6a0:	5f                   	pop    %edi
 6a1:	5d                   	pop    %ebp
 6a2:	c3                   	ret    
 6a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6a7:	90                   	nop
 6a8:	8b 75 08             	mov    0x8(%ebp),%esi
 6ab:	8b 45 08             	mov    0x8(%ebp),%eax
 6ae:	01 de                	add    %ebx,%esi
 6b0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 6b2:	c6 03 00             	movb   $0x0,(%ebx)
}
 6b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6b8:	5b                   	pop    %ebx
 6b9:	5e                   	pop    %esi
 6ba:	5f                   	pop    %edi
 6bb:	5d                   	pop    %ebp
 6bc:	c3                   	ret    
 6bd:	8d 76 00             	lea    0x0(%esi),%esi

000006c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 6c0:	f3 0f 1e fb          	endbr32 
 6c4:	55                   	push   %ebp
 6c5:	89 e5                	mov    %esp,%ebp
 6c7:	56                   	push   %esi
 6c8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 6c9:	83 ec 08             	sub    $0x8,%esp
 6cc:	6a 00                	push   $0x0
 6ce:	ff 75 08             	pushl  0x8(%ebp)
 6d1:	e8 ed 00 00 00       	call   7c3 <open>
  if(fd < 0)
 6d6:	83 c4 10             	add    $0x10,%esp
 6d9:	85 c0                	test   %eax,%eax
 6db:	78 2b                	js     708 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 6dd:	83 ec 08             	sub    $0x8,%esp
 6e0:	ff 75 0c             	pushl  0xc(%ebp)
 6e3:	89 c3                	mov    %eax,%ebx
 6e5:	50                   	push   %eax
 6e6:	e8 f0 00 00 00       	call   7db <fstat>
  close(fd);
 6eb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 6ee:	89 c6                	mov    %eax,%esi
  close(fd);
 6f0:	e8 b6 00 00 00       	call   7ab <close>
  return r;
 6f5:	83 c4 10             	add    $0x10,%esp
}
 6f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 6fb:	89 f0                	mov    %esi,%eax
 6fd:	5b                   	pop    %ebx
 6fe:	5e                   	pop    %esi
 6ff:	5d                   	pop    %ebp
 700:	c3                   	ret    
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 708:	be ff ff ff ff       	mov    $0xffffffff,%esi
 70d:	eb e9                	jmp    6f8 <stat+0x38>
 70f:	90                   	nop

00000710 <atoi>:

int
atoi(const char *s)
{
 710:	f3 0f 1e fb          	endbr32 
 714:	55                   	push   %ebp
 715:	89 e5                	mov    %esp,%ebp
 717:	53                   	push   %ebx
 718:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 71b:	0f be 02             	movsbl (%edx),%eax
 71e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 721:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 724:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 729:	77 1a                	ja     745 <atoi+0x35>
 72b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 72f:	90                   	nop
    n = n*10 + *s++ - '0';
 730:	83 c2 01             	add    $0x1,%edx
 733:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 736:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 73a:	0f be 02             	movsbl (%edx),%eax
 73d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 740:	80 fb 09             	cmp    $0x9,%bl
 743:	76 eb                	jbe    730 <atoi+0x20>
  return n;
}
 745:	89 c8                	mov    %ecx,%eax
 747:	5b                   	pop    %ebx
 748:	5d                   	pop    %ebp
 749:	c3                   	ret    
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000750 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 750:	f3 0f 1e fb          	endbr32 
 754:	55                   	push   %ebp
 755:	89 e5                	mov    %esp,%ebp
 757:	57                   	push   %edi
 758:	8b 45 10             	mov    0x10(%ebp),%eax
 75b:	8b 55 08             	mov    0x8(%ebp),%edx
 75e:	56                   	push   %esi
 75f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 762:	85 c0                	test   %eax,%eax
 764:	7e 0f                	jle    775 <memmove+0x25>
 766:	01 d0                	add    %edx,%eax
  dst = vdst;
 768:	89 d7                	mov    %edx,%edi
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 770:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 771:	39 f8                	cmp    %edi,%eax
 773:	75 fb                	jne    770 <memmove+0x20>
  return vdst;
}
 775:	5e                   	pop    %esi
 776:	89 d0                	mov    %edx,%eax
 778:	5f                   	pop    %edi
 779:	5d                   	pop    %ebp
 77a:	c3                   	ret    

0000077b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 77b:	b8 01 00 00 00       	mov    $0x1,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <exit>:
SYSCALL(exit)
 783:	b8 02 00 00 00       	mov    $0x2,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <wait>:
SYSCALL(wait)
 78b:	b8 03 00 00 00       	mov    $0x3,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <pipe>:
SYSCALL(pipe)
 793:	b8 04 00 00 00       	mov    $0x4,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <read>:
SYSCALL(read)
 79b:	b8 05 00 00 00       	mov    $0x5,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <write>:
SYSCALL(write)
 7a3:	b8 10 00 00 00       	mov    $0x10,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <close>:
SYSCALL(close)
 7ab:	b8 15 00 00 00       	mov    $0x15,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <kill>:
SYSCALL(kill)
 7b3:	b8 06 00 00 00       	mov    $0x6,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <exec>:
SYSCALL(exec)
 7bb:	b8 07 00 00 00       	mov    $0x7,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <open>:
SYSCALL(open)
 7c3:	b8 0f 00 00 00       	mov    $0xf,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <mknod>:
SYSCALL(mknod)
 7cb:	b8 11 00 00 00       	mov    $0x11,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <unlink>:
SYSCALL(unlink)
 7d3:	b8 12 00 00 00       	mov    $0x12,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <fstat>:
SYSCALL(fstat)
 7db:	b8 08 00 00 00       	mov    $0x8,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    

000007e3 <link>:
SYSCALL(link)
 7e3:	b8 13 00 00 00       	mov    $0x13,%eax
 7e8:	cd 40                	int    $0x40
 7ea:	c3                   	ret    

000007eb <mkdir>:
SYSCALL(mkdir)
 7eb:	b8 14 00 00 00       	mov    $0x14,%eax
 7f0:	cd 40                	int    $0x40
 7f2:	c3                   	ret    

000007f3 <chdir>:
SYSCALL(chdir)
 7f3:	b8 09 00 00 00       	mov    $0x9,%eax
 7f8:	cd 40                	int    $0x40
 7fa:	c3                   	ret    

000007fb <dup>:
SYSCALL(dup)
 7fb:	b8 0a 00 00 00       	mov    $0xa,%eax
 800:	cd 40                	int    $0x40
 802:	c3                   	ret    

00000803 <getpid>:
SYSCALL(getpid)
 803:	b8 0b 00 00 00       	mov    $0xb,%eax
 808:	cd 40                	int    $0x40
 80a:	c3                   	ret    

0000080b <sbrk>:
SYSCALL(sbrk)
 80b:	b8 0c 00 00 00       	mov    $0xc,%eax
 810:	cd 40                	int    $0x40
 812:	c3                   	ret    

00000813 <sleep>:
SYSCALL(sleep)
 813:	b8 0d 00 00 00       	mov    $0xd,%eax
 818:	cd 40                	int    $0x40
 81a:	c3                   	ret    

0000081b <uptime>:
SYSCALL(uptime)
 81b:	b8 0e 00 00 00       	mov    $0xe,%eax
 820:	cd 40                	int    $0x40
 822:	c3                   	ret    

00000823 <settickets>:
SYSCALL(settickets)
 823:	b8 16 00 00 00       	mov    $0x16,%eax
 828:	cd 40                	int    $0x40
 82a:	c3                   	ret    

0000082b <getpinfo>:
SYSCALL(getpinfo)
 82b:	b8 17 00 00 00       	mov    $0x17,%eax
 830:	cd 40                	int    $0x40
 832:	c3                   	ret    

00000833 <yield>:
SYSCALL(yield)
 833:	b8 18 00 00 00       	mov    $0x18,%eax
 838:	cd 40                	int    $0x40
 83a:	c3                   	ret    
 83b:	66 90                	xchg   %ax,%ax
 83d:	66 90                	xchg   %ax,%ax
 83f:	90                   	nop

00000840 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	83 ec 3c             	sub    $0x3c,%esp
 849:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 84c:	89 d1                	mov    %edx,%ecx
{
 84e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 851:	85 d2                	test   %edx,%edx
 853:	0f 89 7f 00 00 00    	jns    8d8 <printint+0x98>
 859:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 85d:	74 79                	je     8d8 <printint+0x98>
    neg = 1;
 85f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 866:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 868:	31 db                	xor    %ebx,%ebx
 86a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 86d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 870:	89 c8                	mov    %ecx,%eax
 872:	31 d2                	xor    %edx,%edx
 874:	89 cf                	mov    %ecx,%edi
 876:	f7 75 c4             	divl   -0x3c(%ebp)
 879:	0f b6 92 c0 0e 00 00 	movzbl 0xec0(%edx),%edx
 880:	89 45 c0             	mov    %eax,-0x40(%ebp)
 883:	89 d8                	mov    %ebx,%eax
 885:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 888:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 88b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 88e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 891:	76 dd                	jbe    870 <printint+0x30>
  if(neg)
 893:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 896:	85 c9                	test   %ecx,%ecx
 898:	74 0c                	je     8a6 <printint+0x66>
    buf[i++] = '-';
 89a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 89f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 8a1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 8a6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 8a9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 8ad:	eb 07                	jmp    8b6 <printint+0x76>
 8af:	90                   	nop
 8b0:	0f b6 13             	movzbl (%ebx),%edx
 8b3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 8b6:	83 ec 04             	sub    $0x4,%esp
 8b9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 8bc:	6a 01                	push   $0x1
 8be:	56                   	push   %esi
 8bf:	57                   	push   %edi
 8c0:	e8 de fe ff ff       	call   7a3 <write>
  while(--i >= 0)
 8c5:	83 c4 10             	add    $0x10,%esp
 8c8:	39 de                	cmp    %ebx,%esi
 8ca:	75 e4                	jne    8b0 <printint+0x70>
    putc(fd, buf[i]);
}
 8cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8cf:	5b                   	pop    %ebx
 8d0:	5e                   	pop    %esi
 8d1:	5f                   	pop    %edi
 8d2:	5d                   	pop    %ebp
 8d3:	c3                   	ret    
 8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8d8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 8df:	eb 87                	jmp    868 <printint+0x28>
 8e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ef:	90                   	nop

000008f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8f0:	f3 0f 1e fb          	endbr32 
 8f4:	55                   	push   %ebp
 8f5:	89 e5                	mov    %esp,%ebp
 8f7:	57                   	push   %edi
 8f8:	56                   	push   %esi
 8f9:	53                   	push   %ebx
 8fa:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8fd:	8b 75 0c             	mov    0xc(%ebp),%esi
 900:	0f b6 1e             	movzbl (%esi),%ebx
 903:	84 db                	test   %bl,%bl
 905:	0f 84 b4 00 00 00    	je     9bf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 90b:	8d 45 10             	lea    0x10(%ebp),%eax
 90e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 911:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 914:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 916:	89 45 d0             	mov    %eax,-0x30(%ebp)
 919:	eb 33                	jmp    94e <printf+0x5e>
 91b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 91f:	90                   	nop
 920:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 923:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 928:	83 f8 25             	cmp    $0x25,%eax
 92b:	74 17                	je     944 <printf+0x54>
  write(fd, &c, 1);
 92d:	83 ec 04             	sub    $0x4,%esp
 930:	88 5d e7             	mov    %bl,-0x19(%ebp)
 933:	6a 01                	push   $0x1
 935:	57                   	push   %edi
 936:	ff 75 08             	pushl  0x8(%ebp)
 939:	e8 65 fe ff ff       	call   7a3 <write>
 93e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 941:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 944:	0f b6 1e             	movzbl (%esi),%ebx
 947:	83 c6 01             	add    $0x1,%esi
 94a:	84 db                	test   %bl,%bl
 94c:	74 71                	je     9bf <printf+0xcf>
    c = fmt[i] & 0xff;
 94e:	0f be cb             	movsbl %bl,%ecx
 951:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 954:	85 d2                	test   %edx,%edx
 956:	74 c8                	je     920 <printf+0x30>
      }
    } else if(state == '%'){
 958:	83 fa 25             	cmp    $0x25,%edx
 95b:	75 e7                	jne    944 <printf+0x54>
      if(c == 'd'){
 95d:	83 f8 64             	cmp    $0x64,%eax
 960:	0f 84 9a 00 00 00    	je     a00 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 966:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 96c:	83 f9 70             	cmp    $0x70,%ecx
 96f:	74 5f                	je     9d0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 971:	83 f8 73             	cmp    $0x73,%eax
 974:	0f 84 d6 00 00 00    	je     a50 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 97a:	83 f8 63             	cmp    $0x63,%eax
 97d:	0f 84 8d 00 00 00    	je     a10 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 983:	83 f8 25             	cmp    $0x25,%eax
 986:	0f 84 b4 00 00 00    	je     a40 <printf+0x150>
  write(fd, &c, 1);
 98c:	83 ec 04             	sub    $0x4,%esp
 98f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 993:	6a 01                	push   $0x1
 995:	57                   	push   %edi
 996:	ff 75 08             	pushl  0x8(%ebp)
 999:	e8 05 fe ff ff       	call   7a3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 99e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 9a1:	83 c4 0c             	add    $0xc,%esp
 9a4:	6a 01                	push   $0x1
 9a6:	83 c6 01             	add    $0x1,%esi
 9a9:	57                   	push   %edi
 9aa:	ff 75 08             	pushl  0x8(%ebp)
 9ad:	e8 f1 fd ff ff       	call   7a3 <write>
  for(i = 0; fmt[i]; i++){
 9b2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 9b6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 9b9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 9bb:	84 db                	test   %bl,%bl
 9bd:	75 8f                	jne    94e <printf+0x5e>
    }
  }
}
 9bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9c2:	5b                   	pop    %ebx
 9c3:	5e                   	pop    %esi
 9c4:	5f                   	pop    %edi
 9c5:	5d                   	pop    %ebp
 9c6:	c3                   	ret    
 9c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 9d0:	83 ec 0c             	sub    $0xc,%esp
 9d3:	b9 10 00 00 00       	mov    $0x10,%ecx
 9d8:	6a 00                	push   $0x0
 9da:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 9dd:	8b 45 08             	mov    0x8(%ebp),%eax
 9e0:	8b 13                	mov    (%ebx),%edx
 9e2:	e8 59 fe ff ff       	call   840 <printint>
        ap++;
 9e7:	89 d8                	mov    %ebx,%eax
 9e9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9ec:	31 d2                	xor    %edx,%edx
        ap++;
 9ee:	83 c0 04             	add    $0x4,%eax
 9f1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 9f4:	e9 4b ff ff ff       	jmp    944 <printf+0x54>
 9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 a00:	83 ec 0c             	sub    $0xc,%esp
 a03:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a08:	6a 01                	push   $0x1
 a0a:	eb ce                	jmp    9da <printf+0xea>
 a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 a10:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 a13:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a16:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 a18:	6a 01                	push   $0x1
        ap++;
 a1a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 a1d:	57                   	push   %edi
 a1e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 a21:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a24:	e8 7a fd ff ff       	call   7a3 <write>
        ap++;
 a29:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 a2c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a2f:	31 d2                	xor    %edx,%edx
 a31:	e9 0e ff ff ff       	jmp    944 <printf+0x54>
 a36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a3d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 a40:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 a43:	83 ec 04             	sub    $0x4,%esp
 a46:	e9 59 ff ff ff       	jmp    9a4 <printf+0xb4>
 a4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a4f:	90                   	nop
        s = (char*)*ap;
 a50:	8b 45 d0             	mov    -0x30(%ebp),%eax
 a53:	8b 18                	mov    (%eax),%ebx
        ap++;
 a55:	83 c0 04             	add    $0x4,%eax
 a58:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 a5b:	85 db                	test   %ebx,%ebx
 a5d:	74 17                	je     a76 <printf+0x186>
        while(*s != 0){
 a5f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 a62:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 a64:	84 c0                	test   %al,%al
 a66:	0f 84 d8 fe ff ff    	je     944 <printf+0x54>
 a6c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a6f:	89 de                	mov    %ebx,%esi
 a71:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a74:	eb 1a                	jmp    a90 <printf+0x1a0>
          s = "(null)";
 a76:	bb b9 0e 00 00       	mov    $0xeb9,%ebx
        while(*s != 0){
 a7b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 a7e:	b8 28 00 00 00       	mov    $0x28,%eax
 a83:	89 de                	mov    %ebx,%esi
 a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a8f:	90                   	nop
  write(fd, &c, 1);
 a90:	83 ec 04             	sub    $0x4,%esp
          s++;
 a93:	83 c6 01             	add    $0x1,%esi
 a96:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 a99:	6a 01                	push   $0x1
 a9b:	57                   	push   %edi
 a9c:	53                   	push   %ebx
 a9d:	e8 01 fd ff ff       	call   7a3 <write>
        while(*s != 0){
 aa2:	0f b6 06             	movzbl (%esi),%eax
 aa5:	83 c4 10             	add    $0x10,%esp
 aa8:	84 c0                	test   %al,%al
 aaa:	75 e4                	jne    a90 <printf+0x1a0>
 aac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 aaf:	31 d2                	xor    %edx,%edx
 ab1:	e9 8e fe ff ff       	jmp    944 <printf+0x54>
 ab6:	66 90                	xchg   %ax,%ax
 ab8:	66 90                	xchg   %ax,%ax
 aba:	66 90                	xchg   %ax,%ax
 abc:	66 90                	xchg   %ax,%ax
 abe:	66 90                	xchg   %ax,%ax

00000ac0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ac0:	f3 0f 1e fb          	endbr32 
 ac4:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac5:	a1 60 12 00 00       	mov    0x1260,%eax
{
 aca:	89 e5                	mov    %esp,%ebp
 acc:	57                   	push   %edi
 acd:	56                   	push   %esi
 ace:	53                   	push   %ebx
 acf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 ad2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 ad4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad7:	39 c8                	cmp    %ecx,%eax
 ad9:	73 15                	jae    af0 <free+0x30>
 adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 adf:	90                   	nop
 ae0:	39 d1                	cmp    %edx,%ecx
 ae2:	72 14                	jb     af8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ae4:	39 d0                	cmp    %edx,%eax
 ae6:	73 10                	jae    af8 <free+0x38>
{
 ae8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aea:	8b 10                	mov    (%eax),%edx
 aec:	39 c8                	cmp    %ecx,%eax
 aee:	72 f0                	jb     ae0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 af0:	39 d0                	cmp    %edx,%eax
 af2:	72 f4                	jb     ae8 <free+0x28>
 af4:	39 d1                	cmp    %edx,%ecx
 af6:	73 f0                	jae    ae8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 af8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 afb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 afe:	39 fa                	cmp    %edi,%edx
 b00:	74 1e                	je     b20 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b02:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b05:	8b 50 04             	mov    0x4(%eax),%edx
 b08:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b0b:	39 f1                	cmp    %esi,%ecx
 b0d:	74 28                	je     b37 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b0f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 b11:	5b                   	pop    %ebx
  freep = p;
 b12:	a3 60 12 00 00       	mov    %eax,0x1260
}
 b17:	5e                   	pop    %esi
 b18:	5f                   	pop    %edi
 b19:	5d                   	pop    %ebp
 b1a:	c3                   	ret    
 b1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 b1f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 b20:	03 72 04             	add    0x4(%edx),%esi
 b23:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b26:	8b 10                	mov    (%eax),%edx
 b28:	8b 12                	mov    (%edx),%edx
 b2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b2d:	8b 50 04             	mov    0x4(%eax),%edx
 b30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b33:	39 f1                	cmp    %esi,%ecx
 b35:	75 d8                	jne    b0f <free+0x4f>
    p->s.size += bp->s.size;
 b37:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b3a:	a3 60 12 00 00       	mov    %eax,0x1260
    p->s.size += bp->s.size;
 b3f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b42:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b45:	89 10                	mov    %edx,(%eax)
}
 b47:	5b                   	pop    %ebx
 b48:	5e                   	pop    %esi
 b49:	5f                   	pop    %edi
 b4a:	5d                   	pop    %ebp
 b4b:	c3                   	ret    
 b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b50:	f3 0f 1e fb          	endbr32 
 b54:	55                   	push   %ebp
 b55:	89 e5                	mov    %esp,%ebp
 b57:	57                   	push   %edi
 b58:	56                   	push   %esi
 b59:	53                   	push   %ebx
 b5a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b60:	8b 3d 60 12 00 00    	mov    0x1260,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b66:	8d 70 07             	lea    0x7(%eax),%esi
 b69:	c1 ee 03             	shr    $0x3,%esi
 b6c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 b6f:	85 ff                	test   %edi,%edi
 b71:	0f 84 a9 00 00 00    	je     c20 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b77:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 b79:	8b 48 04             	mov    0x4(%eax),%ecx
 b7c:	39 f1                	cmp    %esi,%ecx
 b7e:	73 6d                	jae    bed <malloc+0x9d>
 b80:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 b86:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b8b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b8e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 b95:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 b98:	eb 17                	jmp    bb1 <malloc+0x61>
 b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 ba2:	8b 4a 04             	mov    0x4(%edx),%ecx
 ba5:	39 f1                	cmp    %esi,%ecx
 ba7:	73 4f                	jae    bf8 <malloc+0xa8>
 ba9:	8b 3d 60 12 00 00    	mov    0x1260,%edi
 baf:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bb1:	39 c7                	cmp    %eax,%edi
 bb3:	75 eb                	jne    ba0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 bb5:	83 ec 0c             	sub    $0xc,%esp
 bb8:	ff 75 e4             	pushl  -0x1c(%ebp)
 bbb:	e8 4b fc ff ff       	call   80b <sbrk>
  if(p == (char*)-1)
 bc0:	83 c4 10             	add    $0x10,%esp
 bc3:	83 f8 ff             	cmp    $0xffffffff,%eax
 bc6:	74 1b                	je     be3 <malloc+0x93>
  hp->s.size = nu;
 bc8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 bcb:	83 ec 0c             	sub    $0xc,%esp
 bce:	83 c0 08             	add    $0x8,%eax
 bd1:	50                   	push   %eax
 bd2:	e8 e9 fe ff ff       	call   ac0 <free>
  return freep;
 bd7:	a1 60 12 00 00       	mov    0x1260,%eax
      if((p = morecore(nunits)) == 0)
 bdc:	83 c4 10             	add    $0x10,%esp
 bdf:	85 c0                	test   %eax,%eax
 be1:	75 bd                	jne    ba0 <malloc+0x50>
        return 0;
  }
}
 be3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 be6:	31 c0                	xor    %eax,%eax
}
 be8:	5b                   	pop    %ebx
 be9:	5e                   	pop    %esi
 bea:	5f                   	pop    %edi
 beb:	5d                   	pop    %ebp
 bec:	c3                   	ret    
    if(p->s.size >= nunits){
 bed:	89 c2                	mov    %eax,%edx
 bef:	89 f8                	mov    %edi,%eax
 bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 bf8:	39 ce                	cmp    %ecx,%esi
 bfa:	74 54                	je     c50 <malloc+0x100>
        p->s.size -= nunits;
 bfc:	29 f1                	sub    %esi,%ecx
 bfe:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 c01:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 c04:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 c07:	a3 60 12 00 00       	mov    %eax,0x1260
}
 c0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c0f:	8d 42 08             	lea    0x8(%edx),%eax
}
 c12:	5b                   	pop    %ebx
 c13:	5e                   	pop    %esi
 c14:	5f                   	pop    %edi
 c15:	5d                   	pop    %ebp
 c16:	c3                   	ret    
 c17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 c1e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 c20:	c7 05 60 12 00 00 64 	movl   $0x1264,0x1260
 c27:	12 00 00 
    base.s.size = 0;
 c2a:	bf 64 12 00 00       	mov    $0x1264,%edi
    base.s.ptr = freep = prevp = &base;
 c2f:	c7 05 64 12 00 00 64 	movl   $0x1264,0x1264
 c36:	12 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c39:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 c3b:	c7 05 68 12 00 00 00 	movl   $0x0,0x1268
 c42:	00 00 00 
    if(p->s.size >= nunits){
 c45:	e9 36 ff ff ff       	jmp    b80 <malloc+0x30>
 c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 c50:	8b 0a                	mov    (%edx),%ecx
 c52:	89 08                	mov    %ecx,(%eax)
 c54:	eb b1                	jmp    c07 <malloc+0xb7>
