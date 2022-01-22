
_masum2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	check((ticks_high_after-ticks_high_before)*20 < ticks_low_after - ticks_low_before, "Expected the process with high tickets to get fewer ticks than the process with low tickets due to the former sleeping");
}

int
main(int argc, char *argv[])
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
  15:	81 ec 28 08 00 00    	sub    $0x828,%esp
   int pid_high = getpid();
  1b:	e8 f3 06 00 00       	call   713 <getpid>
   int lowtickets = 5, hightickets = 10000;
   check(settickets(hightickets) == 0, "settickets");
  20:	83 ec 0c             	sub    $0xc,%esp
  23:	68 10 27 00 00       	push   $0x2710
   int pid_high = getpid();
  28:	89 c3                	mov    %eax,%ebx
   check(settickets(hightickets) == 0, "settickets");
  2a:	e8 04 07 00 00       	call   733 <settickets>
  2f:	83 c4 10             	add    $0x10,%esp
  32:	85 c0                	test   %eax,%eax
  34:	74 23                	je     59 <main+0x59>
  36:	83 ec 0c             	sub    $0xc,%esp
  39:	68 49 0e 00 00       	push   $0xe49
  3e:	6a 3f                	push   $0x3f
  40:	68 40 0e 00 00       	push   $0xe40
  45:	68 50 0d 00 00       	push   $0xd50
  4a:	6a 01                	push   $0x1
  4c:	e8 af 07 00 00       	call   800 <printf>
  51:	83 c4 20             	add    $0x20,%esp
  54:	e8 3a 06 00 00       	call   693 <exit>
   int p[2];
   pipe(p);
  59:	83 ec 0c             	sub    $0xc,%esp
  5c:	8d 85 e0 f7 ff ff    	lea    -0x820(%ebp),%eax
  62:	50                   	push   %eax
  63:	e8 3b 06 00 00       	call   6a3 <pipe>
    
   if(fork() == 0){
  68:	e8 1e 06 00 00       	call   68b <fork>
  6d:	83 c4 10             	add    $0x10,%esp
  70:	85 c0                	test   %eax,%eax
  72:	74 68                	je     dc <main+0xdc>
      write(p[1],"a",sizeof(char));
      close(p[1]);
		  exit();
   }
   else{
     close(0);
  74:	83 ec 0c             	sub    $0xc,%esp
  77:	6a 00                	push   $0x0
  79:	e8 3d 06 00 00       	call   6bb <close>
     dup(*p);
  7e:	5a                   	pop    %edx
  7f:	ff b5 e0 f7 ff ff    	pushl  -0x820(%ebp)
  85:	e8 81 06 00 00       	call   70b <dup>
     close(p[1]);
  8a:	59                   	pop    %ecx
  8b:	ff b5 e4 f7 ff ff    	pushl  -0x81c(%ebp)
  91:	e8 25 06 00 00       	call   6bb <close>
     char buffer[16];
     read(*p,buffer,sizeof(char)); // "sleeping"
  96:	83 c4 0c             	add    $0xc,%esp
  99:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
  9f:	6a 01                	push   $0x1
  a1:	50                   	push   %eax
  a2:	ff b5 e0 f7 ff ff    	pushl  -0x820(%ebp)
  a8:	e8 fe 05 00 00       	call   6ab <read>
     close(*p);
  ad:	5b                   	pop    %ebx
  ae:	ff b5 e0 f7 ff ff    	pushl  -0x820(%ebp)
  b4:	e8 02 06 00 00       	call   6bb <close>
     while (wait() > 0);
  b9:	83 c4 10             	add    $0x10,%esp
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c0:	e8 d6 05 00 00       	call   69b <wait>
  c5:	85 c0                	test   %eax,%eax
  c7:	7f f7                	jg     c0 <main+0xc0>
   }
   printf(1, " then 2");
  c9:	50                   	push   %eax
  ca:	50                   	push   %eax
  cb:	68 ac 0e 00 00       	push   $0xeac
  d0:	6a 01                	push   $0x1
  d2:	e8 29 07 00 00       	call   800 <printf>
   exit();
  d7:	e8 b7 05 00 00       	call   693 <exit>
      close(*p);
  dc:	83 ec 0c             	sub    $0xc,%esp
  df:	ff b5 e0 f7 ff ff    	pushl  -0x820(%ebp)
  e5:	e8 d1 05 00 00       	call   6bb <close>
  		check(settickets(lowtickets) == 0, "settickets");
  ea:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  f1:	e8 3d 06 00 00       	call   733 <settickets>
  f6:	83 c4 10             	add    $0x10,%esp
  f9:	85 c0                	test   %eax,%eax
  fb:	75 44                	jne    141 <main+0x141>
      int pid_low = getpid();
  fd:	e8 11 06 00 00       	call   713 <getpid>
		  check(getpinfo(&st_before) == 0, "getpinfo");
 102:	8d b5 e8 f7 ff ff    	lea    -0x818(%ebp),%esi
 108:	83 ec 0c             	sub    $0xc,%esp
 10b:	56                   	push   %esi
      int pid_low = getpid();
 10c:	89 85 d4 f7 ff ff    	mov    %eax,-0x82c(%ebp)
		  check(getpinfo(&st_before) == 0, "getpinfo");
 112:	e8 24 06 00 00       	call   73b <getpinfo>
 117:	83 c4 10             	add    $0x10,%esp
 11a:	85 c0                	test   %eax,%eax
 11c:	74 46                	je     164 <main+0x164>
 11e:	83 ec 0c             	sub    $0xc,%esp
 121:	68 54 0e 00 00       	push   $0xe54
 126:	6a 49                	push   $0x49
 128:	68 40 0e 00 00       	push   $0xe40
 12d:	68 c0 0d 00 00       	push   $0xdc0
 132:	6a 01                	push   $0x1
 134:	e8 c7 06 00 00       	call   800 <printf>
 139:	83 c4 20             	add    $0x20,%esp
 13c:	e8 52 05 00 00       	call   693 <exit>
  		check(settickets(lowtickets) == 0, "settickets");
 141:	83 ec 0c             	sub    $0xc,%esp
 144:	68 49 0e 00 00       	push   $0xe49
 149:	6a 45                	push   $0x45
 14b:	68 40 0e 00 00       	push   $0xe40
 150:	68 88 0d 00 00       	push   $0xd88
 155:	6a 01                	push   $0x1
 157:	e8 a4 06 00 00       	call   800 <printf>
 15c:	83 c4 20             	add    $0x20,%esp
 15f:	e8 2f 05 00 00       	call   693 <exit>
		  printf(1, "\n ****PInfo before**** \n");
 164:	50                   	push   %eax
		  check(getpinfo(&st_after) == 0, "getpinfo");
 165:	8d bd e8 fb ff ff    	lea    -0x418(%ebp),%edi
		  printf(1, "\n ****PInfo before**** \n");
 16b:	50                   	push   %eax
 16c:	68 5d 0e 00 00       	push   $0xe5d
 171:	6a 01                	push   $0x1
 173:	e8 88 06 00 00       	call   800 <printf>
		  print(&st_before);
 178:	89 34 24             	mov    %esi,(%esp)
 17b:	e8 b0 00 00 00       	call   230 <print>
      printf(1,"Spinning...\n");
 180:	58                   	pop    %eax
 181:	5a                   	pop    %edx
 182:	68 76 0e 00 00       	push   $0xe76
 187:	6a 01                	push   $0x1
 189:	e8 72 06 00 00       	call   800 <printf>
		  check(getpinfo(&st_after) == 0, "getpinfo");
 18e:	89 3c 24             	mov    %edi,(%esp)
 191:	e8 a5 05 00 00       	call   73b <getpinfo>
 196:	83 c4 10             	add    $0x10,%esp
 199:	85 c0                	test   %eax,%eax
 19b:	75 59                	jne    1f6 <main+0x1f6>
		  printf(1, "\n ****PInfo after**** \n");
 19d:	50                   	push   %eax
 19e:	50                   	push   %eax
 19f:	68 83 0e 00 00       	push   $0xe83
 1a4:	6a 01                	push   $0x1
 1a6:	e8 55 06 00 00       	call   800 <printf>
		  print(&st_after);
 1ab:	89 3c 24             	mov    %edi,(%esp)
 1ae:	e8 7d 00 00 00       	call   230 <print>
		  compare(pid_low, pid_high, &st_before, &st_after);
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
 1b5:	53                   	push   %ebx
 1b6:	ff b5 d4 f7 ff ff    	pushl  -0x82c(%ebp)
 1bc:	e8 cf 00 00 00       	call   290 <compare>
		  printf(1, "Should print 1");
 1c1:	83 c4 18             	add    $0x18,%esp
 1c4:	68 9b 0e 00 00       	push   $0xe9b
 1c9:	6a 01                	push   $0x1
 1cb:	e8 30 06 00 00       	call   800 <printf>
      write(p[1],"a",sizeof(char));
 1d0:	83 c4 0c             	add    $0xc,%esp
 1d3:	6a 01                	push   $0x1
 1d5:	68 aa 0e 00 00       	push   $0xeaa
 1da:	ff b5 e4 f7 ff ff    	pushl  -0x81c(%ebp)
 1e0:	e8 ce 04 00 00       	call   6b3 <write>
      close(p[1]);
 1e5:	58                   	pop    %eax
 1e6:	ff b5 e4 f7 ff ff    	pushl  -0x81c(%ebp)
 1ec:	e8 ca 04 00 00       	call   6bb <close>
		  exit();
 1f1:	e8 9d 04 00 00       	call   693 <exit>
		  check(getpinfo(&st_after) == 0, "getpinfo");
 1f6:	83 ec 0c             	sub    $0xc,%esp
 1f9:	68 54 0e 00 00       	push   $0xe54
 1fe:	6a 50                	push   $0x50
 200:	68 40 0e 00 00       	push   $0xe40
 205:	68 f4 0d 00 00       	push   $0xdf4
 20a:	6a 01                	push   $0x1
 20c:	e8 ef 05 00 00       	call   800 <printf>
 211:	83 c4 20             	add    $0x20,%esp
 214:	e8 7a 04 00 00       	call   693 <exit>
 219:	66 90                	xchg   %ax,%ax
 21b:	66 90                	xchg   %ax,%ax
 21d:	66 90                	xchg   %ax,%ax
 21f:	90                   	nop

