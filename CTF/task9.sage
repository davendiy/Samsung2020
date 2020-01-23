
"""
k1 = GF(2)
R1.<x> = k1[]
(x^8 + x^7 + x^5 + x^4 + 1).is_irreducible()
F1 = k1.extension(x^8 + x^7 + x^5 + x^4 + 1, 'a')
k2 = GF(2)
R2.<x> = k2[]
F2 = k2.extension(x^8 + x^7 + x^2 + x + 1, 'b')
(x^8 + x^7 + x^2 + x + 1).is_irreducible()
g1 = F1.multiplicative_generator()
g2 = F2.multiplicative_generator()
j = 0
k = 0
for i in range(255):
    j = j + 1
    k = j * 4
    g = g1 ^ j
    h = g2 ^ k
    print(hex(g.integer_representation()), hex(h.integer_representation()))
"""

def from_hex(finite_field_unit, el):
    tmp = bin(el)[2:][::-1]
    res = 0
    for i, el in enumerate(tmp):
        if el == '1':
            res += finite_field_unit ^ i

    return res


def to_hex(el):
    return int(''.join(map(str, list(el)[::-1])), 2)


BaseRing.<x> = PolynomialRing(GF(2))
F1.<x1> = BaseRing.quotient(x^8+x^7+x^5+x^4+1)
F2.<x2> = BaseRing.quotient(x^8+x^7+x^2+x+1)

target = from_hex(x2, 0xf9)
source = from_hex(x1, 0x5c)

 # == x2 => we can represent each element of F2
 # as a polynomial of target ^ 5 + target + 1 =>
 # the representation of corresponding plain text will be the same
 # (if we subtitute the target with source)
print("here is x2:", target ^ 5 + target + 1)

key = source ^ 5 + source + 1

cipher_text = [0x84, 0xB0, 0xDE, 0x09, 0x58, 0xC7, 0x21, 0x53, 0xC7, 0xCE, 0x09, 0x21, 0x3D, 0xC7, 0x09, 0xEE, 0xC7, 0x0E, 0x09, 0xCE, 0xCD, 0x9A, 0xB0, 0xFF, 0x9A, 0xB0, 0xFF, 0xDA,]

res = []

for _el in cipher_text:
    tmp_res = F1(0)
    el = from_hex(x2, _el)
    for power, x in enumerate(list(el)):
        if x == 1:
            tmp_res += key ^ power
    print(_el, el, tmp_res)
    res.append(to_hex(tmp_res))

print(res)
print(bytes(res))
