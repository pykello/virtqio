در این نوشته خلاصه‌‌ای از ویدئویی که چند روز پیش با عنوان «درونیجات پستگرس - زندگی یک کوئری» ضبط کردم را ارائه می‌دهم.

می‌خواهیم به این سوال بپردازیم که وقتی یک کوئری مثل `SELECT * FROM t` در پستگرس اجرا می‌کنیم، چه اتفاقهایی در پشت صحنه می‌افتد.

لینک ویدئو: [youtu.be/Z09rG7cLzF8](https://youtu.be/Z09rG7cLzF8)

<!-- more -->

### پیش‌نیازها

اگر می‌خواهید گام‌هایی که در این مقاله ذکر شده‌اند را اجرا کنید، نیاز دارید پستگرس را کامپایل و نصب کنید، که گام‌های لازم برای این امر را در 
[این مقاله](/fa/blogposts/2020-05-18-postgres-internals-0.html) آورده‌ام.

همچنین نیاز به نصب tcpflow دارید که در اوبونتو با دستور `sudo apt install tcpflow` می‌توانید نصب کنید.

## وصل شدن کلاینت به پستگرس

برای ایجاد کلاستر پستگرس و اجرای آن دستورات زیر را وارد کنید:

```
initdb -D data
pg_ctl -D data -l logfile
```

پس از اینکه پستگرس ایجاد شد، یک پردازه اصلی و چند پردازه فرعی ایجاد می‌کند. پس از اجرای دستورات بالا، می‌توانیم از دستور ps
برای دیدن پردازه‌هایی که پستگرس ایجاد کرده استفاده کنیم:

```
$ ps ef --forest -C postgres
  PID TTY      STAT   TIME COMMAND
24695 ?        Ss     0:00 /home/hadi/pg/12/bin/postgres -D data
24697 ?        Ss     0:00  \_ postgres: checkpointer
24698 ?        Ss     0:00  \_ postgres: background writer
24699 ?        Ss     0:00  \_ postgres: walwriter
24700 ?        Ss     0:00  \_ postgres: autovacuum launcher
24701 ?        Ss     0:00  \_ postgres: stats collector
24702 ?        Ss     0:00  \_ postgres: logical replication launcher
```

در نتیجه بالا پردازه شماره 24695 پردازه اصلی است و بقیه یک سری پردازه مربوط به کارهای داخلی پستگرس.

#### پستگرس برای هر کلاینت یک پردازه جدا ایجاد می‌کند

اکنون دو پنجره باز کنید و در هر کدام از آنها با برنامه psql به پستگرس متصل شوید:

```
# window 1
$ psql -d postgres -h localhost

# window 2
$ psql -d postgres -h localhost
```

در پنجره‌ای دیگر دستور ps را برای یافتن پردازه‌های پستگرس و psql اجرا کنید:

```
$ ps ef --forest -C psql
  PID TTY      STAT   TIME COMMAND
24817 pts/7    S+     0:00 psql -d postgres -h localhost
24767 pts/6    S+     0:00 psql -d postgres -h localhost

$ ps ef --forest -C postgres
  PID TTY      STAT   TIME COMMAND
24695 ?        Ss     0:00 /home/hadi/pg/12/bin/postgres -D data
24697 ?        Ss     0:00  \_ postgres: checkpointer
24698 ?        Ss     0:00  \_ postgres: background writer
24699 ?        Ss     0:00  \_ postgres: walwriter
24700 ?        Ss     0:00  \_ postgres: autovacuum launcher
24701 ?        Ss     0:00  \_ postgres: stats collector
24702 ?        Ss     0:00  \_ postgres: logical replication launcher
24768 ?        Ss     0:00  \_ postgres: hadi postgres 127.0.0.1(55904) idle 4) idle
24818 ?        Ss     0:00  \_ postgres: hadi postgres 127.0.0.1(55906) idle 6) idle
```

همانطور که مشاهده می‌کنید پستگرس دو پردازه به شماره 24768 و 24818 ایجاد کرده که هر کدام از آن‌ها به پردازه‌های psql به شماره‌های
24817 و 24767 متصل شده‌اند.

حتی اگر به جای psql برنامه شما بود که به پستگرس وصل می‌شد، باز شما به ازای هر ارتباط یک پردازه جدید می‌دیدید.

#### پستگرس از پروتکل لایه ارتباطی TCP برای ارتباط با کلاینت‌ها استفاده می‌کند.

همچنان که دو کلاینت psql در حال اجرا هستند، دستور زیر را برای لیست کردن ارتباطات شبکه بین پردازه‌ها اجرا کنید:

```
$ lsof | grep "localhost:postgres"
postgres  24695  hadi  3u   IPv4    91393    0t0    TCP localhost:postgresql (LISTEN)
psql      24767  hadi  3u   IPv4    86470    0t0    TCP localhost:55904->localhost:postgresql (ESTABLISHED)
postgres  24768  hadi  8u   IPv4    91419    0t0    TCP localhost:postgresql->localhost:55904 (ESTABLISHED)
psql      24817  hadi  3u   IPv4    86481    0t0    TCP localhost:55906->localhost:postgresql (ESTABLISHED)
postgres  24818  hadi  8u   IPv4    91432    0t0    TCP localhost:postgresql->localhost:55906 (ESTABLISHED)
```

پستگرس به صورت پیش‌فرض به پورت 5432 گوش می‌کند. دستور lsof برای خوانا شدن خروجی به جای 5432 از "postgresql" استفاده کرده است.

مواردی که از خروجی بالا می‌فهمیم:

1. پردازه postgres به شماره 24695 که پدر همه پردازه‌ها در خروجی ps بود، به پورت TCP  پستگرس یا همان 5432 گوش می‌کند و منتظر درخواست ارتباط جدید است.
2. پردازه psql با شماره 24767 پورت محلی 55904 را برای انتخاب کرده است و به پردازه postgres با شماره 24768 با استفاده پورت TCP پستگرس یا همان 5432 وصل شده است.
3. همچنین پردازه psql به شماره 24817 به پردازه postgres با شماره 24818 وصل شده است.

#### پروتکل لایه کاربردی پستگرس

برای مشاهده اینکه کلاینت پستگرس چگونه پرسش‌ها را به پستگرس می‌فرستد و پستگرس چگونه به این پرسش‌ها پاسخ می‌دهد، ابتدا با یکی از psql هایی که اجرا کردید، یک جدول برای تمرین ایجاد کنید:

```
CREATE TABLE t(a int, b text);
INSERT INTO t VALUES (1, 'a'), (2, 'b');
```

اکنون در پنجره‌ای دیگر دستور tcpflow را برای گوش کردن به ترافیک پستگرس اجرا کنید:

```
sudo tcpflow -D -c port 5432 -i lo
```

در دستور بالا `port 5432` مشخص می‌کند که به پورت پستگرس گوش می‌کنیم و `-i lo` مشخص می‌کند که به رابط شبکه محلی گوش می‌دهیم.

اکنون دستور زیر را در psql اجرا کنید و خروجی آن را مشاهده کنید:

```
postgres=# select * from t;
 a | b
---+---
 1 | a
 2 | b
(2 rows)
```

در پنجره tcpflow خروجی شبیه زیر را مشاهده خواهید کرد:

```
127.000.000.001.55906-127.000.000.001.05432:
0000: 5100 0000 1573 656c 6563 7420 2a20 6672 6f6d 2074 3b00  Q....select * from t;.

127.000.000.001.05432-127.000.000.001.55906:
0000: 5400 0000 2e00 0261 0000 0040 0000 0100 0000 1700 04ff ffff ff00 0062 0000 0040  T......a...@...............b...@
0020: 0000 0200 0000 19ff ffff ffff ff00 0044 0000 0010 0002 0000 0001 3100 0000 0161  ...............D..........1....a
0040: 4400 0000 1000 0200 0000 0132 0000 0001 6243 0000 000d 5345 4c45 4354 2032 005a  D..........2....bC....SELECT 2.Z
0060: 0000 0005 49
```

که بخش اول این خروجی نشان می‌دهد که کلاینت کوئری را چگونه به پستگرس ارسال کرد، و بخش دوم نشان می‌دهد که پستگرس برای پاسخ به این کوئری
چه دنباله از بایت‌ها را به کلاینت فرستاد. اگر به بخش پاسخ دقت کنید، تمام اطلاعاتی که در خروجی کوئری دید را در اینجا نیز تشخصی خواهید داد.

برای مشاهده جزییات پروتکل پستگرس به [بخش «قالب پیام پروتکل» در مستندات پستگرس](https://www.postgresql.org/docs/current/protocol-message-formats.html) مشاهده کنید. به عنوان نمونه، در مستندات برای پیام کوئری آمده است:

```
Query (F)
  Byte1('Q')
     Identifies the message as a simple query.

  Int32
     Length of message contents in bytes, including self.

  String
     The query string itself.
```

و اگر به خروجی tcpflow دقت کنید، برای ارسال کوئری ابتدا یک Q ارسال شد، سپس طول کوئری به صورت یک عدد صحیح ۴ بایتی (دنباله 00 00 00 15 در بخش هگزادسیمال)، و سپس خود کوئری به صورت متنی.

## پردازش کوئری

بین دریافت کوئری و ارسال پاسخ چه اتفاقی می‌افتد؟

به صورت کلی، مراحی پردازش کوئری عبارتند از:

:::figure postgres-flow.svg
alt: Postgres Flow
:::

### مرحله Parse و Analyze

پس از اینکه پستگرس کوئری را به صورت متنی دریافت کرد، آن را پردازش می‌کند و به داده ساختار داخلی کوئری تبدیل می‌کند. این مرحله از ۲ گام تشکیل شده است:

   1. مرحله Parse که توسط تابع [raw_parser](https://github.com/postgres/postgres/blob/1c1cbe279b3c6e8038c8f8079402f069bb4cea4c/src/backend/parser/parser.c#L42) پیاده‌سازی شده و ساختار کلی کوئری را درمی‌آورد.
   2. مرحله آنالیز که توسط تابع [parse_analyze](https://github.com/postgres/postgres/blob/055fee7eb4dcc78e58672aef146334275e1cc40d/src/backend/parser/analyze.c#L104) پیاده‌سازی شده و اشاره‌گرهای موجود در کوئری را ارزیابی می‌کند. مثلا اشاره‌گر به یک جدول یا ستون‌های جدول.

این داده ساختار در فایل [src/include/nodes/parsenodes.h](https://github.com/postgres/postgres/blob/055fee7eb4dcc78e58672aef146334275e1cc40d/src/include/nodes/parsenodes.h#L116) تعریف شده است:

```c
typedef struct Query
{
    NodeTag type;
    CmdType    commandType;
    QuerySource querySource;
...
}
```

برای اینکه حاصل این تبدیل را ببینید، ابتدا تنظیمات زیر را در پنجره psql انجام دهید:

```
SET client_min_messages TO log;
SET debug_print_parse TO true;
```

و سپس کوئری را اجرا کنید:

```
SELECT a, b FROM t;
```

خروجی مرحله Parse به صورت زیر چاپ خواهد شد. بخشی از خروجی را به علت طولانی بودن حذف کرده‌ام:

```
LOG:  parse tree:
DETAIL:     {QUERY
   :commandType 1
...
   :rtable (
      {RTE
      :alias <>
      :eref
         {ALIAS
         :aliasname t
         :colnames ("a" "b")
         }
      :rtekind 0
      :relid 16384
...
      }
   )
...
   :targetList (
      {TARGETENTRY
      :expr
         {VAR
         :varno 1
         :varattno 1
         :vartype 23
...
         }
...
      }
      {TARGETENTRY
      :expr
         {VAR
         :varno 1
         :varattno 2
         :vartype 25
...
         }
...
      }
   )
...
   }
```

اکنون به بررسی بخش‌هایی از این خروجی می‌پردازیم:

#### نوع کوئری

بخش اولی که در خروجی Parse به آن دقت می‌کنیم، `:commandType 1` است که مشخص می‌کند که این کوئری SELECT است. مقدار این متغیر از
لیست ثوابت زیر در کد پستگرس انتخاب می‌شود:

```c
typedef enum CmdType
{
    CMD_UNKNOWN,
    CMD_SELECT,
    CMD_UPDATE,
    CMD_INSERT,
    CMD_DELETE,
    CMD_UTILITY, /* cmds like create, destroy, copy, vacuum, etc. */
    CMD_NOTHING
} CmdType;
```

همانطور که میدانید، در زبان سی اعضای enum مقدار عددی معادل موقعیت خود را دریافت می‌کنند، و در اینجا CMD_SELECT معادل 1 خواهد بود.

* [لینک تعریف CmdType](https://github.com/postgres/postgres/blob/9eacee2e62d89cab7b004f97c206c4fba4f1d745/src/include/nodes/nodes.h#L681)

#### اطلاعات مربوط به بخش FROM

بخش rtable یک لیست از مواردی هستند که در بخش FROM کوئری آمده است. که در این مورد فقط جدول t است. همانطور که مشاهده می‌کنید،
با یک شماره `:relid 16384‍` مشخص شده است. پستگرس اطلاعات مربوط به جدول‌ها را در جدول سیستمی pg_class نگهداری می‌کند. برای اینکه ببنیم
برای جدول ما چه اطلاعاتی ذخیره شده است، می‌توانیم کوئری زیر را اجرا کنیم:

```
\x

SELECT * FROM pg_class WHERE oid=16384;
-[ RECORD 1 ]-------+------
oid                 | 16384
relname             | t
relnamespace        | 2200
reltype             | 16386
reloftype           | 0
relowner            | 10
...
```

در کد بالا `\x` برای این بود که پستگرس به جای ستونی، خروجی را به صورت سطری نشان دهد.

#### اطلاعات مربوط به ستون‌های انتخاب شده

یکی از بخش‌های جالب خروجی مرحله Parse لیست targetList است که در خروجی بالا ۲ عنصر از نوع TargetEntry دارد که هر کدام شامل یک Var یا همان متغیر یا همان یک
اشاره‌گر به ستون‌های جدول است. مقدار `varno` شماره جدول در بخش FROM و مقدار `varattno` شماره ستون در آن جدول را مشخص می‌کند. مثلا متغیر
زیر یعنی ستون دوم از جدول اول:

```
      {TARGETENTRY
      :expr
         {VAR
         :varno 1
         :varattno 2
         :vartype 25
...
         }
...
      }
```

مقدار `vartype` شماره نوع آن ستون را مشخص می‌کند. این شماره به یک سطر در جدول `pg_type` اشاره می‌کند. مثلا برای نوع شماره 23:

```
SELECT * FROM pg_type WHERE oid=23;
-[ RECORD 1 ]--+---------
oid            | 23
typname        | int4
typnamespace   | 11
typowner       | 10
typlen         | 4
typbyval       | t
typtype        | b
...
typinput       | int4in
typoutput      | int4out
typreceive     | int4recv
typsend        | int4send
...
```

که نشان میدهد نوع شماره 23 عدد صحیح ۴ بایتی است که توسط int4out به رشته تبدیل می‌شود و توسط int4in از رشته ایجاد می‌شود. در ویدئو به بررسی
بیشتر تابع int4in پرداختیم.

* [لینک تعریف int4in](https://github.com/postgres/postgres/blob/ca3b37487be333a1d241dab1bbdd17a211a88f43/src/backend/utils/adt/int.c#L266)
* [لینک تعریف pg_strtoint32 که int4in از آن استفاده می‌کند](https://github.com/postgres/postgres/blob/ca3b37487be333a1d241dab1bbdd17a211a88f43/src/backend/utils/adt/numutils.c#L263)

#### مرحله آنالیز

اگر در کوئری اسم جدول را اشتباه بنویسیم، خطایی رخ خواهد داد:

```
SELECT a, b FROM t2;
ERROR:  relation "t2" does not exist
LINE 1: select a, b from t2;
```

این که آیا واقعا جدول اشاره شده و سایر موارد اشاره شده (مثل ستون‌ها) وجود دارند، در مرحل آنالیز انجام می‌شود.

در مورد نام جدول، تابع `transformSelectStmt` در مرحله آنالیز صدا می‌شود که پس از چند مرحله تابع `parserOpenTable` را صدا می‌کند که بررسی می‌کند
آیا واقعا جدول وجود دارد یا نه و در صورت عدم وجود خطا می‌دهد:

```c
Relation
parserOpenTable(ParseState *pstate, const RangeVar *relation, int lockmode)
{
    rel = table_openrv_extended(relation, lockmode, true);
    if (rel == NULL)
    {
...
                ereport(ERROR,
                        (errcode(ERRCODE_UNDEFINED_TABLE),
                         errmsg("relation \"%s\" does not exist",
                                relation->relname)));
...
    }
...
    return rel;
}
```

* [لینک به تعریف transformSelectStmt](https://github.com/postgres/postgres/blob/055fee7eb4dcc78e58672aef146334275e1cc40d/src/backend/parser/analyze.c#L1200)
* [لینک به تعریف parserOpenTable](https://github.com/postgres/postgres/blob/055fee7eb4dcc78e58672aef146334275e1cc40d/src/backend/parser/parse_relation.c#L1350)


### مرحله بازنویسی (Rewrite)

در این مرحله برای خیلی از کوئری‌ها و به خصوص کوئری بالای ما اتفاقی نمی‌افتد و حاصل بازنویسی دقیقا همان حاصل مرحله Parse است.

ولی اگر کوئری شما شامل یک View باشد، حاصل بخش parse فقط شامل اسم View است و حاصل مرحله بازنویسی، View را با کوئری که معادل View 
است جایگزین می‌شود.

حاصل این مرحله را می‌توانید با روشن کردن `debug_print_rewritten` مشاهده کنید.

به عنوان مثال، دستورات زیر را اجرا کنید:

```
CREATE VIEW t_view AS SELECT count(*) FROM t;
SET client_min_messages TO log;
SET debug_print_parse TO true;
SET debug_print_rewritten TO true;
```

و سپس کوئری زیر را اجرا کنید:

```
SELECT * FROM t_view;
```

و خروجی مراحل Parse و بازنویسی را مقایسه کنید.

در ویدئو این کار را انجام دادیم، ولی اینجا به خاطر حجم از این بخش عبور می‌کنیم.


### مرحله ایجاد طرح اجرا (Plan)

تا این مرحله پستگرس کوئری را Parse کرده است، ولی هنوز تصمیم نگرفته است آن را چگونه اجرا کند.
در این مرحله تصمیم می‌گیرد که کوئری قرار است چگونه اجرا شود. حاصل این مرحله یک مقدار از نوع ساختار [PlannedStmt](https://github.com/postgres/postgres/blob/055fee7eb4dcc78e58672aef146334275e1cc40d/src/include/nodes/plannodes.h#L42) است.



برای مشاهده حاصل این مرحله می‌توانید پارامتر تنظیم debug_print_plan را فعال کنید:


```
SET client_min_messages TO log;
SET debug_print_plan TO true;
```

اکنون اگر کوئری را اجرا کنیم، حاصل این مرحله به صورت زیر چاپ خواهد شد که به علت صرفه‌جویی در فضا بخش‌هایی از آن را حذف کرده‌ایم

```
postgres=# SELECT a, b FROM t;
LOG:  plan:
DETAIL:     {PLANNEDSTMT 
	   :commandType 1 
...
	   :planTree 
	      {SEQSCAN 
...
	      :qual <> 
...
	      }
...
	   }
```

همانطور که مشاهده می‌کنید، طرح اجرای این کوئری بسیار ساده و شامل تنها یک SeqScan است که کد مربوط به آن را
می‌توانید در [nodeSeqScan.c](https://github.com/postgres/postgres/blob/c30f54ad732ca5c8762bb68bbe0f51de9137dd72/src/backend/executor/nodeSeqscan.c) بیابید.

حال کوئری را با افزودن یک شرط پیچیده‌تر می‌کنیم و مشاهده می‌کنیم که بخش qual حاصل تغییر می‌کند:

```
postgres=# SELECT a, b FROM t WHERE a > 1;
LOG:  plan:
DETAIL:     {PLANNEDSTMT 
	   :commandType 1 
...
	   :planTree 
	      {SEQSCAN 
...
	      :qual (
	         {OPEXPR 
	         :opno 521 
	         :opfuncid 147 
	         :opresulttype 16 
...
	         :args (
	            {VAR 
	            :varno 1 
	            :varattno 1 
...
	            }
	            {CONST 
	            :consttype 23 
...
	            :constvalue 4 [ 1 0 0 0 0 0 0 0 ]
	            }
	         )
	         :location 27
	         }
	      )
...
	      }
...
	   }
```

اکنون بخش qual یک مقدار از نوع OpExpr است که از تابع شماره 147 برای مقایسه ستون اول جدول با ثابت صحیح 1 استفاده می‌کند.

برای اینکه بفهمیم تابع شماره 147 چه تابعی است، می‌توانیم به جدول سیستمی pg_proc مراجعه کنیم:

```
postgres=# SELECT * FROM pg_proc WHERE oid=147; 
-[ RECORD 1 ]---+-------
oid             | 147
proname         | int4gt
...
prorettype      | 16
proargtypes     | 23 23
...
```

مشاهده می‌کنیم که اسم این تابع int4gt است که کد مربوط به آن را در [src/backend/utils/adt/int.c](https://github.com/postgres/postgres/blob/c30f54ad732ca5c8762bb68bbe0f51de9137dd72/src/backend/utils/adt/int.c#L411) می‌توانید بیابید. پیاده‌سازی این تابع بسیار ساده است و
دو آرگومان را مقایسه و نتیجه را به صورت بولین برمی‌گرداند:

```c
Datum
int4gt(PG_FUNCTION_ARGS)
{
	int32		arg1 = PG_GETARG_INT32(0);
	int32		arg2 = PG_GETARG_INT32(1);

	PG_RETURN_BOOL(arg1 > arg2);
}
```

برای اینکه بتوانید به جای PlannedStmt، طرح اجرا به صورت خواناتر برای انسان دریافت کنید، می‌توانید از EXPLAIN استفاده کنید:

```
postgres=# EXPLAIN SELECT a, b FROM t WHERE a > 1;
                     QUERY PLAN
-----------------------------------------------------
 Seq Scan on t  (cost=0.00..25.88 rows=423 width=36)
   Filter: (a > 1)
(2 rows)
```

برای مشاهده یک طرح اجرای پیچیده‌تر، از یک join استفاده می‌کنیم:

```
postgres=# EXPLAIN SELECT t1.a,t1.b, t2.a FROM t t1,t t2 WHERE t1.a=t2.a;
                             QUERY PLAN
---------------------------------------------------------------------
 Merge Join  (cost=176.34..303.67 rows=8064 width=40)
   Merge Cond: (t1.a = t2.a)
   ->  Sort  (cost=88.17..91.35 rows=1270 width=36)
         Sort Key: t1.a
         ->  Seq Scan on t t1  (cost=0.00..22.70 rows=1270 width=36)
   ->  Sort  (cost=88.17..91.35 rows=1270 width=4)
         Sort Key: t2.a
         ->  Seq Scan on t t2  (cost=0.00..22.70 rows=1270 width=4)
(8 rows)
```

مشاهده می‌کنیم که پستگرس از الگوریتم Merge Join برای اجرای این کوئری استفاده می‌کند.

#### بهینه‌سازی طرح اجرا

پستگرس برای اجرای یک کوئری می‌تواند از الگوریتم‌های مختلف استفاده کند. مثلا برای Join می‌تواند از (۱) مرتب‌سازی و ادغام، یا (۲) استفاده از جدول هش، یا (۳) از حلقه تو در تو استفاده کند. که در مثال بالا از مرتب‌سازی و ادغام استفاده کرد.

در مرحله بهینه‌سازی، پستگرس طرح‌های مختلف را ایجاد می‌کند، هزینه هر کدام را تخمین میزند، و کم هزینه‌ترین را انتخاب می‌کند. مثلا در مثال بالا تخمین پستگرس برای هر مرحله ذکر شده و تخمین پستگرس برای کل کوئری 303.67 است.

اگر به مثال بالا دقت کنید، مشاهده می‌کنید که تخمین پستگرس از تعداد سطرهای جدول t نادرست است، و بنابراین شاید بهترین طرح اجرا را انتخاب نکرده باشد.
برای اینکه پستگرس بتواند تخمین بهتری بزند، از دستور ANALYZE برای جمع‌آوری یک سری داده آماری برای جدول استفاده می‌کنیم:

```
ANALYZE t;
```

و دوباره دستور EXPLAIN را اجرا می‌کنیم:

```
postgres=# EXPLAIN SELECT t1.a, t1.b, t2.a FROM t t1,t t2 WHERE t1.a=t2.a;
                           QUERY PLAN
----------------------------------------------------------------
 Nested Loop  (cost=0.00..2.10 rows=2 width=10)
   Join Filter: (t1.a = t2.a)
   ->  Seq Scan on t t1  (cost=0.00..1.02 rows=2 width=6)
   ->  Materialize  (cost=0.00..1.03 rows=2 width=4)
         ->  Seq Scan on t t2  (cost=0.00..1.02 rows=2 width=4)
(5 rows)
```

مشاهده می‌کنیم که پستگرس این دفعه تخمین‌های بهتری زده است و تصمیم گرفته است برای این کوئری از حلقه تو در تو استفاده کند.

### مرحله اجرا

در این مرحله پستگرس طرح اجرایی که در مرحله پیش ایجاد شد را به صورت بازگشتی اجرا می‌کند. مثلا برای طرح اجرای بالا، کد موجود در 
 [nodeSeqScan.c](https://github.com/postgres/postgres/blob/c30f54ad732ca5c8762bb68bbe0f51de9137dd72/src/backend/executor/nodeSeqscan.c) برای خواندن جدول‌ها، و کد موجود در [nodeNestLoop.c](https://github.com/postgres/postgres/blob/c30f54ad732ca5c8762bb68bbe0f51de9137dd72/src/backend/executor/nodeNestloop.c) برای عمل Join به صورت حلقه تو در تو اجرا می‌شود.


## تکالیف کار در خانه 😉

1. پستگرس را کامپایل و نصب کنید و یک کلاستر ایجاد کنید.
2. مراحل توضیح شده در این مقاله یا در ویدئو را تا جایی که برایتان جالب است اجرا کنید.
3. کوئری‌های مختلف اجرا کنید و حاصل مراحل Parse و Plan را بررسی کنید.
4. کامنت‌های مربوط به ساختار Query را در فایل [src/include/node/parsenodes.h](https://github.com/postgres/postgres/blob/055fee7eb4dcc78e58672aef146334275e1cc40d/src/include/nodes/parsenodes.h) بخوانید.
5. سعی کنید پیاده‌سازی تابع pg_strtoint32 را تغییر دهید و به جای اعداد منفی از اعداد مثبت استفاده کنید، ولی متغیر حاصل را از نوع عدد ۶۴ بیتی درنظر بگیرید تا مشکل در کمترین مقدار پیش نیاید. دقت کنید که پیاده‌سازی این تابع را در این مقاله توضیح ندادیم و تنها در ویدئو توضیح دادیم.

اگر مشکلی در دنبال کردن این مقاله یا ویدئو داشتید، اگر پیشنهاد یا انتقادی داشتید، یا اگر سوالی داشتید، میتوانید از روش‌های زیر با من تماس بگیرید:

1. پیام مستقیم در تویتر به اکانت pykello_fa
2. ایمیل به hadi [at] moshayedi [dot] net.

ممنون که وقت گذاشتید و امیدوارم استفاده کرده باشید.
