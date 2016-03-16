### Why is it called the '5 Minute Install' ?

Because it takes 3 minutes to download the [FlexSearch package].

### Install FlexSearch

1. Dowload the [FlexSearch package]
2. Extract `FlexSearch.<version_number>.zip` into a folder (assume `C:\FlexSearch`)
3. From a command line @ `C:\FlexSearch` run:

    ```
    > FlexSearch-Server.exe -i
    > FlexSearch-Server.exe --start
    ```
    This installs FlexSearch as a service, then starts the service. 

4. [**Optional**] Create a demo index called `country`:

    Go to the [Demo Index] page and click the `SET UP` button at the bottom right side of the screen.

[FlexSearch package]: https://github.com/flexsearch/flexsearch/releases
[Demo Index]: http://localhost:9800/portal/apps/demoindex/#/demoindex

### Access the portal

Just navigate to this URL in your browser to access the portal and all the apps that come free with FlexSearch:

```
http://localhost:9800
```