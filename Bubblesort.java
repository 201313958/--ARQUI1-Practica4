import java.util.Vector;

public class MyClass {
    
    public static void main(String args[]) {
        int temp;
        int count = 0;
        int[] vector = {2,12,3,21,24,1,54,65,5,26,11,0};
        
        for (int i=0; i<vector.length; i++){
            for (int j=0 ; j<vector.length - 1; j++){
                if (vector[j] > vector[j+1]){
                    temp = vector[j];
                    vector[j] = vector[j+1];
                    vector[j+1] = temp;
                    
                }
                count++;
            }
        }
        System.out.println(count);
        System.out.println("--------------------------------------");
        for (int i=0; i<vector.length; i++){
            System.out.println(vector[i]);
        }
    }
}
/*0, 1, 2, 3, 5, 11, 12, 21, 24, 26, 54, 65*/