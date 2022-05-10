# Chuong trinh nhap xuat mang va tinh tong cac phan tu trong mang
# doxuansang
.data # khai báo du lieu
  mangso: .word 100
  print1: .asciiz "Nhap so luong phan tu: "
  print2: .asciiz "Cac phan tu trong mang: "
  print3: .asciiz "Tong cac phan tu trong mang: "
  phay: .asciiz "; "
  xd: .asciiz "\n"
  
.text # chay chuong trinh
  # Nhap tu ban phim a = s0
  la $a0, print1
  li $v0, 4
  syscall
  li $v0, 5
  syscall
  move $s0, $v0
  move $s1, $s0
  la $t0, mangso
 
# nhap cac phan tu trong mang 
input: # khoi tao 1 vong lap de nhap mang
  beq $s1, 0, output1 #nhap hoan tat, chuyen den ham in ra
  li $v0, 5 #integer
  syscall
  sw $v0, ($t0)
  add $t0, $t0, 4 # xin them vung nho, vì word=4 nen xin them 4
  sub $s1, $s1, 1 # so vong lap con lai
  b input # quay lai dau vong lap
  
# in cac phan tu trong mang
output1:
  la $a0, print2
  li $v0, 4
  syscall
  move $s1, $s0
  la $t0, mangso
  b output2
# vong lap de in lan luot cac phan tu trong mang
output2:  
  beq $s1, 0, end
  lw $t2, ($t0)
  move $a0, $t2
  li $v0, 1
  syscall
  la $a0, phay
  li $v0, 4
  syscall 
  add $t0, $t0, 4
  sub $s1, $s1, 1
  b output2
# ket thuc nhap xuat, reset lai cac gia tri de dung trong ham sum
end:
  move $s1, $s0
  la $t0, mangso
  la $a0, xd
  syscall

# ham tinh tong tat ca phan tu trong mang
sum:  
  beq $s1, 0, return # sau khi cong tat ca phan tu, tra ve ham return
  lw $t2, ($t0)
  move $s2, $t2
  add $s6, $s6, $s2 # s6 = s6 + s2 = s6 + mangso[i]
  add $t0, $t0, 4
  sub $s1, $s1, 1
  b sum
return:
  la $a0, print3
  li $v0, 4
  syscall
  li $v0, 1
  move $a0, $s6
  syscall


  
  


 
 