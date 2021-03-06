module bio.std.maf.parser;
#line 1 "maf_block.rl"
/*
    This file is part of BioD.
    Copyright (C) 2013    Artem Tarasov <lomereiter@gmail.com>

    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.

*/
import std.conv;
import std.array;
import bio.std.maf.block;


#line 27 "maf_block.d"
static byte[] _maf_block_actions = [
	0, 1, 1, 1, 2, 1, 5, 1, 
	6, 1, 7, 1, 8, 1, 9, 1, 
	10, 1, 11, 1, 12, 1, 14, 1, 
	16, 1, 17, 1, 18, 1, 19, 1, 
	20, 1, 21, 1, 22, 2, 0, 1, 
	2, 3, 4, 2, 7, 13, 2, 15, 
	12
];

static short[] _maf_block_key_offsets = [
	0, 0, 1, 5, 11, 20, 23, 26, 
	29, 34, 39, 44, 49, 54, 57, 62, 
	67, 74, 77, 80, 83, 92, 95, 100, 
	105, 114, 117, 122, 127, 132, 137, 142, 
	147, 152, 157, 162, 167, 172, 177, 182, 
	187, 192, 197, 202, 205, 208, 211, 214, 
	221, 224, 227, 230, 235, 240, 245, 250, 
	255, 258, 263, 268, 271, 276, 281, 286, 
	291, 296, 301, 306, 311, 316, 321, 326, 
	331, 336, 341, 346, 351, 354, 359, 364, 
	369, 374, 379, 384, 389, 394, 399, 404, 
	409, 414, 419, 424, 429, 434, 437, 442, 
	447, 452, 457, 462, 467, 472, 477, 482, 
	487, 492, 497, 502, 507, 512, 517, 520, 
	525, 530, 535, 540, 545, 550, 555, 560, 
	565, 570, 575, 580, 585, 590, 595, 600, 
	603, 608, 613, 618, 623, 628, 633, 638, 
	643, 648, 653, 658, 663, 668, 673, 678, 
	683, 686, 691, 696, 701, 706, 711, 716, 
	721, 726, 731, 736, 741, 746, 751, 756, 
	761, 766, 769, 770, 771, 772, 773, 775, 
	781, 787, 793, 799, 805, 811, 817, 823, 
	829, 835, 841, 847, 853, 859, 865, 871, 
	877, 881, 885, 886, 887, 888, 889, 896, 
	900, 902, 910, 914, 916, 922, 931, 932, 
	933, 937, 938, 939, 940, 944, 948, 956, 
	962, 968, 974, 980, 986, 992, 998, 1004, 
	1010, 1016, 1022, 1028, 1034, 1040, 1046, 1052, 
	1058, 1062, 1070
];

