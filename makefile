GNU的make工作时的执行步骤入下：（想来其它的make也是类似）

    1、读入所有的Makefile。
    2、读入被include的其它Makefile。
    3、初始化文件中的变量。
    4、推导隐晦规则，并分析所有规则。
    5、为所有的目标文件创建依赖关系链。
    6、根据依赖关系，决定哪些目标要重新生成。
    7、执行生成命令。

.PHONY : clean
  clean :
       -rm edit $(objects)
   .PHONY意思表示clean是一个“伪目标”，。而在rm命令前面加了一个小减号的意思就是，
   也许某些文件出现问题，但不要管，继续做后面 的事。
   当然，clean的规则不要放在文件的开头，不然，这就会变成make的默认目标，
   相信谁也不愿意这样。不成文的规矩是——“clean从来都是放 在文件的最后”。

2.  不想让 make 打印出每条要执行的命令，可以在命令前加上 @ 符号
    @echo "hello"
3.假设 Makefile 所在的目录下有一个 clean 文件，那么当我们运行 make clean 时，将无法正常执行。因为些时 make 会把 clean 当成文件来处理，而不是当成命令。这种目录文件名与 Makefile 中的目标名重名的情况是很难避免的，也是我们不希望看到的.使用 .PHONY关键声明一个目标后， make 并不会将其当做一个文件来处理。
4.如果目标名或先决条件名发生了改变，那么我们就必须相应的修改所有的命令，为了省去这种麻烦，我们可以使用如下自动变量。
  $@  用于表示一个规则中的目标，当一个规则中有多个目标时，$@ 所指的是其中任何造成规则命令被运行的目标；
  $^  表示的是规则中的所有先决条件；
  $<  表示的是规则中的第一个先决条件。
        @echo "\$$@=$@"
	@echo "$$^=$^"
	@echo "$$<=$<"
在 Makefile 中 “$” 有特殊的意思，如果想用 echo 输出 “$” ，就必须用两个连着的 “$” ； “$@” 对于 Bash shell 也有特殊的意思，需要在 “$$@” 之前再加一个脱字符 “\” 
5.MAKECMDGOALS 变量表示的是当前构建的目标名
6. 简单扩展变量，是用 “ := ” 操作符来定义的，对于这种变量，make 只对其进行一次扩展.即“=”可以从下面赋值，“：=”只能从上面赋值。
7.“ ?= ” 操作符，当变量没定义时就定义它，并且将右边的值赋值给它；如果变量已经定义了，则不改变其原值。“ += ” 实现追加赋值的功能。
8.使用 override 指令后，x 变量的值不可覆盖了，而且 Makefile 中对它进行追加赋值也失效了。override x = main.o
9.%.o : %.c

    $(CC) -o $@ -c $^
10.abspath 函数：   ROOT := $(abspath /usr ../lib)   返回：  /usr ../lib绝对路径。
   notdir 函数：  names := $(notdir lion/mode1/src/test.c lion/mode2/src/temp.c) 返回：test.c temp.c
   realpath 函数： result := $(realpath ./..)  返回真实路径。
   addprefix 函数： $(addprefix objs/,$(without_dir))  给.. 添加objs/前缀。 
   addsuffix 函数：添加后缀。
   filter 函数： obj:= $(filter %.c %.h,$(obj)) 在$(obj)过滤得到%.c,%.h文件。
   filter-out 函数：result = $(filter-out foo%.c, $(obj)) 在$(obj)过滤foo%.c文件。
   patsubst 函数：result := $(patsubst %.c, %.o, $(names)) 把%.c替换%.o.
   strip 函数： second := $(strip $(first))  把$(first)的空格删除。
   wildcard 函数：用于得到当前工作目录中满足 pattern 模式的文件或目录名列表 srcFile = $(wildcard *.c)。

11.  可以为某个目标设置局部变量，这种变量被称为“Target-specific Variable”，它可以和“全局变量”同名，因为它的作用范围只在这条规则以及连带规则中，所以其值也只在作用范围内有效。
     其语法是：
    <target ...> : <variable-assignment>
    <target ...> : overide <variable-assignment>
    eg:
     prog : CFLAGS = -g
     prog : prog.o foo.o bar.o
            $(CC) $(CFLAGS) prog.o foo.o bar.o
     在这个示例中，不管全局的$(CFLAGS)的值是什么，在prog目标，以及其所引发的所有规则中（prog.o foo.o bar.o的规则），$(CFLAGS)的值都是“-g”.
12.











































