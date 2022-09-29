# Customise your TIaaS

These HTML templates will override default snippets in the TIaaS website. This allows you to customise text content on your TIaaS deployment to represent your Galaxy service accurately.

The templates are broken down into webpages (folders) and sections (files). Each one is quite short and therefore easy to edit.

For example, look at `./about/1_intro.html`. This is what will be displayed at the top of the TIaaS about page (i.e. the landing page):

```html
<p>
  We are proud to provide Training Infrastructure as a Service
  (TIaaS) for the Galaxy training community. You provide the training, we
  provide the infrastructure and cover all costs.
</p>
```

You may wish to change this to something like...

```html
<p>
  We are proud to provide Training Infrastructure as a Service
  (TIaaS) for the Galaxy Antarctica community. You provide the training, we
  provide the infrastructure and cover all costs. Hey, maybe we'll even throw
  in a few icebergs and penguins!
</p>
```