static char[] _maf_block_trans_keys = [
	97u, 10u, 32u, 9u, 13u, 10u, 32u, 112u, 
	115u, 9u, 13u, 10u, 32u, 101u, 105u, 112u, 
	113u, 115u, 9u, 13u, 32u, 9u, 13u, 32u, 
	9u, 13u, 32u, 9u, 13u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 43u, 45u, 9u, 13u, 32u, 9u, 
	13u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 67u, 73u, 77u, 110u, 
	9u, 13u, 32u, 9u, 13u, 32u, 9u, 13u, 
	32u, 9u, 13u, 32u, 67u, 73u, 84u, 110u, 
	9u, 13u, 77u, 78u, 32u, 9u, 13u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 67u, 73u, 84u, 110u, 9u, 13u, 
	77u, 78u, 32u, 9u, 13u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 32u, 9u, 13u, 
	32u, 9u, 13u, 32u, 9u, 13u, 32u, 45u, 
	70u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	32u, 9u, 13u, 32u, 9u, 13u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 43u, 45u, 9u, 13u, 32u, 
	9u, 13u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 48u, 57u, 32u, 9u, 13u, 48u, 57u, 
	32u, 9u, 13u, 48u, 57u, 32u, 9u, 13u, 
	48u, 57u, 32u, 9u, 13u, 48u, 57u, 32u, 
	9u, 13u, 48u, 57u, 32u, 9u, 13u, 48u, 
	57u, 32u, 9u, 13u, 48u, 57u, 32u, 9u, 
	13u, 97u, 115u, 115u, 61u, 48u, 57u, 10u, 
	32u, 9u, 13u, 48u, 57u, 10u, 32u, 9u, 
	13u, 48u, 57u, 10u, 32u, 9u, 13u, 48u, 
	57u, 10u, 32u, 9u, 13u, 48u, 57u, 10u, 
	32u, 9u, 13u, 48u, 57u, 10u, 32u, 9u, 
	13u, 48u, 57u, 10u, 32u, 9u, 13u, 48u, 
	57u, 10u, 32u, 9u, 13u, 48u, 57u, 10u, 
	32u, 9u, 13u, 48u, 57u, 10u, 32u, 9u, 
	13u, 48u, 57u, 10u, 32u, 9u, 13u, 48u, 
	57u, 10u, 32u, 9u, 13u, 48u, 57u, 10u, 
	32u, 9u, 13u, 48u, 57u, 10u, 32u, 9u, 
	13u, 48u, 57u, 10u, 32u, 9u, 13u, 48u, 
	57u, 10u, 32u, 9u, 13u, 48u, 57u, 10u, 
	32u, 9u, 13u, 48u, 57u, 10u, 32u, 9u, 
	13u, 32u, 99u, 9u, 13u, 111u, 114u, 101u, 
	61u, 43u, 45u, 46u, 105u, 110u, 48u, 57u, 
	46u, 105u, 48u, 57u, 48u, 57u, 10u, 32u, 
	69u, 101u, 9u, 13u, 48u, 57u, 43u, 45u, 
	48u, 57u, 48u, 57u, 10u, 32u, 9u, 13u, 
	48u, 57u, 10u, 32u, 46u, 69u, 101u, 9u, 
	13u, 48u, 57u, 110u, 102u, 10u, 32u, 9u, 
	13u, 97u, 110u, 99u, 10u, 32u, 9u, 13u, 
	10u, 32u, 9u, 13u, 10u, 32u, 101u, 105u, 
	113u, 115u, 9u, 13u, 10u, 32u, 9u, 13u, 
	48u, 57u, 10u, 32u, 9u, 13u, 48u, 57u, 
	10u, 32u, 9u, 13u, 48u, 57u, 10u, 32u, 
	9u, 13u, 48u, 57u, 10u, 32u, 9u, 13u, 
	48u, 57u, 10u, 32u, 9u, 13u, 48u, 57u, 
	10u, 32u, 9u, 13u, 48u, 57u, 10u, 32u, 
	9u, 13u, 48u, 57u, 10u, 32u, 9u, 13u, 
	48u, 57u, 10u, 32u, 9u, 13u, 48u, 57u, 
	10u, 32u, 9u, 13u, 48u, 57u, 10u, 32u, 
	9u, 13u, 48u, 57u, 10u, 32u, 9u, 13u, 
	48u, 57u, 10u, 32u, 9u, 13u, 48u, 57u, 
	10u, 32u, 9u, 13u, 48u, 57u, 10u, 32u, 
	9u, 13u, 48u, 57u, 10u, 32u, 9u, 13u, 
	48u, 57u, 10u, 32u, 9u, 13u, 10u, 32u, 
	45u, 70u, 9u, 13u, 48u, 57u, 10u, 32u, 
	9u, 13u, 0
];

static byte[] _maf_block_single_lengths = [
	0, 1, 2, 4, 7, 1, 1, 1, 
	1, 1, 1, 1, 3, 1, 1, 1, 
	5, 1, 1, 1, 5, 1, 1, 1, 
	5, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 3, 
	1, 1, 1, 1, 1, 1, 1, 3, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 1, 0, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 1, 1, 1, 1, 5, 2, 
	0, 4, 2, 0, 2, 5, 1, 1, 
	2, 1, 1, 1, 2, 2, 6, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 4, 2
];

