; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: %if x86-registered-target %{ opt -S --passes=slp-vectorizer < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt -S --passes=slp-vectorizer < %s -mtriple=aarch64-unknown-linux-gnu | FileCheck %s %}


define i1 @test(i32 %0, i32 %1, i32 %p) {
; CHECK-LABEL: define i1 @test(
; CHECK-SAME: i32 [[TMP0:%.*]], i32 [[TMP1:%.*]], i32 [[P:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp sgt i32 [[TMP0]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = insertelement <4 x i32> poison, i32 [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP4:%.*]] = shl <4 x i32> zeroinitializer, [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp slt <4 x i32> [[TMP4]], zeroinitializer
; CHECK-NEXT:    [[CMP6:%.*]] = icmp slt i32 0, [[P]]
; CHECK-NEXT:    [[TMP6:%.*]] = freeze <4 x i1> [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> [[TMP6]])
; CHECK-NEXT:    [[OP_RDX:%.*]] = select i1 [[TMP7]], i1 true, i1 [[CMP6]]
; CHECK-NEXT:    [[OP_RDX1:%.*]] = select i1 [[CMP1]], i1 true, i1 [[CMP1]]
; CHECK-NEXT:    [[TMP8:%.*]] = freeze i1 [[OP_RDX]]
; CHECK-NEXT:    [[OP_RDX2:%.*]] = select i1 [[TMP8]], i1 true, i1 [[OP_RDX1]]
; CHECK-NEXT:    ret i1 [[OP_RDX2]]
;
entry:
  %cmp1 = icmp sgt i32 %0, 0
  %shl1 = shl i32 0, %1
  %cmp2 = icmp slt i32 %shl1, 0
  %2 = select i1 %cmp1, i1 true, i1 %cmp2
  %shl2 = shl i32 0, %1
  %cmp3 = icmp slt i32 %shl2, 0
  %3 = select i1 %2, i1 true, i1 %cmp3
  %shl3 = shl i32 0, %1
  %cmp4 = icmp slt i32 %shl3, 0
  %4 = select i1 %3, i1 true, i1 %cmp4
  %shl4 = shl i32 0, %1
  %cmp5 = icmp slt i32 %shl4, 0
  %5 = select i1 %4, i1 true, i1 %cmp5
  %cmp6 = icmp slt i32 0, %p
  %sel = select i1 %cmp1, i1 true, i1 %cmp6
  %6 = or i1 %sel, %5
  ret i1 %6
}
