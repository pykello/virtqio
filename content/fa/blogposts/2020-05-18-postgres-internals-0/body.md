در این سری از ویدئوها به بررسی اینکه پستگرس (Postgres یا PostgreSQL) چگونه کار می‌کند می‌پردازیم. برخی از سوالاتی که سعی می‌کنیم به آن‌ها پاسخ دهیم:

1. پستگرس چگونه داده‌ها را ذخیره می‌کند؟
2. پستگرس چگونه همروندی را مدیریت می‌کند؟
3. پستگرس چگونه خطا را مدیریت می‌کند؟
4. پستگرس چگونه query ها را اجرا می‌کند؟

این سری ویدئوها به آموزش استفاده از پستگرس نمی‌پردازند، و فرض می‌کند که شما تا حدی با مفهوم پایگاه داده و نرم‌افزار پستگرس و زبان SQL (در حد مقدماتی) آشنا هستید.


### کامپایل و نصب پستگرس

اجرای مراحل زیر را در این ویدئو نیز می‌توانید مشاهده کنید: [youtu.be/F1R1qDQghLY](https://youtu.be/F1R1qDQghLY)

**نصب پیش نیازها**

برای لیست نرم‌افزارهایی که پیش‌نیاز کامپایل پستگرس هستند به این لینک مراجعه کنید:
[PostgreSQL 12 Requirements](https://www.postgresql.org/docs/12/install-requirements.html)

برای نصب پیش‌نیازها در اوبونتو:

```
sudo apt-get install build-essential libreadline-dev zlib1g-dev
sudo apt-get install flex bison git
```

برای نصب پیش‌نیازها در ردهت:

```
sudo yum install -y bison-devel readline-devel zlib-devel flex git
sudo yum groupinstall -y 'Development Tools'
```

**دریافت سورس‌کد و کامپایل**

ابتدا مسیری را برای نصب پستگرس در نظر بگیرید:

```
export PGPATH=$HOME/pg/12
```

سپس سورس‌کد را از مخزن پستگرس در گیت‌هاب دریافت کرده و به شاخه نسخه ۱۲ بروید:

```
git clone https://github.com/postgres/postgres.git
cd postgres
git checkout REL_12_STABLE
```

و بالاخره کامپایل و نصب:

```
./configure --prefix=$PGPATH --enable-cassert --enable-debug --enable-depend
make -j 8
make install

# install some extensions
make -C contrib/pageinspect/ install
make -C contrib/pg_buffercache/ install
make -C contrib/pg_visibility/ install
make -C contrib/pgstattuple/ install
make -C contrib/pg_freespacemap/ install
make -C contrib/pgrowlocks/ install
```

سپس فایل‌های باینری پستگرس را به مسیر اضافه کنید:

```
echo PATH=$PGPATH/bin:\$PATH >> ~/.bashrc
export PATH=$PGPATH/bin:$PATH
```

برای امتحان اینکه نصب پستگرس با موفقیت انجام شده است، دستور زیر را اجرا کنید:

```
pg_config --version
```

خروجی دستور بالا باید چیزی مثل `PostgreSQL 12.3` باشد.

**اجرای پستگرس**

ابتدا مسیری برا برای قرار دادن فایل‌های کلاستر پستگرستان در نظر بگریرید:

```
export PGDATA=$HOME/pg/data
echo PGDATA=$PGDATA >> ~/.bashrc
```

سپس کلاستر پستگرس را ایجاد کنید:

```
initdb -D $PGDATA
```

سپس پستگرس را اجرا کنید:

```
pg_ctl -D $PGDATA -l $HOME/pg/log start
```

اکنون باید بتوانید با کلاینت psql به پستگرس متصل بشوید:

```
psql -d postgres
```

### لینک‌ها

* [کامیت‌فست پستگرس](https://wiki.postgresql.org/wiki/CommitFest)
* [مشارکت کنندگان پستگرس](https://www.postgresql.org/community/contributors/)
* [لیست افراد با دسترسی کامیت](https://wiki.postgresql.org/wiki/Committers)
* [مطلبی درباره مشارکت‌های جولیان آسانژ](http://herraiz.org/blog/2011/07/07/software-projects-alzheimer-julian-assanges-lost-contributions/)


### سایر مطالب آموزشی مرتبط
* [بلاگ Egor Rogov درباره پستگرس](https://habr.com/en/users/erogov/posts/)
* [وبسایت The Internals of PostgreSQL](http://www.interdb.jp/pg/)
* [درس Intro to Database Systems دانشگاه CMU](https://www.youtube.com/playlist?list=PLSE8ODhjZXjbohkNBWQs_otTrBTrjyohi)
* [ویدئوهای کنفرانس PGCon](https://www.youtube.com/channel/UCer4R0y7DrLsOXo-bI71O6A/videos)

