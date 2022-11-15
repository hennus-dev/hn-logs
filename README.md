---
description: standalone system to create logs on our server
---

# Laz-logs

## SUPORT 
{% embed url="https://discord.com/invite/yDXK7qcBfx" %}

## DOCS

{% embed url="https://lazarus-dev.gitbook.io/en/laz-logs" %}
## Laz-Logs:LogFields

{% tabs %}
{% tab title="client" %}
```lua
TriggerServerEvent('Laz-Logs:LogFields',
    typewebhook,
    title,
    Description,
    color,
    footer,
    field,
    id,
    tag -- true or false
    )
```
{% endtab %}

{% tab title="Server" %}
```lua
TriggerEvent('Laz-Logs:LogFields',
typewebhook, 
title, 
Description, 
color, 
footer, 
field, 
id,
tag  -- true or false
)
```
{% endtab %}
{% endtabs %}

### field

```lua
field = {
    name = 'option Title',
    value = 'option value',
    inline = true --true or false
}
```

{% hint style="warning" %}
## Desactive description

* ```lua
  TriggerServerEvent('Laz-Logs:LogFields',
  typewebhook,
  title,
  false,
  color,
  footer,
  field,
  id,
  tag -- true pr false
  )
  ```
{% endhint %}

{% hint style="info" %}
## Active mentions

* <pre class="language-lua"><code class="lang-lua">TriggerServerEvent('Laz-Logs:LogFields',
  <strong>typewebhook,
  </strong>title,
  description,
  color,
  footer,
  field,
  id,
  true
  )</code></pre>
{% endhint %}

## Laz-Logs:SimplyLog

{% tabs %}
{% tab title="Client" %}
```lua
TriggerServerEvent('Laz-Logs:SimplyLog',
typewebhook,
title, 
color, 
'Inventario', 
text,
tag -- true or false
)
```
{% endtab %}

{% tab title="Server" %}
```lua
TriggerEvent('Laz-Logs:SimplyLog',
typewebhook,
title, 
color, 
'Inventario', 
text,
tag -- true or false
)
```
{% endtab %}
{% endtabs %}