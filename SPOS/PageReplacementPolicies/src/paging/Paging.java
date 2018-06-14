package paging;

import java.util.*;

public class Paging {

    static int page_fault = 0;
    static int page_hit = 0;
    static int page[], frame[];
    static int n = 0, frame_size = 0;

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        page = new int[]{7, 0, 1, 2, 0, 3, 0, 4, 2, 3, 0, 3, 2, 1, 2, 0, 1, 7, 0, 1};
        n = page.length;
        frame_size = 4;
        frame = new int[frame_size];

        while (true) {
            for (int i = 0; i < frame_size; i++) {
                frame[i] = -1;
            }
            System.out.println("Enter choice:\n1.LRU\n2.Optimal\n4.Exit");
            int choice = sc.nextInt();
            switch (choice) {
                case 1:
                    page_fault = 0;
                    page_hit = 0;
                    int position = 0;
                    for (int i = 0; i < n; i++) {
                        if (i == 0) {
                            frame[i] = page[i];
                            page_fault++;
                        }
                        else {
                            position = backward_distance(frame, page, page[i], frame_size, i);
                            frame[position] = page[i];
                        }
                    }
                    System.out.println("Page Fault: " + page_fault);
                    System.out.println("Page hit: " + page_hit);
                    break;

                case 2:
                    page_fault = 0;
                    page_hit = 0;
                    position = 0;
                    for (int i = 0; i < n; i++) {
                        if (i == 0) {
                            frame[i] = page[i];
                            page_fault++;
                        }
                        else {
                            position = forward_distance(frame, page, page[i], frame_size, i);
                            frame[position] = page[i];
                        }
                    }
                    System.out.println("Page Fault: " + page_fault);
                    System.out.println("Page hit: " + page_hit);
                    break;

                case 4:
                    System.exit(0);
                    break;
            }
        }
    }

    public static int backward_distance(int frame[], int allpage[], int page, int frame_size, int index) {
        
        for (int i = 0; i < frame_size; i++) {
            if (frame[i] == page) {
                page_hit++;
                return i;
            } else if (frame[i] == -1) {
                page_fault++;
                return i;
            }
        }
        
        int[] back_dist = new int[frame_size];
        
        int count = 0;
        for (int i = 0; i < frame_size; i++) {
            count = 0;
            for (int j = index; j > 0; j--) {
                if (frame[i] == allpage[j]) {
                    break;
                }
                count++;
            }
            back_dist[i] = count;
        }
        count = 0;
        int max_dist = back_dist[0];
        
        //max_dist=Collections.max(Arrays.asList(back_dist));
        for (int i = 1; i < frame_size; i++) {
            if (back_dist[i] > max_dist) {
                max_dist = back_dist[i];
                count = i;
            }
        }
        page_fault++;
        return count;
    }

    public static int forward_distance(int frame[], int allpage[], int page, int frame_size, int index) {
        for (int i = 0; i < frame_size; i++) {
            if (frame[i] == page) {
                page_hit++;
                return i;
            } else if (frame[i] == -1) {
                page_fault++;
                return i;
            }
        }
        int[] for_dist = new int[frame_size];
        int count = 1;
        for (int i = 0; i < frame_size; i++) {
            count = 1;
            for (int j = index; j < n; j++) {
                if (frame[i] == allpage[j]) {
                    break;
                }
                count++;
            }
            for_dist[i] = count;
        }
        count = 0;
        int max_dist = for_dist[0];
        for (int i = 1; i < frame_size; i++) {
            if (max_dist < for_dist[i]) {
                max_dist = for_dist[i];
                count = i;
            }
        }
        page_fault++;
        return count;
    }
}
