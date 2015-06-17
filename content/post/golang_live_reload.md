+++
date = "2015-06-17T10:09:31+03:00"
draft = false
title = "Golang live reload"
description = "How to autoreload golang binary when develop web application"

+++
When you working with web frameworks you always have ability for atomatic reload you
developing site. Go programs is static binary so you need to rebuild them every time
you make changes in sources. It's too boring, so best practice is to use reload
tools...

---

``` java
public class AwesomeTabbedActivity extends Activity {

    @Override
    public void onCreate(final Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.awesome_tabbed_layout);
        
        // Standard tabbed navigation setup.
        final ActionBar actionBar = getActionBar();
        actionBar.setDisplayShowTitleEnabled(true);
        actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_TABS);
        
        // ...
        // Create tabs, fragments, pager and anything else needed.
        // ...
        
        forceTabs(); // Force tabs when activity starts.
    }
    
    @Override
    public void onConfigurationChanged(final Configuration config) {
        super.onConfigurationChanged(config);
        forceTabs(); // Handle orientation changes.
    }

    // This is where the magic happens!
    public void forceTabs() {
        try {
            final ActionBar actionBar = getActionBar();
            final Method setHasEmbeddedTabsMethod = actionBar.getClass()
                .getDeclaredMethod("setHasEmbeddedTabs", boolean.class);
            setHasEmbeddedTabsMethod.setAccessible(true);
            setHasEmbeddedTabsMethod.invoke(actionBar, true);
        }
        catch(final Exception e) {
            // Handle issues as needed: log, warn user, fallback etc
            // This error is safe to ignore, standard tabs will appear.
        }
    }

}
```
