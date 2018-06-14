#include<jni.h>
#include<stdio.h>
#include "TestJNI.h"
#include<math.h>
JNIEXPORT jfloat JNICALL Java_TestJNI_add(JNIEnv *env, jobject obj, jint n1, jint n2)
{
	return n1+n2;
}
JNIEXPORT jfloat JNICALL Java_TestJNI_sub(JNIEnv *env, jobject obj, jint n1, jint n2)
{
	return n1-n2;
}
JNIEXPORT jfloat JNICALL Java_TestJNI_mul(JNIEnv *env, jobject obj, jint n1, jint n2)
{
	return n1*n2;
}
JNIEXPORT jfloat JNICALL Java_TestJNI_div(JNIEnv *env, jobject obj, jint n1, jint n2)
{
	return n1/n2;
}
JNIEXPORT jint JNICALL Java_TestJNI_fact(JNIEnv *env, jobject obj, jint n)
{
	jint i=0;
	jint fact=1;
	for(i=1;i<n;i++)
	{
		fact=fact+fact*i;
	}
	return fact;
}
JNIEXPORT jfloat JNICALL Java_TestJNI_sin(JNIEnv *env, jobject obj, jint n)
{
	return sin(n);
}
