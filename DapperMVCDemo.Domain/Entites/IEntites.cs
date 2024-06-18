using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DapperMVCDemo.Domain.Entites
{
    public interface IEntites<T>
    {
        T Id { get; set; }
    }
}
