public class HelloWorld{

     public static void main(String []args){
        int[] vector = {3,12,4,21,24,2,54,65,5,26,11,1};
        /*for (int i=0; i<vector.length; i++){
            System.out.print(vector[i] + ", ");
        }//*/
        System.out.println("");
        HelloWorld hola = new HelloWorld();
        hola.Quicksort(vector, 0, vector.length-1);
        
        for (int i=0; i<vector.length; i++){
            System.out.print(vector[i] + ", ");
        }
        
     }
     
     public void Quicksort(int matrix[], int a, int b){
        int buf;
        int from = a;
        int to = b;
        int pivot = matrix[(from+to)/2];
        do
        {
            while(matrix[from] < pivot){
                from++;
            }
            
            while(matrix[to] > pivot){
                to--;
            }
            
            if(from <= to){
                buf = matrix[from];
                matrix[from] = matrix[to];
                matrix[to] = buf;
                from++; to--;
            }
        }while(from <= to);
        if(a < to) {
            Quicksort(matrix, a, to);
        }
        if(from < b){
            Quicksort(matrix, from, b);
        }
    }
}
