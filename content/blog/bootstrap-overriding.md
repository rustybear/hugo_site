+++
tags = ["css", "bootstrap"
]
categories = ["coding"
]
date = "2016-11-21T12:40:07-05:00"
title = "bootstrap overriding"
banner = "img/banners/bootstrap-html5-css3.png"
draft = false

+++

How do I override bootstrap.css so that I remove the style for an anchor/class?
For example, if I want to remove some or all the styling rules for legend:

```
legend {
  display: block;
  width: 100%;
  padding: 0;
  margin-bottom: 20px;
  font-size: 21px;
  line-height: inherit;
  color: #333333;
  border: 0;
  border-bottom: 1px solid #e5e5e5;
}
```

Would you use ```!important``` like this:

```
legend {
  display: inherit !important;
  width: 100%;
  padding: 0;
  margin-bottom: inherit !important;
  font-size: 21px;
  line-height: inherit;
  color: inherit !important;
  border: 0;
  border-bottom: 1px solid #e5e5e5;
}
```



Using ```!important``` is not a good option, as you will most likely want to
override your own styles in the future. That leaves us with CSS priorities.

Basically, every selector has its own numerical 'weight':

```
100 points for IDs
10 points for classes and pseudo-classes
1 point for tag selectors and pseudo-elements
```

Among two selector styles browser will always choose the one with more weight.
Order of your stylesheets only matters when priorities are even - that's why
it is not easy to override Bootstrap.

Your option is to inspect Bootstrap sources, find out how exactly some
specific style is defined, and copy that selector so your element has equal
priority. But we kinda loose all Bootstrap sweetness in the process.

The easiest way to overcome this is to assign additional arbitrary ID to one
of the root elements on your page, like this: <body id="bootstrap-overrides">

This way, you can just prefix any CSS selector with your ID, instantly adding
100 points of weight to the element, and overriding Bootstrap definition:

```
/* Example selector defined in Bootstrap */
.jumbotron h1 { /* 10+1=11 priority scores */
  line-height: 1;
  color: inherit;
}

/* Your initial take at styling */
h1 { /* 1 priority score, not enough to override Bootstrap jumbotron definition */
  line-height: 1;
  color: inherit;
}

/* New way of prioritization */
#bootstrap-overrides h1 { /* 100+1=101 priority score, yay! */
  line-height: 1;
  color: inherit;
}
```

Since IDs can only be used once, why not make #bootstrap-overrides a class?

Because you would end up having to calculate better. if it were a class in this
example it would be prio 11 and if the css definition would be after the
bootstrap.css then we would be good to go. However this would be pretty close
and setting it as an id which boosts the prio big time, we don't have to worry
about calculating prio and testing as hard whether we have it always right.
easier with an id if you want to definitively overwrite the default.Other things to remember:

In the head section of your html place your custom.css below bootstrap.css.

Other things to remember:

```
<link href="bootstrap.min.css" rel="stylesheet">
<link href="custom.css" rel="stylesheet">
```

Then in custom.css you have to use the exact same selector for the element you
want to override. In the case of ```legend``` it just stays ```legend``` in
your custom.css because bootstrap hasn't got any selectors more specific.


```
legend {
  display: inline;
  width: auto;
  padding: 0;
  margin: 0;
  font-size: medium;
  line-height: normal;
  color: #000000;
  border: 0;
  border-bottom: none;
}
```
But in case of ```h1``` for example you have to take care of the more specific selectors like ```.jumbotron h1``` because

```
h1 {
  line-height: 2;
  color: #f00;
}
```

will not override

```
.jumbotron h1,
.jumbotron .h1 {
  line-height: 1;
  color: inherit;
}
```

Here are some best practices to follow :

+ Always load custom css after base css file (not responsive).
+ Avoid using ```!important``` if possible. That can override some important stylings from base.
+ Always load bootstrap-responsive.css after custom.css if you don't want to lose media queries.
+ Prefer modifying required properties (not all)