static byte[] _maf_block_range_lengths = [
	0, 0, 1, 1, 1, 1, 1, 1, 
	2, 2, 2, 2, 1, 1, 2, 2, 
	1, 1, 1, 1, 2, 1, 2, 2, 
	2, 1, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 1, 1, 1, 1, 2, 
	1, 1, 1, 2, 2, 2, 2, 1, 
	1, 2, 2, 1, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 1, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 1, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 1, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 1, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	1, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 1, 0, 0, 0, 0, 1, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	1, 1, 0, 0, 0, 0, 1, 1, 
	1, 2, 1, 1, 2, 2, 0, 0, 
	1, 0, 0, 0, 1, 1, 1, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	2, 2, 2, 2, 2, 2, 2, 2, 
	1, 2, 1
];

static short[] _maf_block_index_offsets = [
	0, 0, 2, 6, 12, 21, 24, 27, 
	30, 34, 38, 42, 46, 51, 54, 58, 
	62, 69, 72, 75, 78, 86, 89, 93, 
	97, 105, 108, 112, 116, 120, 124, 128, 
	132, 136, 140, 144, 148, 152, 156, 160, 
	164, 168, 172, 176, 179, 182, 185, 188, 
	194, 197, 200, 203, 207, 211, 215, 219, 
	224, 227, 231, 235, 238, 242, 246, 250, 
	254, 258, 262, 266, 270, 274, 278, 282, 
	286, 290, 294, 298, 302, 305, 309, 313, 
	317, 321, 325, 329, 333, 337, 341, 345, 
	349, 353, 357, 361, 365, 369, 372, 376, 
	380, 384, 388, 392, 396, 400, 404, 408, 
	412, 416, 420, 424, 428, 432, 436, 439, 
	443, 447, 451, 455, 459, 463, 467, 471, 
	475, 479, 483, 487, 491, 495, 499, 503, 
	506, 510, 514, 518, 522, 526, 530, 534, 
	538, 542, 546, 550, 554, 558, 562, 566, 
	570, 573, 577, 581, 585, 589, 593, 597, 
	601, 605, 609, 613, 617, 621, 625, 629, 
	633, 637, 640, 642, 644, 646, 648, 650, 
	655, 660, 665, 670, 675, 680, 685, 690, 
	695, 700, 705, 710, 715, 720, 725, 730, 
	735, 739, 743, 745, 747, 749, 751, 758, 
	762, 764, 771, 775, 777, 782, 790, 792, 
	794, 798, 800, 802, 804, 808, 812, 820, 
	825, 830, 835, 840, 845, 850, 855, 860, 
	865, 870, 875, 880, 885, 890, 895, 900, 
	905, 909, 916
];

