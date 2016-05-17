package kg.ash.javavi.actions;

public class ActionFactory {

    public static Action get(String action) {
        switch (action) {
            case "-E":
                return new GetClassInfoAction();
            case "-p":
                return new GetPackageInfoAction();
            case "-s":
                return new GetClassInfoFromSourceAction();
            case "-class-packages":
                return new GetClassPackagesAction();
            case "-similar-classes":
                return new FilterSimilarClassesAction();
            case "-similar-annotations":
                return new FilterSimilarAnnotationsAction();
            case "-D":
                return new ExecuteDaemonAction();
            case "-unused-imports":
                return new GetUnusedImportsAction();
            case "-missing-imports":
                return new GetMissingImportsAction();
            case "-clear-from-cache":
                return new RemoveClassInfoFromCache();
        }

        return null;
    }
    
}