00000220 <spin>:
{
 220:	f3 0f 1e fb          	endbr32 
}
 224:	c3                   	ret    
 225:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <print>:
{
 230:	f3 0f 1e fb          	endbr32 
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	56                   	push   %esi
 238:	53                   	push   %ebx
 239:	8b 5d 08             	mov    0x8(%ebp),%ebx
 23c:	8d b3 00 01 00 00    	lea    0x100(%ebx),%esi
 242:	eb 0b                	jmp    24f <print+0x1f>
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
   for(i = 0; i < NPROC; i++){
 248:	83 c3 04             	add    $0x4,%ebx
 24b:	39 f3                	cmp    %esi,%ebx
 24d:	74 31                	je     280 <print+0x50>
	  if (st->inuse[i]) {
 24f:	8b 03                	mov    (%ebx),%eax
 251:	85 c0                	test   %eax,%eax
 253:	74 f3                	je     248 <print+0x18>
		  printf(1, "pid: %d tickets: %d ticks: %d\n", st->pid[i], st->tickets[i], st->ticks[i]);
 255:	83 ec 0c             	sub    $0xc,%esp
 258:	ff b3 00 03 00 00    	pushl  0x300(%ebx)
 25e:	83 c3 04             	add    $0x4,%ebx
 261:	ff b3 fc 00 00 00    	pushl  0xfc(%ebx)
 267:	ff b3 fc 01 00 00    	pushl  0x1fc(%ebx)
 26d:	68 68 0b 00 00       	push   $0xb68
 272:	6a 01                	push   $0x1
 274:	e8 87 05 00 00       	call   800 <printf>
 279:	83 c4 20             	add    $0x20,%esp
   for(i = 0; i < NPROC; i++){
 27c:	39 f3                	cmp    %esi,%ebx
 27e:	75 cf                	jne    24f <print+0x1f>
}
 280:	8d 65 f8             	lea    -0x8(%ebp),%esp
 283:	5b                   	pop    %ebx
 284:	5e                   	pop    %esi
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
 287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28e:	66 90                	xchg   %ax,%ax

00000290 <compare>:
{
 290:	f3 0f 1e fb          	endbr32 
 294:	55                   	push   %ebp
	for(i = 0; i < NPROC; i++){
 295:	31 c0                	xor    %eax,%eax
{
 297:	89 e5                	mov    %esp,%ebp
 299:	57                   	push   %edi
 29a:	56                   	push   %esi
 29b:	53                   	push   %ebx
 29c:	83 ec 1c             	sub    $0x1c,%esp
	int i, ticks_low_before=-1, ticks_low_after=-1, ticks_high_before=-1, ticks_high_after=-1;
 29f:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
{
 2a6:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 2ac:	8b 7d 10             	mov    0x10(%ebp),%edi
	int i, ticks_low_before=-1, ticks_low_after=-1, ticks_high_before=-1, ticks_high_after=-1;
 2af:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
 2b6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
 2bd:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%ebp)
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			if (before->pid[i] == pid_low){
 2c8:	8b 94 87 00 02 00 00 	mov    0x200(%edi,%eax,4),%edx
 2cf:	39 da                	cmp    %ebx,%edx
 2d1:	75 0a                	jne    2dd <compare+0x4d>
				ticks_low_before = before->ticks[i];
 2d3:	8b b4 87 00 03 00 00 	mov    0x300(%edi,%eax,4),%esi
 2da:	89 75 d8             	mov    %esi,-0x28(%ebp)
			if (before->pid[i] == pid_high){
 2dd:	39 ca                	cmp    %ecx,%edx
 2df:	75 0a                	jne    2eb <compare+0x5b>
				ticks_high_before = before->ticks[i];
 2e1:	8b b4 87 00 03 00 00 	mov    0x300(%edi,%eax,4),%esi
 2e8:	89 75 e0             	mov    %esi,-0x20(%ebp)
			if (after->pid[i] == pid_low){
 2eb:	8b 75 14             	mov    0x14(%ebp),%esi
 2ee:	8b 94 86 00 02 00 00 	mov    0x200(%esi,%eax,4),%edx
 2f5:	39 da                	cmp    %ebx,%edx
 2f7:	75 0a                	jne    303 <compare+0x73>
				ticks_low_after = after->ticks[i];
 2f9:	8b b4 86 00 03 00 00 	mov    0x300(%esi,%eax,4),%esi
 300:	89 75 e4             	mov    %esi,-0x1c(%ebp)
			if (after->pid[i] == pid_high){
 303:	39 ca                	cmp    %ecx,%edx
 305:	75 0d                	jne    314 <compare+0x84>
				ticks_high_after = after->ticks[i];
 307:	8b 75 14             	mov    0x14(%ebp),%esi
 30a:	8b b4 86 00 03 00 00 	mov    0x300(%esi,%eax,4),%esi
 311:	89 75 dc             	mov    %esi,-0x24(%ebp)
	for(i = 0; i < NPROC; i++){
 314:	83 c0 01             	add    $0x1,%eax
 317:	83 f8 40             	cmp    $0x40,%eax
 31a:	75 ac                	jne    2c8 <compare+0x38>
		printf(1, "high: %d %d, low: %d %d\n", ticks_high_before, ticks_high_after, ticks_low_before, ticks_low_after);
 31c:	8b 7d d8             	mov    -0x28(%ebp),%edi
 31f:	83 ec 08             	sub    $0x8,%esp
 322:	ff 75 e4             	pushl  -0x1c(%ebp)
 325:	57                   	push   %edi
 326:	ff 75 dc             	pushl  -0x24(%ebp)
 329:	ff 75 e0             	pushl  -0x20(%ebp)
 32c:	68 27 0e 00 00       	push   $0xe27
 331:	6a 01                	push   $0x1
 333:	e8 c8 04 00 00       	call   800 <printf>
		check(ticks_low_before >=0, "Ticks number in pinfo should be correct");
 338:	83 c4 20             	add    $0x20,%esp
 33b:	85 ff                	test   %edi,%edi
 33d:	78 3b                	js     37a <compare+0xea>
		check(ticks_low_after >=0, "Ticks number in pinfo should be correct");
 33f:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 342:	85 c9                	test   %ecx,%ecx
 344:	0f 88 bc 00 00 00    	js     406 <compare+0x176>
		check(ticks_high_before >=0, "Ticks number in pinfo should be correct");
 34a:	8b 55 e0             	mov    -0x20(%ebp),%edx
 34d:	85 d2                	test   %edx,%edx
 34f:	0f 88 8e 00 00 00    	js     3e3 <compare+0x153>
		check(ticks_high_after >=0, "Ticks number in pinfo should be correct");
 355:	8b 45 dc             	mov    -0x24(%ebp),%eax
 358:	85 c0                	test   %eax,%eax
 35a:	78 64                	js     3c0 <compare+0x130>
	check((ticks_high_after-ticks_high_before)*20 < ticks_low_after - ticks_low_before, "Expected the process with high tickets to get fewer ticks than the process with low tickets due to the former sleeping");
 35c:	8b 45 dc             	mov    -0x24(%ebp),%eax
 35f:	2b 45 e0             	sub    -0x20(%ebp),%eax
 362:	8d 14 80             	lea    (%eax,%eax,4),%edx
 365:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 368:	2b 45 d8             	sub    -0x28(%ebp),%eax
 36b:	c1 e2 02             	shl    $0x2,%edx
 36e:	39 c2                	cmp    %eax,%edx
 370:	7d 2b                	jge    39d <compare+0x10d>
}
 372:	8d 65 f4             	lea    -0xc(%ebp),%esp
 375:	5b                   	pop    %ebx
 376:	5e                   	pop    %esi
 377:	5f                   	pop    %edi
 378:	5d                   	pop    %ebp
 379:	c3                   	ret    
		check(ticks_low_before >=0, "Ticks number in pinfo should be correct");
 37a:	83 ec 0c             	sub    $0xc,%esp
 37d:	68 88 0b 00 00       	push   $0xb88
 382:	6a 32                	push   $0x32
 384:	68 40 0e 00 00       	push   $0xe40
 389:	68 b0 0b 00 00       	push   $0xbb0
 38e:	6a 01                	push   $0x1
 390:	e8 6b 04 00 00       	call   800 <printf>
 395:	83 c4 20             	add    $0x20,%esp
 398:	e8 f6 02 00 00       	call   693 <exit>
	check((ticks_high_after-ticks_high_before)*20 < ticks_low_after - ticks_low_before, "Expected the process with high tickets to get fewer ticks than the process with low tickets due to the former sleeping");
 39d:	83 ec 0c             	sub    $0xc,%esp
 3a0:	68 70 0c 00 00       	push   $0xc70
 3a5:	6a 37                	push   $0x37
 3a7:	68 40 0e 00 00       	push   $0xe40
 3ac:	68 e8 0c 00 00       	push   $0xce8
 3b1:	6a 01                	push   $0x1
 3b3:	e8 48 04 00 00       	call   800 <printf>
 3b8:	83 c4 20             	add    $0x20,%esp
 3bb:	e8 d3 02 00 00       	call   693 <exit>
		check(ticks_high_after >=0, "Ticks number in pinfo should be correct");
 3c0:	83 ec 0c             	sub    $0xc,%esp
 3c3:	68 88 0b 00 00       	push   $0xb88
 3c8:	6a 35                	push   $0x35
 3ca:	68 40 0e 00 00       	push   $0xe40
 3cf:	68 40 0c 00 00       	push   $0xc40
 3d4:	6a 01                	push   $0x1
 3d6:	e8 25 04 00 00       	call   800 <printf>
 3db:	83 c4 20             	add    $0x20,%esp
 3de:	e8 b0 02 00 00       	call   693 <exit>
		check(ticks_high_before >=0, "Ticks number in pinfo should be correct");
 3e3:	83 ec 0c             	sub    $0xc,%esp
 3e6:	68 88 0b 00 00       	push   $0xb88
 3eb:	6a 34                	push   $0x34
 3ed:	68 40 0e 00 00       	push   $0xe40
 3f2:	68 10 0c 00 00       	push   $0xc10
 3f7:	6a 01                	push   $0x1
 3f9:	e8 02 04 00 00       	call   800 <printf>
 3fe:	83 c4 20             	add    $0x20,%esp
 401:	e8 8d 02 00 00       	call   693 <exit>
		check(ticks_low_after >=0, "Ticks number in pinfo should be correct");
 406:	83 ec 0c             	sub    $0xc,%esp
 409:	68 88 0b 00 00       	push   $0xb88
 40e:	6a 33                	push   $0x33
 410:	68 40 0e 00 00       	push   $0xe40
 415:	68 e0 0b 00 00       	push   $0xbe0
 41a:	6a 01                	push   $0x1
 41c:	e8 df 03 00 00       	call   800 <printf>
 421:	83 c4 20             	add    $0x20,%esp
 424:	e8 6a 02 00 00       	call   693 <exit>
 429:	66 90                	xchg   %ax,%ax
 42b:	66 90                	xchg   %ax,%ax
 42d:	66 90                	xchg   %ax,%ax
 42f:	90                   	nop

00000430 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 430:	f3 0f 1e fb          	endbr32 
 434:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 435:	31 c0                	xor    %eax,%eax
{
 437:	89 e5                	mov    %esp,%ebp
 439:	53                   	push   %ebx
 43a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 43d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 440:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 444:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 447:	83 c0 01             	add    $0x1,%eax
 44a:	84 d2                	test   %dl,%dl
 44c:	75 f2                	jne    440 <strcpy+0x10>
    ;
  return os;
}
 44e:	89 c8                	mov    %ecx,%eax
 450:	5b                   	pop    %ebx
 451:	5d                   	pop    %ebp
 452:	c3                   	ret    
 453:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 45a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000460 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 460:	f3 0f 1e fb          	endbr32 
 464:	55                   	push   %ebp
 465:	89 e5                	mov    %esp,%ebp
 467:	53                   	push   %ebx
 468:	8b 4d 08             	mov    0x8(%ebp),%ecx
 46b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 46e:	0f b6 01             	movzbl (%ecx),%eax
 471:	0f b6 1a             	movzbl (%edx),%ebx
 474:	84 c0                	test   %al,%al
 476:	75 19                	jne    491 <strcmp+0x31>
 478:	eb 26                	jmp    4a0 <strcmp+0x40>
 47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 480:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 484:	83 c1 01             	add    $0x1,%ecx
 487:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 48a:	0f b6 1a             	movzbl (%edx),%ebx
 48d:	84 c0                	test   %al,%al
 48f:	74 0f                	je     4a0 <strcmp+0x40>
 491:	38 d8                	cmp    %bl,%al
 493:	74 eb                	je     480 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 495:	29 d8                	sub    %ebx,%eax
}
 497:	5b                   	pop    %ebx
 498:	5d                   	pop    %ebp
 499:	c3                   	ret    
 49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 4a2:	29 d8                	sub    %ebx,%eax
}
 4a4:	5b                   	pop    %ebx
 4a5:	5d                   	pop    %ebp
 4a6:	c3                   	ret    
 4a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ae:	66 90                	xchg   %ax,%ax

000004b0 <strlen>:

uint
strlen(const char *s)
{
 4b0:	f3 0f 1e fb          	endbr32 
 4b4:	55                   	push   %ebp
 4b5:	89 e5                	mov    %esp,%ebp
 4b7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 4ba:	80 3a 00             	cmpb   $0x0,(%edx)
 4bd:	74 21                	je     4e0 <strlen+0x30>
 4bf:	31 c0                	xor    %eax,%eax
 4c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4c8:	83 c0 01             	add    $0x1,%eax
 4cb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 4cf:	89 c1                	mov    %eax,%ecx
 4d1:	75 f5                	jne    4c8 <strlen+0x18>
    ;
  return n;
}
 4d3:	89 c8                	mov    %ecx,%eax
 4d5:	5d                   	pop    %ebp
 4d6:	c3                   	ret    
 4d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4de:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 4e0:	31 c9                	xor    %ecx,%ecx
}
 4e2:	5d                   	pop    %ebp
 4e3:	89 c8                	mov    %ecx,%eax
 4e5:	c3                   	ret    
 4e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ed:	8d 76 00             	lea    0x0(%esi),%esi

000004f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4f0:	f3 0f 1e fb          	endbr32 
 4f4:	55                   	push   %ebp
 4f5:	89 e5                	mov    %esp,%ebp
 4f7:	57                   	push   %edi
 4f8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 4fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 501:	89 d7                	mov    %edx,%edi
 503:	fc                   	cld    
 504:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 506:	89 d0                	mov    %edx,%eax
 508:	5f                   	pop    %edi
 509:	5d                   	pop    %ebp
 50a:	c3                   	ret    
 50b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 50f:	90                   	nop

00000510 <strchr>:

char*
strchr(const char *s, char c)
{
 510:	f3 0f 1e fb          	endbr32 
 514:	55                   	push   %ebp
 515:	89 e5                	mov    %esp,%ebp
 517:	8b 45 08             	mov    0x8(%ebp),%eax
 51a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 51e:	0f b6 10             	movzbl (%eax),%edx
 521:	84 d2                	test   %dl,%dl
 523:	75 16                	jne    53b <strchr+0x2b>
 525:	eb 21                	jmp    548 <strchr+0x38>
 527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52e:	66 90                	xchg   %ax,%ax
 530:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 534:	83 c0 01             	add    $0x1,%eax
 537:	84 d2                	test   %dl,%dl
 539:	74 0d                	je     548 <strchr+0x38>
    if(*s == c)
 53b:	38 d1                	cmp    %dl,%cl
 53d:	75 f1                	jne    530 <strchr+0x20>
      return (char*)s;
  return 0;
}
 53f:	5d                   	pop    %ebp
 540:	c3                   	ret    
 541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 548:	31 c0                	xor    %eax,%eax
}
 54a:	5d                   	pop    %ebp
 54b:	c3                   	ret    
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000550 <gets>:

char*
gets(char *buf, int max)
{
 550:	f3 0f 1e fb          	endbr32 
 554:	55                   	push   %ebp
 555:	89 e5                	mov    %esp,%ebp
 557:	57                   	push   %edi
 558:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 559:	31 f6                	xor    %esi,%esi
{
 55b:	53                   	push   %ebx
 55c:	89 f3                	mov    %esi,%ebx
 55e:	83 ec 1c             	sub    $0x1c,%esp
 561:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 564:	eb 33                	jmp    599 <gets+0x49>
 566:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 570:	83 ec 04             	sub    $0x4,%esp
 573:	8d 45 e7             	lea    -0x19(%ebp),%eax
 576:	6a 01                	push   $0x1
 578:	50                   	push   %eax
 579:	6a 00                	push   $0x0
 57b:	e8 2b 01 00 00       	call   6ab <read>
    if(cc < 1)
 580:	83 c4 10             	add    $0x10,%esp
 583:	85 c0                	test   %eax,%eax
 585:	7e 1c                	jle    5a3 <gets+0x53>
      break;
    buf[i++] = c;
 587:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 58b:	83 c7 01             	add    $0x1,%edi
 58e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 591:	3c 0a                	cmp    $0xa,%al
 593:	74 23                	je     5b8 <gets+0x68>
 595:	3c 0d                	cmp    $0xd,%al
 597:	74 1f                	je     5b8 <gets+0x68>
  for(i=0; i+1 < max; ){
 599:	83 c3 01             	add    $0x1,%ebx
 59c:	89 fe                	mov    %edi,%esi
 59e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 5a1:	7c cd                	jl     570 <gets+0x20>
 5a3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 5a8:	c6 03 00             	movb   $0x0,(%ebx)
}
 5ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ae:	5b                   	pop    %ebx
 5af:	5e                   	pop    %esi
 5b0:	5f                   	pop    %edi
 5b1:	5d                   	pop    %ebp
 5b2:	c3                   	ret    
 5b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b7:	90                   	nop
 5b8:	8b 75 08             	mov    0x8(%ebp),%esi
 5bb:	8b 45 08             	mov    0x8(%ebp),%eax
 5be:	01 de                	add    %ebx,%esi
 5c0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 5c2:	c6 03 00             	movb   $0x0,(%ebx)
}
 5c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c8:	5b                   	pop    %ebx
 5c9:	5e                   	pop    %esi
 5ca:	5f                   	pop    %edi
 5cb:	5d                   	pop    %ebp
 5cc:	c3                   	ret    
 5cd:	8d 76 00             	lea    0x0(%esi),%esi

000005d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 5d0:	f3 0f 1e fb          	endbr32 
 5d4:	55                   	push   %ebp
 5d5:	89 e5                	mov    %esp,%ebp
 5d7:	56                   	push   %esi
 5d8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5d9:	83 ec 08             	sub    $0x8,%esp
 5dc:	6a 00                	push   $0x0
 5de:	ff 75 08             	pushl  0x8(%ebp)
 5e1:	e8 ed 00 00 00       	call   6d3 <open>
  if(fd < 0)
 5e6:	83 c4 10             	add    $0x10,%esp
 5e9:	85 c0                	test   %eax,%eax
 5eb:	78 2b                	js     618 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 5ed:	83 ec 08             	sub    $0x8,%esp
 5f0:	ff 75 0c             	pushl  0xc(%ebp)
 5f3:	89 c3                	mov    %eax,%ebx
 5f5:	50                   	push   %eax
 5f6:	e8 f0 00 00 00       	call   6eb <fstat>
  close(fd);
 5fb:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 5fe:	89 c6                	mov    %eax,%esi
  close(fd);
 600:	e8 b6 00 00 00       	call   6bb <close>
  return r;
 605:	83 c4 10             	add    $0x10,%esp
}
 608:	8d 65 f8             	lea    -0x8(%ebp),%esp
 60b:	89 f0                	mov    %esi,%eax
 60d:	5b                   	pop    %ebx
 60e:	5e                   	pop    %esi
 60f:	5d                   	pop    %ebp
 610:	c3                   	ret    
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 618:	be ff ff ff ff       	mov    $0xffffffff,%esi
 61d:	eb e9                	jmp    608 <stat+0x38>
 61f:	90                   	nop

00000620 <atoi>:

int
atoi(const char *s)
{
 620:	f3 0f 1e fb          	endbr32 
 624:	55                   	push   %ebp
 625:	89 e5                	mov    %esp,%ebp
 627:	53                   	push   %ebx
 628:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 62b:	0f be 02             	movsbl (%edx),%eax
 62e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 631:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 634:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 639:	77 1a                	ja     655 <atoi+0x35>
 63b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop
    n = n*10 + *s++ - '0';
 640:	83 c2 01             	add    $0x1,%edx
 643:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 646:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 64a:	0f be 02             	movsbl (%edx),%eax
 64d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 650:	80 fb 09             	cmp    $0x9,%bl
 653:	76 eb                	jbe    640 <atoi+0x20>
  return n;
}
 655:	89 c8                	mov    %ecx,%eax
 657:	5b                   	pop    %ebx
 658:	5d                   	pop    %ebp
 659:	c3                   	ret    
 65a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000660 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 660:	f3 0f 1e fb          	endbr32 
 664:	55                   	push   %ebp
 665:	89 e5                	mov    %esp,%ebp
 667:	57                   	push   %edi
 668:	8b 45 10             	mov    0x10(%ebp),%eax
 66b:	8b 55 08             	mov    0x8(%ebp),%edx
 66e:	56                   	push   %esi
 66f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 672:	85 c0                	test   %eax,%eax
 674:	7e 0f                	jle    685 <memmove+0x25>
 676:	01 d0                	add    %edx,%eax
  dst = vdst;
 678:	89 d7                	mov    %edx,%edi
 67a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 680:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 681:	39 f8                	cmp    %edi,%eax
 683:	75 fb                	jne    680 <memmove+0x20>
  return vdst;
}
 685:	5e                   	pop    %esi
 686:	89 d0                	mov    %edx,%eax
 688:	5f                   	pop    %edi
 689:	5d                   	pop    %ebp
 68a:	c3                   	ret    

0000068b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 68b:	b8 01 00 00 00       	mov    $0x1,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret    

00000693 <exit>:
SYSCALL(exit)
 693:	b8 02 00 00 00       	mov    $0x2,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret    

0000069b <wait>:
SYSCALL(wait)
 69b:	b8 03 00 00 00       	mov    $0x3,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret    

000006a3 <pipe>:
SYSCALL(pipe)
 6a3:	b8 04 00 00 00       	mov    $0x4,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret    

000006ab <read>:
SYSCALL(read)
 6ab:	b8 05 00 00 00       	mov    $0x5,%eax
 6b0:	cd 40                	int    $0x40
 6b2:	c3                   	ret    

000006b3 <write>:
SYSCALL(write)
 6b3:	b8 10 00 00 00       	mov    $0x10,%eax
 6b8:	cd 40                	int    $0x40
 6ba:	c3                   	ret    

000006bb <close>:
SYSCALL(close)
 6bb:	b8 15 00 00 00       	mov    $0x15,%eax
 6c0:	cd 40                	int    $0x40
 6c2:	c3                   	ret    

000006c3 <kill>:
SYSCALL(kill)
 6c3:	b8 06 00 00 00       	mov    $0x6,%eax
 6c8:	cd 40                	int    $0x40
 6ca:	c3                   	ret    

000006cb <exec>:
SYSCALL(exec)
 6cb:	b8 07 00 00 00       	mov    $0x7,%eax
 6d0:	cd 40                	int    $0x40
 6d2:	c3                   	ret    

000006d3 <open>:
SYSCALL(open)
 6d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 6d8:	cd 40                	int    $0x40
 6da:	c3                   	ret    

000006db <mknod>:
SYSCALL(mknod)
 6db:	b8 11 00 00 00       	mov    $0x11,%eax
 6e0:	cd 40                	int    $0x40
 6e2:	c3                   	ret    

000006e3 <unlink>:
SYSCALL(unlink)
 6e3:	b8 12 00 00 00       	mov    $0x12,%eax
 6e8:	cd 40                	int    $0x40
 6ea:	c3                   	ret    

000006eb <fstat>:
SYSCALL(fstat)
 6eb:	b8 08 00 00 00       	mov    $0x8,%eax
 6f0:	cd 40                	int    $0x40
 6f2:	c3                   	ret    

000006f3 <link>:
SYSCALL(link)
 6f3:	b8 13 00 00 00       	mov    $0x13,%eax
 6f8:	cd 40                	int    $0x40
 6fa:	c3                   	ret    

000006fb <mkdir>:
SYSCALL(mkdir)
 6fb:	b8 14 00 00 00       	mov    $0x14,%eax
 700:	cd 40                	int    $0x40
 702:	c3                   	ret    

00000703 <chdir>:
SYSCALL(chdir)
 703:	b8 09 00 00 00       	mov    $0x9,%eax
 708:	cd 40                	int    $0x40
 70a:	c3                   	ret    

0000070b <dup>:
SYSCALL(dup)
 70b:	b8 0a 00 00 00       	mov    $0xa,%eax
 710:	cd 40                	int    $0x40
 712:	c3                   	ret    

00000713 <getpid>:
SYSCALL(getpid)
 713:	b8 0b 00 00 00       	mov    $0xb,%eax
 718:	cd 40                	int    $0x40
 71a:	c3                   	ret    

0000071b <sbrk>:
SYSCALL(sbrk)
 71b:	b8 0c 00 00 00       	mov    $0xc,%eax
 720:	cd 40                	int    $0x40
 722:	c3                   	ret    

00000723 <sleep>:
SYSCALL(sleep)
 723:	b8 0d 00 00 00       	mov    $0xd,%eax
 728:	cd 40                	int    $0x40
 72a:	c3                   	ret    

0000072b <uptime>:
SYSCALL(uptime)
 72b:	b8 0e 00 00 00       	mov    $0xe,%eax
 730:	cd 40                	int    $0x40
 732:	c3                   	ret    

00000733 <settickets>:
SYSCALL(settickets)
 733:	b8 16 00 00 00       	mov    $0x16,%eax
 738:	cd 40                	int    $0x40
 73a:	c3                   	ret    

0000073b <getpinfo>:
SYSCALL(getpinfo)
 73b:	b8 17 00 00 00       	mov    $0x17,%eax
 740:	cd 40                	int    $0x40
 742:	c3                   	ret    

00000743 <yield>:
SYSCALL(yield)
 743:	b8 18 00 00 00       	mov    $0x18,%eax
 748:	cd 40                	int    $0x40
 74a:	c3                   	ret    
 74b:	66 90                	xchg   %ax,%ax
 74d:	66 90                	xchg   %ax,%ax
 74f:	90                   	nop

00000750 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 3c             	sub    $0x3c,%esp
 759:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 75c:	89 d1                	mov    %edx,%ecx
{
 75e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 761:	85 d2                	test   %edx,%edx
 763:	0f 89 7f 00 00 00    	jns    7e8 <printint+0x98>
 769:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 76d:	74 79                	je     7e8 <printint+0x98>
    neg = 1;
 76f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 776:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 778:	31 db                	xor    %ebx,%ebx
 77a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 77d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 780:	89 c8                	mov    %ecx,%eax
 782:	31 d2                	xor    %edx,%edx
 784:	89 cf                	mov    %ecx,%edi
 786:	f7 75 c4             	divl   -0x3c(%ebp)
 789:	0f b6 92 bc 0e 00 00 	movzbl 0xebc(%edx),%edx
 790:	89 45 c0             	mov    %eax,-0x40(%ebp)
 793:	89 d8                	mov    %ebx,%eax
 795:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 798:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 79b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 79e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 7a1:	76 dd                	jbe    780 <printint+0x30>
  if(neg)
 7a3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 7a6:	85 c9                	test   %ecx,%ecx
 7a8:	74 0c                	je     7b6 <printint+0x66>
    buf[i++] = '-';
 7aa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 7af:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 7b1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 7b6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 7b9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 7bd:	eb 07                	jmp    7c6 <printint+0x76>
 7bf:	90                   	nop
 7c0:	0f b6 13             	movzbl (%ebx),%edx
 7c3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 7c6:	83 ec 04             	sub    $0x4,%esp
 7c9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 7cc:	6a 01                	push   $0x1
 7ce:	56                   	push   %esi
 7cf:	57                   	push   %edi
 7d0:	e8 de fe ff ff       	call   6b3 <write>
  while(--i >= 0)
 7d5:	83 c4 10             	add    $0x10,%esp
 7d8:	39 de                	cmp    %ebx,%esi
 7da:	75 e4                	jne    7c0 <printint+0x70>
    putc(fd, buf[i]);
}
 7dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7df:	5b                   	pop    %ebx
 7e0:	5e                   	pop    %esi
 7e1:	5f                   	pop    %edi
 7e2:	5d                   	pop    %ebp
 7e3:	c3                   	ret    
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7e8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 7ef:	eb 87                	jmp    778 <printint+0x28>
 7f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ff:	90                   	nop

00000800 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 800:	f3 0f 1e fb          	endbr32 
 804:	55                   	push   %ebp
 805:	89 e5                	mov    %esp,%ebp
 807:	57                   	push   %edi
 808:	56                   	push   %esi
 809:	53                   	push   %ebx
 80a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 80d:	8b 75 0c             	mov    0xc(%ebp),%esi
 810:	0f b6 1e             	movzbl (%esi),%ebx
 813:	84 db                	test   %bl,%bl
 815:	0f 84 b4 00 00 00    	je     8cf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 81b:	8d 45 10             	lea    0x10(%ebp),%eax
 81e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 821:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 824:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 826:	89 45 d0             	mov    %eax,-0x30(%ebp)
 829:	eb 33                	jmp    85e <printf+0x5e>
 82b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 82f:	90                   	nop
 830:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 833:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 838:	83 f8 25             	cmp    $0x25,%eax
 83b:	74 17                	je     854 <printf+0x54>
  write(fd, &c, 1);
 83d:	83 ec 04             	sub    $0x4,%esp
 840:	88 5d e7             	mov    %bl,-0x19(%ebp)
 843:	6a 01                	push   $0x1
 845:	57                   	push   %edi
 846:	ff 75 08             	pushl  0x8(%ebp)
 849:	e8 65 fe ff ff       	call   6b3 <write>
 84e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 851:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 854:	0f b6 1e             	movzbl (%esi),%ebx
 857:	83 c6 01             	add    $0x1,%esi
 85a:	84 db                	test   %bl,%bl
 85c:	74 71                	je     8cf <printf+0xcf>
    c = fmt[i] & 0xff;
 85e:	0f be cb             	movsbl %bl,%ecx
 861:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 864:	85 d2                	test   %edx,%edx
 866:	74 c8                	je     830 <printf+0x30>
      }
    } else if(state == '%'){
 868:	83 fa 25             	cmp    $0x25,%edx
 86b:	75 e7                	jne    854 <printf+0x54>
      if(c == 'd'){
 86d:	83 f8 64             	cmp    $0x64,%eax
 870:	0f 84 9a 00 00 00    	je     910 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 876:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 87c:	83 f9 70             	cmp    $0x70,%ecx
 87f:	74 5f                	je     8e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 881:	83 f8 73             	cmp    $0x73,%eax
 884:	0f 84 d6 00 00 00    	je     960 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 88a:	83 f8 63             	cmp    $0x63,%eax
 88d:	0f 84 8d 00 00 00    	je     920 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 893:	83 f8 25             	cmp    $0x25,%eax
 896:	0f 84 b4 00 00 00    	je     950 <printf+0x150>
  write(fd, &c, 1);
 89c:	83 ec 04             	sub    $0x4,%esp
 89f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8a3:	6a 01                	push   $0x1
 8a5:	57                   	push   %edi
 8a6:	ff 75 08             	pushl  0x8(%ebp)
 8a9:	e8 05 fe ff ff       	call   6b3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 8ae:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 8b1:	83 c4 0c             	add    $0xc,%esp
 8b4:	6a 01                	push   $0x1
 8b6:	83 c6 01             	add    $0x1,%esi
 8b9:	57                   	push   %edi
 8ba:	ff 75 08             	pushl  0x8(%ebp)
 8bd:	e8 f1 fd ff ff       	call   6b3 <write>
  for(i = 0; fmt[i]; i++){
 8c2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 8c6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8c9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 8cb:	84 db                	test   %bl,%bl
 8cd:	75 8f                	jne    85e <printf+0x5e>
    }
  }
}
 8cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8d2:	5b                   	pop    %ebx
 8d3:	5e                   	pop    %esi
 8d4:	5f                   	pop    %edi
 8d5:	5d                   	pop    %ebp
 8d6:	c3                   	ret    
 8d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8de:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 8e0:	83 ec 0c             	sub    $0xc,%esp
 8e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 8e8:	6a 00                	push   $0x0
 8ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 8ed:	8b 45 08             	mov    0x8(%ebp),%eax
 8f0:	8b 13                	mov    (%ebx),%edx
 8f2:	e8 59 fe ff ff       	call   750 <printint>
        ap++;
 8f7:	89 d8                	mov    %ebx,%eax
 8f9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8fc:	31 d2                	xor    %edx,%edx
        ap++;
 8fe:	83 c0 04             	add    $0x4,%eax
 901:	89 45 d0             	mov    %eax,-0x30(%ebp)
 904:	e9 4b ff ff ff       	jmp    854 <printf+0x54>
 909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 910:	83 ec 0c             	sub    $0xc,%esp
 913:	b9 0a 00 00 00       	mov    $0xa,%ecx
 918:	6a 01                	push   $0x1
 91a:	eb ce                	jmp    8ea <printf+0xea>
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 920:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 923:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 926:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 928:	6a 01                	push   $0x1
        ap++;
 92a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 92d:	57                   	push   %edi
 92e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 931:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 934:	e8 7a fd ff ff       	call   6b3 <write>
        ap++;
 939:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 93c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 93f:	31 d2                	xor    %edx,%edx
 941:	e9 0e ff ff ff       	jmp    854 <printf+0x54>
 946:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 94d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 950:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 953:	83 ec 04             	sub    $0x4,%esp
 956:	e9 59 ff ff ff       	jmp    8b4 <printf+0xb4>
 95b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 95f:	90                   	nop
        s = (char*)*ap;
 960:	8b 45 d0             	mov    -0x30(%ebp),%eax
 963:	8b 18                	mov    (%eax),%ebx
        ap++;
 965:	83 c0 04             	add    $0x4,%eax
 968:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 96b:	85 db                	test   %ebx,%ebx
 96d:	74 17                	je     986 <printf+0x186>
        while(*s != 0){
 96f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 972:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 974:	84 c0                	test   %al,%al
 976:	0f 84 d8 fe ff ff    	je     854 <printf+0x54>
 97c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 97f:	89 de                	mov    %ebx,%esi
 981:	8b 5d 08             	mov    0x8(%ebp),%ebx
 984:	eb 1a                	jmp    9a0 <printf+0x1a0>
          s = "(null)";
 986:	bb b4 0e 00 00       	mov    $0xeb4,%ebx
        while(*s != 0){
 98b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 98e:	b8 28 00 00 00       	mov    $0x28,%eax
 993:	89 de                	mov    %ebx,%esi
 995:	8b 5d 08             	mov    0x8(%ebp),%ebx
 998:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 99f:	90                   	nop
  write(fd, &c, 1);
 9a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 9a3:	83 c6 01             	add    $0x1,%esi
 9a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9a9:	6a 01                	push   $0x1
 9ab:	57                   	push   %edi
 9ac:	53                   	push   %ebx
 9ad:	e8 01 fd ff ff       	call   6b3 <write>
        while(*s != 0){
 9b2:	0f b6 06             	movzbl (%esi),%eax
 9b5:	83 c4 10             	add    $0x10,%esp
 9b8:	84 c0                	test   %al,%al
 9ba:	75 e4                	jne    9a0 <printf+0x1a0>
 9bc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 9bf:	31 d2                	xor    %edx,%edx
 9c1:	e9 8e fe ff ff       	jmp    854 <printf+0x54>
 9c6:	66 90                	xchg   %ax,%ax
 9c8:	66 90                	xchg   %ax,%ax
 9ca:	66 90                	xchg   %ax,%ax
 9cc:	66 90                	xchg   %ax,%ax
 9ce:	66 90                	xchg   %ax,%ax

000009d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9d0:	f3 0f 1e fb          	endbr32 
 9d4:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d5:	a1 dc 11 00 00       	mov    0x11dc,%eax
{
 9da:	89 e5                	mov    %esp,%ebp
 9dc:	57                   	push   %edi
 9dd:	56                   	push   %esi
 9de:	53                   	push   %ebx
 9df:	8b 5d 08             	mov    0x8(%ebp),%ebx
 9e2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 9e4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e7:	39 c8                	cmp    %ecx,%eax
 9e9:	73 15                	jae    a00 <free+0x30>
 9eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9ef:	90                   	nop
 9f0:	39 d1                	cmp    %edx,%ecx
 9f2:	72 14                	jb     a08 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f4:	39 d0                	cmp    %edx,%eax
 9f6:	73 10                	jae    a08 <free+0x38>
{
 9f8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9fa:	8b 10                	mov    (%eax),%edx
 9fc:	39 c8                	cmp    %ecx,%eax
 9fe:	72 f0                	jb     9f0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a00:	39 d0                	cmp    %edx,%eax
 a02:	72 f4                	jb     9f8 <free+0x28>
 a04:	39 d1                	cmp    %edx,%ecx
 a06:	73 f0                	jae    9f8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a08:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a0b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a0e:	39 fa                	cmp    %edi,%edx
 a10:	74 1e                	je     a30 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a12:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a15:	8b 50 04             	mov    0x4(%eax),%edx
 a18:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a1b:	39 f1                	cmp    %esi,%ecx
 a1d:	74 28                	je     a47 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a1f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 a21:	5b                   	pop    %ebx
  freep = p;
 a22:	a3 dc 11 00 00       	mov    %eax,0x11dc
}
 a27:	5e                   	pop    %esi
 a28:	5f                   	pop    %edi
 a29:	5d                   	pop    %ebp
 a2a:	c3                   	ret    
 a2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a2f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 a30:	03 72 04             	add    0x4(%edx),%esi
 a33:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a36:	8b 10                	mov    (%eax),%edx
 a38:	8b 12                	mov    (%edx),%edx
 a3a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a3d:	8b 50 04             	mov    0x4(%eax),%edx
 a40:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a43:	39 f1                	cmp    %esi,%ecx
 a45:	75 d8                	jne    a1f <free+0x4f>
    p->s.size += bp->s.size;
 a47:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a4a:	a3 dc 11 00 00       	mov    %eax,0x11dc
    p->s.size += bp->s.size;
 a4f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a52:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a55:	89 10                	mov    %edx,(%eax)
}
 a57:	5b                   	pop    %ebx
 a58:	5e                   	pop    %esi
 a59:	5f                   	pop    %edi
 a5a:	5d                   	pop    %ebp
 a5b:	c3                   	ret    
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a60 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a60:	f3 0f 1e fb          	endbr32 
 a64:	55                   	push   %ebp
 a65:	89 e5                	mov    %esp,%ebp
 a67:	57                   	push   %edi
 a68:	56                   	push   %esi
 a69:	53                   	push   %ebx
 a6a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a70:	8b 3d dc 11 00 00    	mov    0x11dc,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a76:	8d 70 07             	lea    0x7(%eax),%esi
 a79:	c1 ee 03             	shr    $0x3,%esi
 a7c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 a7f:	85 ff                	test   %edi,%edi
 a81:	0f 84 a9 00 00 00    	je     b30 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a87:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 a89:	8b 48 04             	mov    0x4(%eax),%ecx
 a8c:	39 f1                	cmp    %esi,%ecx
 a8e:	73 6d                	jae    afd <malloc+0x9d>
 a90:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 a96:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a9b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 a9e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 aa5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 aa8:	eb 17                	jmp    ac1 <malloc+0x61>
 aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 ab2:	8b 4a 04             	mov    0x4(%edx),%ecx
 ab5:	39 f1                	cmp    %esi,%ecx
 ab7:	73 4f                	jae    b08 <malloc+0xa8>
 ab9:	8b 3d dc 11 00 00    	mov    0x11dc,%edi
 abf:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ac1:	39 c7                	cmp    %eax,%edi
 ac3:	75 eb                	jne    ab0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 ac5:	83 ec 0c             	sub    $0xc,%esp
 ac8:	ff 75 e4             	pushl  -0x1c(%ebp)
 acb:	e8 4b fc ff ff       	call   71b <sbrk>
  if(p == (char*)-1)
 ad0:	83 c4 10             	add    $0x10,%esp
 ad3:	83 f8 ff             	cmp    $0xffffffff,%eax
 ad6:	74 1b                	je     af3 <malloc+0x93>
  hp->s.size = nu;
 ad8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 adb:	83 ec 0c             	sub    $0xc,%esp
 ade:	83 c0 08             	add    $0x8,%eax
 ae1:	50                   	push   %eax
 ae2:	e8 e9 fe ff ff       	call   9d0 <free>
  return freep;
 ae7:	a1 dc 11 00 00       	mov    0x11dc,%eax
      if((p = morecore(nunits)) == 0)
 aec:	83 c4 10             	add    $0x10,%esp
 aef:	85 c0                	test   %eax,%eax
 af1:	75 bd                	jne    ab0 <malloc+0x50>
        return 0;
  }
}
 af3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 af6:	31 c0                	xor    %eax,%eax
}
 af8:	5b                   	pop    %ebx
 af9:	5e                   	pop    %esi
 afa:	5f                   	pop    %edi
 afb:	5d                   	pop    %ebp
 afc:	c3                   	ret    
    if(p->s.size >= nunits){
 afd:	89 c2                	mov    %eax,%edx
 aff:	89 f8                	mov    %edi,%eax
 b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 b08:	39 ce                	cmp    %ecx,%esi
 b0a:	74 54                	je     b60 <malloc+0x100>
        p->s.size -= nunits;
 b0c:	29 f1                	sub    %esi,%ecx
 b0e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 b11:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 b14:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 b17:	a3 dc 11 00 00       	mov    %eax,0x11dc
}
 b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b1f:	8d 42 08             	lea    0x8(%edx),%eax
}
 b22:	5b                   	pop    %ebx
 b23:	5e                   	pop    %esi
 b24:	5f                   	pop    %edi
 b25:	5d                   	pop    %ebp
 b26:	c3                   	ret    
 b27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 b2e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 b30:	c7 05 dc 11 00 00 e0 	movl   $0x11e0,0x11dc
 b37:	11 00 00 
    base.s.size = 0;
 b3a:	bf e0 11 00 00       	mov    $0x11e0,%edi
    base.s.ptr = freep = prevp = &base;
 b3f:	c7 05 e0 11 00 00 e0 	movl   $0x11e0,0x11e0
 b46:	11 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b49:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 b4b:	c7 05 e4 11 00 00 00 	movl   $0x0,0x11e4
 b52:	00 00 00 
    if(p->s.size >= nunits){
 b55:	e9 36 ff ff ff       	jmp    a90 <malloc+0x30>
 b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 b60:	8b 0a                	mov    (%edx),%ecx
 b62:	89 08                	mov    %ecx,(%eax)
 b64:	eb b1                	jmp    b17 <malloc+0xb7>