static ubyte[] _maf_block_trans_targs = [
	2, 0, 4, 3, 3, 0, 4, 3, 
	162, 203, 3, 0, 4, 3, 5, 17, 
	162, 44, 185, 3, 0, 6, 6, 0, 
	6, 6, 7, 8, 8, 7, 8, 8, 
	9, 0, 10, 10, 145, 0, 10, 10, 
	11, 0, 12, 12, 128, 0, 12, 13, 
	13, 12, 0, 14, 14, 0, 14, 14, 
	15, 0, 16, 16, 111, 0, 16, 204, 
	204, 204, 204, 16, 0, 18, 18, 0, 
	18, 18, 19, 20, 20, 19, 20, 21, 
	21, 21, 21, 20, 21, 0, 22, 22, 
	0, 22, 22, 23, 0, 24, 24, 27, 
	0, 24, 25, 25, 25, 25, 24, 25, 
	0, 26, 26, 0, 26, 26, 207, 0, 
	24, 24, 28, 0, 24, 24, 29, 0, 
	24, 24, 30, 0, 24, 24, 31, 0, 
	24, 24, 32, 0, 24, 24, 33, 0, 
	24, 24, 34, 0, 24, 24, 35, 0, 
	24, 24, 36, 0, 24, 24, 37, 0, 
	24, 24, 38, 0, 24, 24, 39, 0, 
	24, 24, 40, 0, 24, 24, 41, 0, 
	24, 24, 42, 0, 24, 24, 43, 0, 
	24, 24, 0, 45, 45, 0, 45, 45, 
	46, 47, 47, 46, 47, 225, 225, 47, 
	225, 0, 49, 49, 0, 49, 49, 50, 
	51, 51, 50, 51, 51, 52, 0, 53, 
	53, 94, 0, 53, 53, 54, 0, 55, 
	55, 77, 0, 55, 56, 56, 55, 0, 
	57, 57, 0, 57, 57, 58, 0, 59, 
	59, 60, 0, 59, 59, 226, 59, 59, 
	61, 0, 59, 59, 62, 0, 59, 59, 
	63, 0, 59, 59, 64, 0, 59, 59, 
	65, 0, 59, 59, 66, 0, 59, 59, 
	67, 0, 59, 59, 68, 0, 59, 59, 
	69, 0, 59, 59, 70, 0, 59, 59, 
	71, 0, 59, 59, 72, 0, 59, 59, 
	73, 0, 59, 59, 74, 0, 59, 59, 
	75, 0, 59, 59, 76, 0, 59, 59, 
	0, 55, 55, 78, 0, 55, 55, 79, 
	0, 55, 55, 80, 0, 55, 55, 81, 
	0, 55, 55, 82, 0, 55, 55, 83, 
	0, 55, 55, 84, 0, 55, 55, 85, 
	0, 55, 55, 86, 0, 55, 55, 87, 
	0, 55, 55, 88, 0, 55, 55, 89, 
	0, 55, 55, 90, 0, 55, 55, 91, 
	0, 55, 55, 92, 0, 55, 55, 93, 
	0, 55, 55, 0, 53, 53, 95, 0, 
	53, 53, 96, 0, 53, 53, 97, 0, 
	53, 53, 98, 0, 53, 53, 99, 0, 
	53, 53, 100, 0, 53, 53, 101, 0, 
	53, 53, 102, 0, 53, 53, 103, 0, 
	53, 53, 104, 0, 53, 53, 105, 0, 
	53, 53, 106, 0, 53, 53, 107, 0, 
	53, 53, 108, 0, 53, 53, 109, 0, 
	53, 53, 110, 0, 53, 53, 0, 16, 
	16, 112, 0, 16, 16, 113, 0, 16, 
	16, 114, 0, 16, 16, 115, 0, 16, 
	16, 116, 0, 16, 16, 117, 0, 16, 
	16, 118, 0, 16, 16, 119, 0, 16, 
	16, 120, 0, 16, 16, 121, 0, 16, 
	16, 122, 0, 16, 16, 123, 0, 16, 
	16, 124, 0, 16, 16, 125, 0, 16, 
	16, 126, 0, 16, 16, 127, 0, 16, 
	16, 0, 12, 12, 129, 0, 12, 12, 
	130, 0, 12, 12, 131, 0, 12, 12, 
	132, 0, 12, 12, 133, 0, 12, 12, 
	134, 0, 12, 12, 135, 0, 12, 12, 
	136, 0, 12, 12, 137, 0, 12, 12, 
	138, 0, 12, 12, 139, 0, 12, 12, 
	140, 0, 12, 12, 141, 0, 12, 12, 
	142, 0, 12, 12, 143, 0, 12, 12, 
	144, 0, 12, 12, 0, 10, 10, 146, 
	0, 10, 10, 147, 0, 10, 10, 148, 
	0, 10, 10, 149, 0, 10, 10, 150, 
	0, 10, 10, 151, 0, 10, 10, 152, 
	0, 10, 10, 153, 0, 10, 10, 154, 
	0, 10, 10, 155, 0, 10, 10, 156, 
	0, 10, 10, 157, 0, 10, 10, 158, 
	0, 10, 10, 159, 0, 10, 10, 160, 
	0, 10, 10, 161, 0, 10, 10, 0, 
	163, 0, 164, 0, 165, 0, 166, 0, 
	167, 0, 4, 3, 3, 168, 0, 4, 
	3, 3, 169, 0, 4, 3, 3, 170, 
	0, 4, 3, 3, 171, 0, 4, 3, 
	3, 172, 0, 4, 3, 3, 173, 0, 
	4, 3, 3, 174, 0, 4, 3, 3, 
	175, 0, 4, 3, 3, 176, 0, 4, 
	3, 3, 177, 0, 4, 3, 3, 178, 
	0, 4, 3, 3, 179, 0, 4, 3, 
	3, 180, 0, 4, 3, 3, 181, 0, 
	4, 3, 3, 182, 0, 4, 3, 3, 
	183, 0, 4, 3, 3, 184, 0, 4, 
	3, 3, 0, 49, 186, 49, 0, 187, 
	0, 188, 0, 189, 0, 190, 0, 191, 
	191, 192, 198, 201, 197, 0, 192, 198, 
	197, 0, 193, 0, 4, 3, 194, 194, 
	3, 193, 0, 195, 195, 196, 0, 196, 
	0, 4, 3, 3, 196, 0, 4, 3, 
	192, 194, 194, 3, 197, 0, 199, 0, 
	200, 0, 4, 3, 3, 0, 202, 0, 
	200, 0, 186, 0, 206, 205, 205, 0, 
	206, 205, 205, 0, 206, 205, 5, 17, 
	44, 48, 205, 0, 206, 205, 205, 208, 
	0, 206, 205, 205, 209, 0, 206, 205, 
	205, 210, 0, 206, 205, 205, 211, 0, 
	206, 205, 205, 212, 0, 206, 205, 205, 
	213, 0, 206, 205, 205, 214, 0, 206, 
	205, 205, 215, 0, 206, 205, 205, 216, 
	0, 206, 205, 205, 217, 0, 206, 205, 
	205, 218, 0, 206, 205, 205, 219, 0, 
	206, 205, 205, 220, 0, 206, 205, 205, 
	221, 0, 206, 205, 205, 222, 0, 206, 
	205, 205, 223, 0, 206, 205, 205, 224, 
	0, 206, 205, 205, 0, 206, 205, 225, 
	225, 205, 225, 0, 206, 205, 205, 226, 
	0
];

