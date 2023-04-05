#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

// 0----------4-----------8---------12---------16
// |  size    | capacity  |        data        |
// ---------------------------------------------
typedef struct dynamic_array {
  uint8_t *data;
  uint8_t size;
  uint8_t capacity;
} dynamic_array_t;

// initialize a new dynamic array
dynamic_array_t *new (uint8_t capacity) {
  dynamic_array_t *array = malloc(sizeof(dynamic_array_t));
  array->data = malloc(capacity * sizeof(uint8_t));
  array->size = 0;
  array->capacity = capacity;
  return array;
}

// release all memory that was allocated
void free_array(dynamic_array_t *array) {
  free(array->data);
  free(array);
}

// add element at the end of the array 
void push_back(dynamic_array_t *array, uint8_t element) {
  // if the array is full we need to reallocate memory
  // where the capacity will be doubled
  if (array->size == array->capacity) {
    uint8_t *new_data = malloc(array->capacity * 2 * sizeof(uint8_t));
    // copy all elements of the array data to the new data
    uint8_t *source = array->data;
    uint8_t *destination = new_data;
    uint8_t *end = source + array->size;
    while (source < end) {
      *destination++ = *source++;
    }

    free(array->data);
    array->data = new_data;
    array->capacity *= 2;
  }

  array->data[array->size] = element;
  array->size++;
}

// remove last element
void pop_back(dynamic_array_t *array) {
  if (array->size == 0) {
    printf("Error: empty array!");
    exit(1);
  }
  // only needed subtract size of the one because it doesnt matter that there
  // is in memory;
  array->size--;
}

uint8_t get_element(dynamic_array_t *array, uint8_t index) {
  if(index < 0 || index >= array->size) {
    printf("Error: pos out of range!");
    exit(1);
  }
  return *(array->data + index);
}

int main(int argc, char *argv[]) {
  dynamic_array_t *array = new (10);

  // fill array with 10 items
  for(uint64_t i = 0; i < 10; i++ ) {
    push_back(array, (i * 2) + 15);
  }

  // get element from the index 2
  printf("%d\n", get_element(array, 2));
  
  // get element from the index 5
  printf("%d\n", get_element(array, 5));

  printf("\n");

  // release dynamic array memory
  free_array(array);

  return 0;
}
