-keep @expo.modules.core.interfaces.DoNotStrip class *
-keepclassmembers class * {
  @expo.modules.core.interfaces.DoNotStrip *;
}

-keep class * implements expo.modules.kotlin.records.Record {
  *;
}
-keep class * extends expo.modules.kotlin.sharedobjects.SharedObject
-keep enum * implements expo.modules.kotlin.types.Enumerable {
  *;
}
-keepnames class kotlin.Pair

-keep,allowoptimization,allowobfuscation class * extends expo.modules.kotlin.modules.Module {
  public <init>();
  public expo.modules.kotlin.modules.ModuleDefinitionData definition();
}

-keepclassmembers class * implements expo.modules.kotlin.views.ExpoView {
  public <init>(android.content.Context);
  public <init>(android.content.Context, expo.modules.kotlin.AppContext);
}

-keepclassmembers class * {
  expo.modules.kotlin.viewevent.ViewEventCallback *;
}

-keepclassmembers class * {
  expo.modules.kotlin.viewevent.ViewEventDelegate *;
}

-keep class * implements expo.modules.kotlin.views.ComposeProps {
  *;
}

-keepnames class * implements expo.modules.kotlin.views.ExpoView {
  *;
}
