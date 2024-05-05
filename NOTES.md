# Course notes

Plugins types
- Normal: no /app, no config (you are not merging an app with another app) LEARN MORE: https://www.youtube.com/watch?v=UKK7emQ4zhg
- Full: no issolating name conflicts (no real use case)
- Mountable: The most

gemspec - meta for the engine
allowed_push_host - for private stuff
spec.files - files that will be present in the final gem to distribute

```
# avoid clashing
isolate_namespace TurboClone
```
/lib/task -> auto install

test/dummy -> rails app, automated test and manual test
---

### Do the intall in the root folder

```ruby
# engine.rb is the glue
initializer "turbo.helper" do
  ActiveSupport.on_load :action_controller_base do
    helper TurboClone::Engine.helpers
  end
end
```

bunble and test from root folder


### For testing
```ruby
require "test_helper"

class TurboClone::FramesHelperTest < ActionView::TestCase
end
```

render body: "helo"
