# seddett
A reimplementation of emmett (zen coding) in sed and sh.

## How does it work

```
$ zsc 'div>div'
<div>
  <div>
  </div>
</div>
```

* There are no `{}`, to pass content into tags put it in stdin to seddett
* `#element-id` expands to `id="element-id"`
* `.element-id` expands to `class="element-id"`
* `[foo=bar]` expands to `foo="bar"`
* to provide an alternative to `b*5` (not implemented), a companion script called multiply (zmul) is provided.
  It works like `$(echo 'div' | zmul 5)` which expands to div+div+div+div+div. At the moment it can't detect
  numbers under two, so `echo 'div' | zmul 1` yields an empty result.


## License

MIT License. 2017, Teodoro Santoni.
THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
