import java.io.File;
import polyglot.visit.DataFlow;
import soot.*;
import soot.jimple.infoflow.android.InfoflowAndroidConfiguration;
import soot.jimple.toolkits.callgraph.CallGraph;
import soot.options.Options;
import soot.jimple.infoflow.InfoflowConfiguration;
import soot.jimple.infoflow.android.SetupApplication;
import soot.jimple.infoflow.android.config.SootConfigForAndroid;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CFG {
  
    public CFG() {}

    public static void main(String[] args) {

        String packages[] = {"org.*","kotlin.*", "*.sdk.*","java.*", "androidx.*","javax.*", "com.google.*", "com.android.*","*.BuildConfig*"}; 

        List<String> excludePackagesList = Arrays.asList(packages);

        InfoflowConfiguration.CallgraphAlgorithm cgAlgorithm = InfoflowConfiguration.CallgraphAlgorithm.SPARK;
        SootConfigForAndroid sootConf = new SootConfigForAndroid() {
            @Override
            public void setSootOptions(Options options, InfoflowConfiguration config) {
                super.setSootOptions(options, config);
                options.v().set_exclude(excludePackagesList);
                options.v().set_allow_phantom_refs(true);
                options.v().set_no_bodies_for_excluded(true);
                options.v().set_whole_program(true);
            }
        };


        InfoflowAndroidConfiguration config = new InfoflowAndroidConfiguration();
        config.getAnalysisFileConfig().setAndroidPlatformDir("/opt/android-sdk/platforms");
        config.getAnalysisFileConfig().setTargetAPKFile(args[0]);
        config.setMergeDexFiles(true);
        config.setCodeEliminationMode(InfoflowConfiguration.CodeEliminationMode.NoCodeElimination);
        config.setCallgraphAlgorithm(cgAlgorithm);
        
        SetupApplication analyzer = new SetupApplication(config);
        analyzer.setSootConfig(sootConf);
        analyzer.constructCallgraph();

        CallGraph cg = Scene.v().getCallGraph();

        System.out.println(cg);
     }
}