static byte[] _maf_block_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 7, 9, 9, 0, 0, 0, 
	37, 0, 11, 11, 1, 0, 0, 0, 
	37, 0, 13, 13, 1, 0, 0, 15, 
	15, 0, 0, 0, 0, 0, 0, 0, 
	37, 0, 17, 17, 1, 0, 0, 31, 
	31, 31, 31, 0, 0, 0, 0, 0, 
	0, 0, 7, 43, 43, 0, 0, 23, 
	23, 23, 23, 0, 23, 0, 0, 0, 
	0, 0, 0, 37, 0, 25, 25, 1, 
	0, 0, 27, 27, 27, 27, 0, 27, 
	0, 0, 0, 0, 0, 0, 37, 0, 
	25, 25, 1, 0, 25, 25, 1, 0, 
	25, 25, 1, 0, 25, 25, 1, 0, 
	25, 25, 1, 0, 25, 25, 1, 0, 
	25, 25, 1, 0, 25, 25, 1, 0, 
	25, 25, 1, 0, 25, 25, 1, 0, 
	25, 25, 1, 0, 25, 25, 1, 0, 
	25, 25, 1, 0, 25, 25, 1, 0, 
	25, 25, 1, 0, 25, 25, 1, 0, 
	25, 25, 0, 0, 0, 0, 0, 0, 
	7, 43, 43, 0, 0, 33, 33, 0, 
	33, 0, 0, 0, 0, 0, 0, 7, 
	9, 9, 0, 0, 0, 37, 0, 11, 
	11, 1, 0, 0, 0, 37, 0, 13, 
	13, 1, 0, 0, 15, 15, 0, 0, 
	0, 0, 0, 0, 0, 37, 0, 17, 
	17, 1, 0, 0, 0, 21, 17, 17, 
	1, 0, 17, 17, 1, 0, 17, 17, 
	1, 0, 17, 17, 1, 0, 17, 17, 
	1, 0, 17, 17, 1, 0, 17, 17, 
	1, 0, 17, 17, 1, 0, 17, 17, 
	1, 0, 17, 17, 1, 0, 17, 17, 
	1, 0, 17, 17, 1, 0, 17, 17, 
	1, 0, 17, 17, 1, 0, 17, 17, 
	1, 0, 17, 17, 1, 0, 17, 17, 
	0, 13, 13, 1, 0, 13, 13, 1, 
	0, 13, 13, 1, 0, 13, 13, 1, 
	0, 13, 13, 1, 0, 13, 13, 1, 
	0, 13, 13, 1, 0, 13, 13, 1, 
	0, 13, 13, 1, 0, 13, 13, 1, 
	0, 13, 13, 1, 0, 13, 13, 1, 
	0, 13, 13, 1, 0, 13, 13, 1, 
	0, 13, 13, 1, 0, 13, 13, 1, 
	0, 13, 13, 0, 11, 11, 1, 0, 
	11, 11, 1, 0, 11, 11, 1, 0, 
	11, 11, 1, 0, 11, 11, 1, 0, 
	11, 11, 1, 0, 11, 11, 1, 0, 
	11, 11, 1, 0, 11, 11, 1, 0, 
	11, 11, 1, 0, 11, 11, 1, 0, 
	11, 11, 1, 0, 11, 11, 1, 0, 
	11, 11, 1, 0, 11, 11, 1, 0, 
	11, 11, 1, 0, 11, 11, 0, 17, 
	17, 1, 0, 17, 17, 1, 0, 17, 
	17, 1, 0, 17, 17, 1, 0, 17, 
	17, 1, 0, 17, 17, 1, 0, 17, 
	17, 1, 0, 17, 17, 1, 0, 17, 
	17, 1, 0, 17, 17, 1, 0, 17, 
	17, 1, 0, 17, 17, 1, 0, 17, 
	17, 1, 0, 17, 17, 1, 0, 17, 
	17, 1, 0, 17, 17, 1, 0, 17, 
	17, 0, 13, 13, 1, 0, 13, 13, 
	1, 0, 13, 13, 1, 0, 13, 13, 
	1, 0, 13, 13, 1, 0, 13, 13, 
	1, 0, 13, 13, 1, 0, 13, 13, 
	1, 0, 13, 13, 1, 0, 13, 13, 
	1, 0, 13, 13, 1, 0, 13, 13, 
	1, 0, 13, 13, 1, 0, 13, 13, 
	1, 0, 13, 13, 1, 0, 13, 13, 
	1, 0, 13, 13, 0, 11, 11, 1, 
	0, 11, 11, 1, 0, 11, 11, 1, 
	0, 11, 11, 1, 0, 11, 11, 1, 
	0, 11, 11, 1, 0, 11, 11, 1, 
	0, 11, 11, 1, 0, 11, 11, 1, 
	0, 11, 11, 1, 0, 11, 11, 1, 
	0, 11, 11, 1, 0, 11, 11, 1, 
	0, 11, 11, 1, 0, 11, 11, 1, 
	0, 11, 11, 1, 0, 11, 11, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	37, 0, 5, 5, 5, 1, 0, 5, 
	5, 5, 1, 0, 5, 5, 5, 1, 
	0, 5, 5, 5, 1, 0, 5, 5, 
	5, 1, 0, 5, 5, 5, 1, 0, 
	5, 5, 5, 1, 0, 5, 5, 5, 
	1, 0, 5, 5, 5, 1, 0, 5, 
	5, 5, 1, 0, 5, 5, 5, 1, 
	0, 5, 5, 5, 1, 0, 5, 5, 
	5, 1, 0, 5, 5, 5, 1, 0, 
	5, 5, 5, 1, 0, 5, 5, 5, 
	1, 0, 5, 5, 5, 1, 0, 5, 
	5, 5, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 3, 
	3, 3, 3, 3, 3, 0, 0, 0, 
	0, 0, 0, 0, 40, 40, 0, 0, 
	40, 0, 0, 0, 0, 0, 0, 0, 
	0, 40, 40, 40, 0, 0, 40, 40, 
	0, 0, 0, 40, 0, 0, 0, 0, 
	0, 0, 40, 40, 40, 0, 0, 0, 
	0, 0, 0, 0, 19, 19, 19, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 29, 29, 29, 1, 
	0, 29, 29, 29, 1, 0, 29, 29, 
	29, 1, 0, 29, 29, 29, 1, 0, 
	29, 29, 29, 1, 0, 29, 29, 29, 
	1, 0, 29, 29, 29, 1, 0, 29, 
	29, 29, 1, 0, 29, 29, 29, 1, 
	0, 29, 29, 29, 1, 0, 29, 29, 
	29, 1, 0, 29, 29, 29, 1, 0, 
	29, 29, 29, 1, 0, 29, 29, 29, 
	1, 0, 29, 29, 29, 1, 0, 29, 
	29, 29, 1, 0, 29, 29, 29, 1, 
	0, 29, 29, 29, 0, 35, 35, 0, 
	0, 35, 0, 0, 46, 46, 46, 0, 
	0
];

