public class MyClass {
    
    public static void main(String args[]) {
        int[] vector = {2,12,3,21,24,1,54,65,5,26,11,0};
        int salto, aux, i, Count;
        boolean cambios;
  
        for (salto = vector.length / 2; salto != 0; salto = salto / 2) {
            cambios = true;
            while (cambios) {   // Mientras se intercambie algún elemento                                         
                cambios = false;
                for (i = salto; i < vector.length; i++)   // se da una pasada
                {
                    if (vector[i - salto] > vector[i]) {       // y si están desordenados
                        aux = vector[i];                  // se reordenan
                        vector[i] = vector[i - salto];
                        vector[i - salto] = aux;
                        cambios = true;              // y se marca como cambio.                                   
                    }
                }
            }
        }
        for (i=0; i<vector.length; i++){
            System.out.println(vector[i]);
        }
    }
}
/*0, 1, 2, 3, 5, 11, 12, 21, 24, 26, 54, 65*/