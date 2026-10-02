let lest_start = false

const Button_Inputs = {
    plus: document.getElementById('plus'),
    negative: document.getElementById('negative')
}

const _Image = document.getElementById('Image_help');
const _Text = document.getElementById('Text_help');
const _title = document.getElementById('Title_help');

const data = [
    {
        img: "../assets/img/help/a1.JPG",
        text: "سجد أيقونة الإضافة مفعلة كما هو موضح بالصورة أنقر عليها إن لم تضهر تأكد من تفعيل الإضافة في الإعدادات > الإضافات",
        title: "1- الدخول للوحة الإضافة"
    },

    {
        img: "../assets/img/help/a2.JPG",
        text: "ستجد في قسم the_video زر إسمه Select أنقر عليه كما هو موضح في الصورة بالأسفل",
        title: "2 - إختيار الفديو المراد تصديره"
    },

    {
        img: "../assets/img/help/a3.JPG",
        text: "ستجد نافذة إختيار ملفات إبحث عن مسار ملف الفديو الخاص بك و إختره ثم إضغط على زر open كما مبين في الصورة أسفله",
        title: "3 - إختيار الفديو من مساره"
    },

    {
        img: "../assets/img/help/a4.JPG",
        text: "في قسم Dir_Export ستجد زر إسمه Select أنقر عليه كما هو مبين في الصورة الموالية :",
        title: "4 - إختيار إسم ومسار الملف الناتج"
    },

    {
        img: "../assets/img/help/a5.JPG",
        text: "أنقر على القائمة (كما مبين في الرقم 1) و إختر صيغة الفديو الأفضل أن تختار ogv لأنه أكثر إستقرارا ثم سمي الملف كما مبين في الرقم 2 و حدد مساره في مشروعك و إضغط على زر ok",
        title: "5 - إختيار مسار وصيغة الفديو الناتج"
    },

    {
        img: "../assets/img/help/a6.JPG",
        text: "بعد إختيار الفديو و تجهيز مساره في المشروع عليك بالضغط على زر import video كما موضح في الصورة",
        title: "6 - بدء مرحلة التصدير"
    },

    {
        img: "../assets/img/help/a7.JPG",
        text: "سيبدو لك أن المحرك توقف عن العمل لكنه ليس كذالك و سيضل على تلك الحالة حتى إكتمال تصدير الفديو لذا لا تغلقه مهما حدث و بعد انتهاء إستراد الفديو للمشروع المفروض ضهور رسالة كما هو موضح في Console",
        title: " 7 - بداية الإنشاء الداخلي"
    },

    {
        img: "../assets/img/help/a8.JPG",
        text: "بعد الإنتها من إستراد الفديو ستجده في المسار الذي حددته أثناء عملية التصدير يمكنك إستخدامه في المشغل الخاص بك",
        title: "8 - نجاح الإستراد"
    }
];

const _max = data.length - 1;
let _value = 0;

function changed(i = null){
    if(i === null) return;
    _value += i;

    if(_value < 0) _value = _max;
    if(_value > _max) _value = 0;

    draw();
}

function draw(){
    _Image.src = data[_value]["img"];
    _Text.textContent = data[_value]["text"];
    _title.textContent = data[_value]["title"];

    if(lest_start) window.location.href = "#box_help";
    if(!lest_start) lest_start = true;
}

Button_Inputs["plus"].addEventListener("click", (e)=> {changed(1); });
Button_Inputs["negative"].addEventListener("click", (e)=> {changed(-1)});

draw()