static byte[] _maf_block_eof_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 19, 0, 0, 29, 
	29, 29, 29, 29, 29, 29, 29, 29, 
	29, 29, 29, 29, 29, 29, 29, 29, 
	29, 35, 46
];

static int maf_block_start = 1;
static int maf_block_first_final = 204;
static int maf_block_error = 0;

static int maf_block_en_block = 1;


#line 122 "maf_block.rl"


MafBlock parseMafBlock(string line) {
    char* p = cast(char*)line.ptr;
    char* pe = p + line.length;
    char* eof = pe;
    int cs;

    int current_sign;
    int int_value;
    double float_value;
    size_t float_beg;

    MafBlock block;
    MafSequence sequence;
    auto sequences = Appender!(MafSequence[])();

    size_t src_beg;
    size_t text_beg;
    size_t qual_beg;

    
#line 604 "maf_block.d"
	{
	cs = maf_block_start;
	}

#line 144 "maf_block.rl"
    
#line 611 "maf_block.d"
	{
	int _klen;
	uint _trans;
	byte* _acts;
	uint _nacts;
	char* _keys;

	if ( p == pe )
		goto _test_eof;
	if ( cs == 0 )
		goto _out;
_resume:
	_keys = &_maf_block_trans_keys[_maf_block_key_offsets[cs]];
	_trans = _maf_block_index_offsets[cs];

	_klen = _maf_block_single_lengths[cs];
	if ( _klen > 0 ) {
		char* _lower = _keys;
		char* _mid;
		char* _upper = _keys + _klen - 1;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + ((_upper-_lower) >> 1);
			if ( (*p) < *_mid )
				_upper = _mid - 1;
			else if ( (*p) > *_mid )
				_lower = _mid + 1;
			else {
				_trans += cast(uint)(_mid - _keys);
				goto _match;
			}
		}
		_keys += _klen;
		_trans += _klen;
	}

	_klen = _maf_block_range_lengths[cs];
	if ( _klen > 0 ) {
		char* _lower = _keys;
		char* _mid;
		char* _upper = _keys + (_klen<<1) - 2;
		while (1) {
			if ( _upper < _lower )
				break;

			_mid = _lower + (((_upper-_lower) >> 1) & ~1);
			if ( (*p) < _mid[0] )
				_upper = _mid - 2;
			else if ( (*p) > _mid[1] )
				_lower = _mid + 2;
			else {
				_trans += cast(uint)((_mid - _keys)>>1);
				goto _match;
			}
		}
		_trans += _klen;
	}

_match:
	cs = _maf_block_trans_targs[_trans];

	if ( _maf_block_trans_actions[_trans] == 0 )
		goto _again;

	_acts = &_maf_block_actions[_maf_block_trans_actions[_trans]];
	_nacts = cast(uint) *_acts++;
	while ( _nacts-- > 0 )
	{
		switch ( *_acts++ )
		{
	case 0:
#line 28 "maf_block.rl"
	{ int_value = 0; }
	break;
	case 1:
#line 29 "maf_block.rl"
	{ int_value *= 10; int_value += (*p) - '0'; }
	break;
	case 2:
#line 37 "maf_block.rl"
	{ float_beg = p - line.ptr; }
	break;
	case 3:
#line 38 "maf_block.rl"
	{ 
        float_value = to!float(line[float_beg .. p - line.ptr]);
    }
	break;
	case 4:
#line 46 "maf_block.rl"
	{ block.score = float_value; }
	break;
	case 5:
#line 47 "maf_block.rl"
	{ block.pass = int_value; }
	break;
	case 6:
#line 55 "maf_block.rl"
	{ src_beg = p - line.ptr; }
	break;
	case 7:
#line 56 "maf_block.rl"
	{ sequence.source = line[src_beg .. p - line.ptr]; }
	break;
	case 8:
#line 57 "maf_block.rl"
	{ sequence.start = int_value; }
	break;
	case 9:
#line 58 "maf_block.rl"
	{ sequence.size = int_value; }
	break;
	case 10:
#line 59 "maf_block.rl"
	{ sequence.strand = (*p); }
	break;
	case 11:
#line 60 "maf_block.rl"
	{ sequence.source_size = int_value; }
	break;
	case 12:
#line 61 "maf_block.rl"
	{ sequences.put(sequence); sequence = MafSequence.init; }
	break;
	case 13:
#line 62 "maf_block.rl"
	{ assert(line[src_beg .. p - line.ptr] == sequences.data.back.source); }
	break;
	case 14:
#line 70 "maf_block.rl"
	{ text_beg = p - line.ptr; }
	break;
	case 15:
#line 71 "maf_block.rl"
	{ sequence.text = line[text_beg .. p - line.ptr]; }
	break;
	case 16:
#line 82 "maf_block.rl"
	{ sequences.data.back.left_status = (*p); }
	break;
	case 17:
#line 83 "maf_block.rl"
	{ sequences.data.back.left_count = int_value; }
	break;
	case 18:
#line 84 "maf_block.rl"
	{ sequences.data.back.right_status = (*p); }
	break;
	case 19:
#line 85 "maf_block.rl"
	{ sequences.data.back.right_count = int_value; }
	break;
	case 20:
#line 99 "maf_block.rl"
	{ sequence.empty_status = *p; }
	break;
	case 21:
#line 110 "maf_block.rl"
	{ qual_beg = p - line.ptr; }
	break;
	case 22:
#line 111 "maf_block.rl"
	{ sequences.data.back.quality = line[qual_beg .. p - line.ptr]; }
	break;
#line 778 "maf_block.d"
		default: break;
		}
	}

_again:
	if ( cs == 0 )
		goto _out;
	if ( ++p != pe )
		goto _resume;
	_test_eof: {}
	if ( p == eof )
	{
	byte* __acts = &_maf_block_actions[_maf_block_eof_actions[cs]];
	uint __nacts = cast(uint) *__acts++;
	while ( __nacts-- > 0 ) {
		switch ( *__acts++ ) {
	case 12:
#line 61 "maf_block.rl"
	{ sequences.put(sequence); sequence = MafSequence.init; }
	break;
	case 15:
#line 71 "maf_block.rl"
	{ sequence.text = line[text_beg .. p - line.ptr]; }
	break;
	case 19:
#line 85 "maf_block.rl"
	{ sequences.data.back.right_count = int_value; }
	break;
	case 22:
#line 111 "maf_block.rl"
	{ sequences.data.back.quality = line[qual_beg .. p - line.ptr]; }
	break;
#line 811 "maf_block.d"
		default: break;
		}
	}
	}

	_out: {}
	}

#line 145 "maf_block.rl"

    block.sequences = sequences.data;
    return block;
}
